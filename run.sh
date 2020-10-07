#!/usr/bin/env bash


docker run  -e LOCAL_USER_ID=`id -u $USER` --name mizarwidget-datacube_and_server \
            -d \
            -p 8000:80 \
            idocias/mizarwidget-datacube-and-server:latest 
echo "Please launch : http://localhost:8000/"

