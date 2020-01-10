
# DataCube and Server -  Docker image

This image contains the [Datacube](https://github.com/MizarWeb/DataCube) and [Datacube Server](https://github.com/MizarWeb/DataCubeServer) apps working together to help view cubes of spectral data.

It also creates the default folders for .fits and .nc files and downloads the cube 1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits from [HERSCHEL](http://idoc-herschel.ias.u-psud.fr/sitools/client-user/Herschel/project-index.html) that is opened at startup.
These folders can be replaced with a host one using the -v option to bind-mount one to /data as written in the following script that you can use to run a container.

## Usage

This script will create a local folder that can host your cubes to be viewed in the app and run a new container from this image.

``` bash 
#!/usr/bin/env bash

WORKSPACE_PATH=$PWD/datacube_workspace

mkdir -p $WORKSPACE_PATH/private && mkdir $WORKSPACE_PATH/public
chmod +x $WORKSPACE_PATH/private && chmod +x $WORKSPACE_PATH/public

wget -P  $WORKSPACE_PATH/public http://idoc-herschel.ias.u-psud.fr/sitools/datastorage/user/storageRelease/R7_spire_fts/HIPE_Fits/FTS_SPIRE/OT1_atielens/M17-2/1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits

docker run --name datacube \
            -d \
            -p 8000:4200 \
            -p 8081:8081 \
            -v $WORKSPACE_PATH:/data \
            idocias/datacube-and-server:latest

echo "Please launch : http://localhost:8000/DataCube"
```
## Cleanup

You can then access the app from your navigator at  http://localhost:8000/DataCube and login with the credentials admin/admin.

To discard your container run the following command : 
```bash
docker container rm -f datacube
```
