#!/usr/bin/env bash
WORKSPACE_PATH=$PWD/datacube_workspace
mkdir -p $WORKSPACE_PATH/private && mkdir $WORKSPACE_PATH/public
chmod +x $WORKSPACE_PATH/private && chmod +x $WORKSPACE_PATH/public

wget -P  $WORKSPACE_PATH/public http://idoc-herschel.ias.u-psud.fr/sitools/datastorage/user/storageRelease//R7_spire_fts/HIPE_Fits/FTS_SPIRE/OT1_atielens/M17-2/1342228703_M17-2_SPIRE-FTS_15.0.3244_HR_SLW_gridding_cube.fits

docker run --name mizarwidget-datacube-and-server \
            -d \
            -p 8000:80 \
            -p 8081:8081 \
            -v $WORKSPACE_PATH:/data \
            idocias/mizarwidget-datacube-and-server:latest
echo "Please launch : http://localhost:8000/"
