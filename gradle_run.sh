#!/bin/bash

#parent_directory=$(dirname $0)
#
#if [ -z "${SERVICE_NAME}" ] ; then
#	echo "unable to get SERVICE_NAME"
#	exit 1
#fi

which docker 2>&1

if [ $? -ne 0 ] ; then
	echo "Cannot run the docker build step"
	exit 2
else
    eval sudo $(aws ecr get-login) || exit 3
	echo "docker gradle run $@"
	docker run --volume=$(pwd):/tmp/project gcr.io/anyvision-training/android-ci /bin/bash -c "./gradlew $@"
	if [ $? -ne 0 ] ; then
		echo "failed to run gradle docker for $@"
		exit 99
	fi

fi
