#!/bin/bash

DIR=$(dirname $0)
pushd ${DIR}

REPOSITORY_REMOTE_HOST=devil
REPOSITORY_REMOTE_DIR=/home/kbaransk/domains/repos.kbaranski.pl/public_html/debian

/usr/bin/rsync --archive --verbose --compress --delete --exclude ".git**" dists ${REPOSITORY_REMOTE_HOST}:${REPOSITORY_REMOTE_DIR}
/usr/bin/rsync --archive --verbose --compress --delete --exclude ".git**" pool  ${REPOSITORY_REMOTE_HOST}:${REPOSITORY_REMOTE_DIR}

popd
