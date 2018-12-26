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
	echo "docker gradle run $@"
	docker run --volume=$HOME/.gradle:/root/.gradle --volume=$(pwd):/tmp/project javiersantos/android-ci:28.0.3 /bin/bash -c "cd /tmp/project && ./gradlew $@"
	if [ $? -ne 0 ] ; then
		echo "failed to run gradle docker for $@"
		exit 99
	fi

fi
