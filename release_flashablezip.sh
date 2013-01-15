#!/bin/bash

PORT_ROOT=$3
RELEASE_DIR=${PORT_ROOT}/release_zip
YUN_DIR=${RELEASE_DIR}/Yunio
BUILD_NUMBER=$1
PORT_PRODUCT=$2
index=`expr index "${PORT_PRODUCT}" "_"`
PRODUCT=${PORT_PRODUCT:0:$index-1}
BUILDER=${PORT_PRODUCT:$index:2}
NEWFILE="miui_""${PRODUCT}""_""${BUILD_NUMBER}""_""${BUILDER}""`date +%Y%m%d`"".zip"

if [ ! -d "${YUN_DIR}" ]; then
	mkdir -p ${YUN_DIR}
fi
echo "copy flashzip to releasezip folder..."
mv out/fullota.zip ${YUN_DIR}/${NEWFILE}
if [ $? -eq 0 ]; then
	echo "$NEWFILE generated"
else
	echo "Failed"
fi
