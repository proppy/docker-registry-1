#!/bin/bash
set -e

CONTEXT_PATH=$1
export DEBIAN_FRONTEND=noninteractive

apt-get update || true
apt-get install -y --no-install-recommends \
    git-core python-gevent gcc python-dev \
    gunicorn python-boto liblzma-dev \
    python-yaml python-lzma python-crypto python-requests \
    python-simplejson python-redis python-openssl wget python-pip
rm /var/lib/apt/lists/*_*
apt-get clean
git clone https://github.com/dotcloud/docker-registry.git /docker-registry
(cd /docker-registry && pip install -r ${CONTEXT_PATH}/requirements.txt)
apt-get purge -y --force-yes gcc python-dev git-core
apt-get autoremove -y --force-yes

cp ${CONTEXT_PATH}/run.sh /docker-registry/run.sh
cp ${CONTEXT_PATH}/config.yml /docker-registry/config/config.yml
