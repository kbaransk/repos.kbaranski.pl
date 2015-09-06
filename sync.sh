#!/bin/bash

DIR=$(dirname $0)
pushd ${DIR}

/usr/bin/rsync --archive --verbose --compress --delete . ${REPOSITORY_REMOTE_HOST}:${REPOSITORY_REMOTE_DIR}

popd
