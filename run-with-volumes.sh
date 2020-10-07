#!/usr/bin/env bash

# Create and populate volume folder for cubes 
WORKSPACE_PATH=$PWD/datacube_workspace
mkdir -p $WORKSPACE_PATH
mkdir -p $WORKSPACE_PATH/public
mkdir -p $WORKSPACE_PATH/private
chmod -R 777 $WORKSPACE_PATH

if [ ! -f /data/public/ ]; then
    wget -P  $WORKSPACE_PATH/public/. http://idoc-herschel.ias.u-psud.fr/sitools/datastorage/user/storageRelease//R7_spire_fts/HIPE_Fits/FTS_SPIRE/OT1_atielens/M17-2/1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits
fi

# Create and populate volume folder for conf files
MiZARWIDGET_CONF_PATH=$PWD/conf
mkdir -p $MiZARWIDGET_CONF_PATH
chmod -R 777 $MiZARWIDGET_CONF_PATH

if [ ! -f $MiZARWIDGET_CONF_PATH ]; then
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/curiosityCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/earthCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/marsCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/mizarWidget.json 
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/moonCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/skyCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/sunCtx.json
	wget -P  $MiZARWIDGET_CONF_PATH https://raw.githubusercontent.com/MizarWeb/MizarWidget/master/conf/titanCtx.json
fi

# running the docker container
docker run  -e LOCAL_USER_ID=`id -u $USER` --name mizarwidget-datacube_and_server \
            -d \
            -p 8000:80 \
            -v $WORKSPACE_PATH:/data \
            -v $MiZARWIDGET_CONF_PATH:/opt/mizar/conf \
            idocias/mizarwidget-datacube-and-server:latest 
echo "Please launch : http://localhost:8000/"

