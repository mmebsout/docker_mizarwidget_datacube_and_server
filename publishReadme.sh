#!/usr/bin/env bash
if [ -z "$idociaspassword" ]
then
read -s -p "Enter DockerHub idocias password: " idociaspassword
fi

docker run --rm \
    -v $PWD/DockerHub_Readme.md:/data/README.md \
    -e DOCKERHUB_USERNAME='idocias' \
    -e DOCKERHUB_PASSWORD=$idociaspassword \
    -e DOCKERHUB_REPO_PREFIX='idocias' \
    -e DOCKERHUB_REPO_NAME='mizarwidget-datacube-and-server' \
     sheogorath/readme-to-dockerhub

echo "DockerHub idocias Readme updated!"