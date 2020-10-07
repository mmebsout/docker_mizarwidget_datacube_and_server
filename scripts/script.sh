#!/bin/bash

nginx &
cd /opt/DataCubeServer/target/
java -Xmx5G -jar "$(echo cubeExplorer-*.jar )"