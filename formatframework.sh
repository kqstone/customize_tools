#!/bin/bash

# Tools for preparing framework dir
# use "./formatframework.sh patch" to prepare framework dir for "make firstpatch"
# use "./formatframework.sh make" to prepare framework dir for "make fullota"

FW1=framework.jar.out
FW2=framework2.jar.out

mvdir() {
	if [ ! -d "$2" ]; then
		mkdir -p $2
	fi
	for file in `ls $1`; do 
		cp -rf $1/$file $2
		echo "$file copied to $2"
	done
	echo "removing $1 ..."
	rm -rf $1
}

if [ $1 = "patch" ]; then
	mvdir "$FW2/smali" "$FW1/smali"
fi

if [ $1 = "make" ]; then
	mvdir "$FW1/smali/android/filterfw" "$FW2/smali/android/filterfw"
	mvdir "$FW1/smali/android/filterpacks" "$FW2/smali/android/filterpacks"
	mvdir "$FW1/smali/android/gesture" "$FW2/smali/android/gesture"
	mvdir "$FW1/smali/android/media/effect" "$FW2/smali/android/media/effect"
	mvdir "$FW1/smali/android/media/videoeditor" "$FW2/smali/android/media/videoeditor"
	mvdir "$FW1/smali/android/speech/srec" "$FW1/smali/android/speech/srec"
	mvdir "$FW1/smali/android/test" "$FW1/smali/android/test"
	mvdir "$FW1/smali/com/android/server/sip" "$FW1/smali/com/android/server/sip"
fi


