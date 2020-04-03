#!/usr/bin/env bash
if [ -z "$idocdockerpassword" ]
then
read -s -p "Enter DockerHub idocias password: " idocdockerpassword
fi

docker run --rm \
    -v $PWD/DockerHub_Readme.md:/data/README.md \
    -e DOCKERHUB_USERNAME='idocdocker' \
    -e DOCKERHUB_PASSWORD=$idocdockerpassword \
    -e DOCKERHUB_REPO_PREFIX='idocias' \
    -e DOCKERHUB_REPO_NAME='mizarwidget-datacube-and-server' \
     sheogorath/readme-to-dockerhub

echo "DockerHub idocias Readme updated!"