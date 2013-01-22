#!/bin/bash

PORT_ROOT=$3
RELEASE_DIR=${PORT_ROOT}/release_zip
YUN_DIR=${RELEASE_DIR}/Yunio
OTADIR=releases_ota
BUILD_NUMBER=$1
PORT_PRODUCT=$2
OTATOOL=${PORT_ROOT}/tools/releasetools/ota_from_target_files
KEY=${PORT_ROOT}/build/security/testkey
NEWFILE="target_files_""`date +%Y%m%d%H%M%S`"".zip"
index=`expr index "${PORT_PRODUCT}" "_"`
PRODUCT=${PORT_PRODUCT:0:$index-1}
BUILDER=${PORT_PRODUCT:$index:2}
OTAFILE="ota_miui_""${PRODUCT}""_""${BUILD_NUMBER}""_""${BUILDER}""`date +%Y%m%d`"".zip"


if [ ! -d "$OTADIR" ]; then
	mkdir $OTADIR
fi
echo "Copy the latest target_files to ota folder..."
cp -f out/target_files.zip $OTADIR/${NEWFILE}
for file in `ls $OTADIR`; do
	if [ ! -f "$OTADIR/${file1}" ] && [ "$OTADIR/$file" != "$OTADIR/$NEWFILE" ]; then
		file1=$file
	else
		if [ "$OTADIR/$file" -nt "$OTADIR/${file1}" ] && [ "$OTADIR/$file" != "$OTADIR/$NEWFILE" ]; then
			file1=$file
		fi		
	fi
done
echo "OTAFILE will be generated from $NEWFILE to ${file1}..."
if [ -f "$OTADIR/${file1}" ]; then
	$OTATOOL -k $KEY -i $OTADIR/${file1} $OTADIR/$NEWFILE $YUN_DIR/$OTAFILE
	if [ ! $? -eq 0 ]; then
		echo "Generate otazip failed!"
		echo "Removing temp files..."
		rm -f $OTADIR/$NEWFILE
		echo "$NEWFILE cleaned"
	else
		echo "$OTAFILE generated in $YUN_DIR"
	fi
else
	echo "Last target_files wasn't found!!!!!"
	echo "Latest target_files was copied to ota folder"
fi
