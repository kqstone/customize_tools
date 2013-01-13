#!/bin/bash

BUILD_NUMBER=$1
PORT_PRODUCT=$2
OTADIR=releases_ota
OTATOOL=$PORT_ROOT/tools/releasetools/ota_from_target_files
KEY=$PORT_ROOT/build/security/testkey
RELDIR=releases_zip/Yunio
NEWFILE="target_files_""`date +%Y%m%d%H%M%S`"".zip"
OTAFILE="ota_miui_""${PORT_PRODUCT}""_""${BUILD_NUMBER}""_""`date +%Y%m%d`"".zip"


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
	$OTATOOL -k $KEY -i $OTADIR/${file1} $OTADIR/$NEWFILE $RELDIR/$OTAFILE
else
	echo "Last target_files wasn't found!!!!!"
	echo "Latest target_files was copied to ota folder"
fi
