#!/bin/bash

BUILD_NUMBER=$1
PORT_PRODUCT=$2
NEWFILE="miui_""${PORT_PRODUCT}""_""${BUILD_NUMBER}""_""`date +%Y%m%d`"".zip"

if [ ! -d "releases_zip" ]; then
	mkdir releases_zip
fi
echo "copy flashzip to releasezip folder..."
mv out/fullota.zip releases_zip/Yunio/${NEWFILE}
if [ $? -eq 0 ]; then
	echo "$NEWFILE generated"
else
	echo "Failed"
fi
