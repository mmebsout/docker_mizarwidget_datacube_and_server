#1
FROM node:8.10-stretch
#2
LABEL maintainer="IDOC IAS <idoc-docker@ias.u-psud.fr>"

# 3-4 Proxy runtime
ARG HTTP_PROXY
ARG HTTPS_PROXY

# 5-6
ENV http_proxy=$HTTP_PROXY
ENV https_proxy=$HTTPS_PROXY

# 7 Labels (based on http://label-schema.org/rc1/)
LABEL \
        org.label-schema.schema-version="1.0" \
        org.label-schema.name="mizarwidget" \
       	org.label-schema.description="MizarWidget is a client to display planetary/sky data on a virtual globe, DataCube is a plugin that displays hyperspectral datas, DataCubeServer is required to answer DataCube API with files informations." \       
        org.label-schema.url="docker" \
        org.label-schema.vcs-url="https://git.ias.u-psud.fr/mizar/docker_mizarwidget-datacube-and-server" \
        org.label-schema.vcs-ref=master \
        org.label-schema.vendor="IDOC-IAS" \
        org.label-schema.docker.cmd="docker run --name datacube_and_server \
            -d \
            -p 80:80 \
            -p 8000:4200 \
            -p 8081:8081 \
            -v $WORKSPACE_PATH:/data \
            mizarwidget-datacube_and_server" \
        mizarwidget_version=${BUILD_VERSION}

USER root


#----------------------------------------------------------------------------- MIZARWIDGET
#-----------------------------------------------------------------------------------------
#  
ADD scripts/ /tmp/

#  Install the dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get install -y --fix-missing git python-pip \
    && apt-get install -y --fix-missing	ca-certificates nginx

RUN pip install lxml	

# Create the mizarwidget build environment
WORKDIR /tmp
RUN git clone --branch nologinoption https://github.com/mmebsout/MizarWidget.git
WORKDIR /tmp/MizarWidget 
RUN git submodule init && git submodule update
RUN npm install -g grunt-cli grunt

# Build
WORKDIR /tmp/MizarWidget/external/Mizar
RUN npm install \
    && npm run build:prod \
    && npm run doc:create \
    && npm run license

WORKDIR /tmp/MizarWidget/
RUN npm install -g json \
    &&  json -I -f package.json -e "this.scripts['build:prod']='r.js -o build/buildMizarWidget.js'"
RUN npm install
RUN groupadd -r swuser -g 433  \
    && useradd -u 431 -r -g swuser -d /tmp/ -s /sbin/nologin -c "Docker image user" swuser \
    && chown -R swuser:swuser /tmp/
USER swuser
RUN npm run build:datacube 

USER root
RUN npm run build:dist

# 22 copy dist directory to web server
RUN rm /var/www/html/index.nginx-debian.html \
    &&  cp -r dist/* /var/www/html \
    && cp -r templates/ /var/www/html/ \
    && cp -r external/Mizar/api_doc /var/www/html/


# 23 Fix css tag in index.html
RUN sed -ri '/<\/head>/i \  <link rel=\"stylesheet\" href=\"..\/templates\/datacube\/styles.datacube.bundle.css\" type=\"text\/css\">' /var/www/html/index.html
   


# 24 Export configuration file
RUN mkdir -p /opt/mizar/conf \
    && chmod +x /opt/mizar/conf  \
    && cp /var/www/html/conf/* /opt/mizar/conf/ \
    && rm -rf /var/www/html/conf \
    && ln -s /opt/mizar/conf /var/www/html/ 

# 25 Set up the Nginx Mapserver configuration.
RUN rm -rf /etc/nginx/conf.d/* \
    && cp ../nginx.conf /etc/nginx/nginx.conf \
    && cp ../mizar.nginx.conf /etc/nginx/conf.d/default.conf


# 26 Expose the Http server on 80
EXPOSE 80



# #----------------------------------------------------------------------------- DATACUBESERVER
# #--------------------------------------------------------------------------------------------

# Install java
RUN echo "deb http://deb.debian.org/debian stretch-backports main" >> /etc/apt/sources.list.d/nginx.list
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y -t stretch-backports install openjdk-8-jdk

# install maven
RUN apt-get -y install maven

# clone Server
WORKDIR /opt/ 
RUN git clone  --single-branch --branch removeloc https://github.com/mmebsout/DataCubeServer.git \
    && cd DataCubeServer \
    # edit properties : .fits and .nc are found in "/data/private" and "/data/public" folders
    && sed -i -e '/workspace=/ s/=.*/=\/data\//' -e '/workspace_cube=/ s/=.*/=\/data\//' cubeExplorer.properties \
    && sed -i -e '/workspace=/ s/=.*/=\/data\//' -e '/workspace_cube=/ s/=.*/=\/data\//' src/main/resources/conf/cubeExplorer.properties \
    # install server 
    && mvn clean install 

# create /data/private and /data/public folders 
RUN mkdir -p /data/private && mkdir /data/public \
    && chmod +x /data/private && chmod +x /data/public 

EXPOSE 8081

#----------------------------------------------------------------------------- CLEANUP
#--------------------------------------------------------------------------------------------

RUN cp /tmp/script.sh /

# Remove the build dependencies.
RUN apt-get remove -y python-pip 
# Clean up APT when done.
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ------- RUN APPs

 COPY ./scripts/script.sh /
 RUN chmod +x /script.sh
 ENTRYPOINT ["/script.sh"]
# ENTRYPOINT ["nginx"]