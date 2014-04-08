#!/bin/bash
set -e

CONTEXT_PATH=$1

apt-get update || true
apt-get install -y --no-install-recommends \
    git-core python-gevent gcc python-dev \
    gunicorn python-boto liblzma-dev \
    python-yaml python-lzma python-crypto python-requests \
    python-simplejson python-redis python-openssl wget python-pip
rm /var/lib/apt/lists/*_*
git clone https://github.com/dotcloud/docker-registry.git /docker-registry
(cd /docker-registry && pip install -r ${CONTEXT_PATH}/requirements.txt)
apt-get purge -y --force-yes gcc python-dev liblzma-dev \
    libpython2.7-dev gcc-4.7 libc6-dev \
    linux-libc-dev git-core
cp ${CONTEXT_PATH}/run.sh /docker-registry/run.sh
cp ${CONTEXT_PATH}/config.yml /docker-registry/config/config.yml
