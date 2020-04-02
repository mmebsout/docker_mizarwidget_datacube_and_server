#!/usr/bin/env bash
docker run --name mizarwidget-datacube_and_server \
            -d \
            -p 8000:80 \
            -p 8081:8081 \
            -v $WORKSPACE_PATH:/data \
            idocias/mizarwidget-datacube-and-server:latest
echo "Please launch : http://localhost:8000/"
