#!/bin/bash

# Micode:patchrom sync tool by kqstone (kqstone@163.com)
# Please use "sh patchrom.sh [option]" to execute this tool
# [option] nothing for help
#          init:  initiate workspace
#          sync:  sync patchrom jellybean branch code 

PULL="git pull origin jellybean"

git_init_project() {
	for n in 1 2 3 4; do
		eval arg_temp=\$$n
		echo "===========init patchrom_${arg_temp}=========="
		mkdir ${arg_temp}
		cd ${arg_temp}
		git init
		URL_TEMP="git@github.com:MiCode/patchrom_"${arg_temp}".git"
		git remote add origin $URL_TEMP
		cd ..
	done
}

git_pull() {
	# git pull function
	echo ">>>>git pull started"
	$PULL
	while [ $? -ne 0 ]; do
		echo ">>>>>>git pull failed, pull again"
		$PULL
	done
}

git_pull_project() {
	for n in 1 2 3 4; do
		eval arg_temp=\$$n
		echo "===========sync patchrom_${arg_temp}=========="
		cd $arg_temp
		git_pull
		cd ..
	done
}

if  [ -z "$1" ]; then
	echo "========================================================="
	echo "Micode:patchrom sync tool by kqstone (kqstone@163.com)"
	echo 'Please use "sh patchrom.sh [option]" to execute this tool'
	echo "[option] nothing for help"
	echo "         init:  initiate workspace"
	echo "         sync:  sync patchrom jellybean branch code" 
	echo "========================================================="
	exit 0
fi

if [ "$1" = "init" ]; then
	git_init_project "tools" "android" "miui" "build" 
	exit 0
fi

if [ "$1" = "sync" ]; then 
	git_pull_project "tools" "android" "miui" "build"
	exit 0
fi

