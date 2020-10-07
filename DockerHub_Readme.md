
# MizarWidget, DataCube and Server -  Docker image

This image contains the MizarWidget app with the [Datacube](https://github.com/MizarWeb/DataCube) plugin and [Datacube Server](https://github.com/MizarWeb/DataCubeServer).
With this docker inage you'll be able to tryout the DataCube plugin in the MizarWidget context. 
If you only want to try Datacube we suggest you use the [datacube-and-server](https://hub.docker.com/r/idocias/datacube-and-server) docker image instead. 

It also creates the default folders for .fits and .nc files and downloads the cube HH_IR_int-2_1342228508_L2_red_145.52_OI3P0-3P1_ProjectedCube.fits from [HERSCHEL](http://idoc-herschel.ias.u-psud.fr/sitools/client-user/Herschel/project-index.html).

These folders can be replaced with a host one using the -v option to bind-mount one to /data as written in the following script that you can use to run a container.

## Running the docker container

You can run this image by using either 
- [run.sh](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/run.sh) - that will simply run the image as is.
- or [run-with-volumes.sh](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/run-with-volumes.sh) that will allow you to use different cubes and play with Mizar-Widget configuration files.


### Using Datacube in Mizarwidget
After lauching http://localhost:8000/" and accessing MizarWidget
 - drag and drop this [json file](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/demo.json) into the MizarWidget interface.
 - click in the square that has been zoomed-on
 - then click in the datacube icon (square colored layers)
 - the datacube interface opens up
 - use the datacube app to view the contents of the demo file


### Cubes
When using [run-with-volumes.sh](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/run-with-volumes.sh) a directory is created at the location of the script launch called "datacube_workspace". 

A sample file "datacube_workspace/public/1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits" but you can add new ones as you like as long as they are FITS or netCDF files they can be read by the DataCube plugin.

### MizarWidget configuration files
When using run-with-volumes.sh a directory is created at the location of the script launch called "conf".
You will there find different settings for MizarWidget like "mars.ctx" or "earth.ctx". The default setting is "sky.ctx".
To change option edit the file mizarWidget.json and change the property  "defaultCtx": "sky" at the end of the file with the one you want like for example "d

## Cleanup

To discard your container use the script [clean.sh](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/clean.sh).

This will also ask if you want the volumes removed if they exist. 

## Issues 
If you see any issues with the docker file please report them in the [docker_mizarwidget_datacube_and_server](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/issues) github repository

Note that if you see issues with the application they might already be listed in the [MizarWeb github repository](https://github.com/MizarWeb/MizarWeb.github.io/issues?q=is%3Aissue+is%3Aopen+label%3AComponent%3AdataCube). We encourage you to check there if your issue is already listed before reporting a new one. 
