#!/usr/bin/env bash
WORKSPACE_PATH=$PWD/datacube_workspace
mkdir -p $WORKSPACE_PATH/private && mkdir $WORKSPACE_PATH/public
chmod +x $WORKSPACE_PATH/private && chmod +x $WORKSPACE_PATH/public

wget -P  $WORKSPACE_PATH/public http://idoc-herschel.ias.u-psud.fr/sitools/datastorage/user/storageRelease/R6_pacs_spectro/HIPE_Fits/SPECTRO_PACS/SAG-4/HH_IR_int-2/HH_IR_int-2_1342228508_L2_red_145.52_OI3P0-3P1_ProjectedCube.fits

docker run --name mizarwidget-datacube-and-server \
            -d \
            -p 8000:80 \
            -p 8081:8081 \
            -v $WORKSPACE_PATH:/data \
            idocias/mizarwidget-datacube-and-server:latest
echo "Please launch : http://localhost:8000/"
