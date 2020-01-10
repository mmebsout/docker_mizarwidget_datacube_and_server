This projects holds the files necessary to create the docker image datacube available in dockerhub at [idocias/mizarwidget-datacube-and-server](https://hub.docker.com/r/idocias/mizarwidget-datacube-and-server). 

- To create the docker image run [build.sh](build.sh)
- To publish the image to idocias/datacube run [publish.sh](publish.sh) (this will also update the Dockerhub Documentation)
- To update the dockerhub documentation with what's in [DockerHub_Readme.md](DockerHub_Readme.md) run [publishReadme.sh](publishReadme.sh).

> **WARNING**: publish.sh and publishReadme.sh use $PWD. You should run them from this folder. 

  ---

- To launch a container run [run.sh](run.sh)
- To delete the container (even if it's still running) run [clean.sh](clean.sh)
