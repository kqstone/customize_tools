#!/bin/bash

add_remote_git() {
	read -p "Please enter the remote url: " remote_url
	while [ "${remote_url}" = "" ]; do
		echo "Remote url should be entered!"
		read -p "Please enter the remote url again: " remote_url
	done
		git remote add origin ${remote_url}
}

showhelp() {
	echo "git tools..."
	echo "./git_tools.sh -remote [url]:        Add a remote git url"
	echo "./git_tools.sh -c [dir1 [dir2] ...]: Commit change"
	echo "./git_tools.sh -p:                   Push changes to remote"
}

if [ $# -lt 1 ] || [ "$1" = "-h" ]; then
	echo "$#"
	showhelp
	exit 0
fi
	
if [ "$1" = "-p" ]; then
	git push -u origin master
	exit 0
fi

if [ "$1" = "-c" ]; then
	shift
	git add $@
	read -p "Please type commit message: " commit_name
	while [ "${commit_name}" = "" ]; do
		echo "You must type a message!"
		read -p "Please type commit message again: " commit_name
	done
	git commit -m "${commit_name}"
	exit 0
fi

if [ "$1" = "-remote" ]; then
	add_remote_git
	while [ $? -ne 0 ]; do
		add_remote_git
	done
	exit 0
fi

