#!/usr/bin/env bash
docker run --name mizarwidget-datacube_and_server \
            -d \
            -p 8000:80 \
            idocias/mizarwidget-datacube-and-server:latest
echo "Please launch : http://localhost:8000/"
