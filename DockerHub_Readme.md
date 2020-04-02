
# MizarWidget, DataCube and Server -  Docker image

This image contains the MizarWidget app with the [Datacube](https://github.com/MizarWeb/DataCube) plugin and [Datacube Server](https://github.com/MizarWeb/DataCubeServer).
With this docker inage you'll be able to tryout the DataCube plugin in the MizarWidget context. 
If you only want to try Datacube we suggest you use the [datacube-and-server](https://hub.docker.com/r/idocias/datacube-and-server) docker image instead. 

It also creates the default folders for .fits and .nc files and downloads the cube 1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits from [HERSCHEL](http://idoc-herschel.ias.u-psud.fr/sitools/client-user/Herschel/project-index.html).

These folders can be replaced with a host one using the -v option to bind-mount one to /data as written in the following script that you can use to run a container.

## Running the docker container

Download an run the script [run.sh](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/run.sh) from the docker_mizarwidget_datacube_and_server repository. 

This script will create a local folder that can host your cubes to be viewed in the app and run a new container from this image.

## Using Datacube in Mizarwidget
After lauching http://localhost:8000/" and accessing MizarWidget
 - drag and drop this [json file](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/blob/master/demo.json) into the MizarWidget interface.
 - click in the square that has been zoomed-on
 - then click in the datacube icon (square colored layers)
 - the datacube interface opens up
 - use the credential "admin/admin" 
 - use the datacube app to view the contents of the demo file


## Cleanup

To discard your container run the following command : 
```bash
docker rm mizarwidget-datacube_and_server -f
```

## Issues 
If you see any issues with the docker file please report them in the [docker_mizarwidget_datacube_and_server](https://github.com/mmebsout/docker_mizarwidget_datacube_and_server/issues) github repository

Note that if you see issues with the application they might already be listed in the [MizarWeb github repository](https://github.com/MizarWeb/MizarWeb.github.io/issues?q=is%3Aissue+is%3Aopen+label%3AComponent%3AdataCube). We encourage you to check there if your issue is already listed before reporting a new one. 