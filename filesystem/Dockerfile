# This file is based on https://github.com/dotcloud/docker-registry/Dockerfile.
# Changes:
#   base image
#   config.yml
#   overwrite run.sh (set BOTO_PATH, use 1 gunicorn worker)

FROM debian:jessie

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    git-core python-gevent gcc python-dev \
    gunicorn python-boto liblzma-dev \
    python-yaml python-lzma python-crypto python-requests \
    python-simplejson python-redis python-openssl wget; \
    rm /var/lib/apt/lists/*_*
RUN cd /tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN cd /tmp; python ez_setup.py; easy_install pip; \
    rm ez_setup.py

#TODO: switch to https://github.com/dotcloud/docker-registry.git
# after https://github.com/dotcloud/docker-registry/pull/308 is in.
RUN git clone https://github.com/ktintc/docker-registry.git /docker-registry

# Overwrite requirements.txt.
# We install some of the libs with apt-get to be able to do purge later.
ADD requirements.txt /docker-registry/requirements.txt

RUN cd /docker-registry && pip install -r requirements.txt

# Reduce image size.
RUN apt-get purge -y --force-yes gcc python-dev liblzma-dev \
    libpython2.7-dev gcc-4.7 libc6-dev \
    linux-libc-dev git-core

# Overwrite run.sh
ADD run.sh /docker-registry/run.sh

# Registry config.
ADD config.yml /docker-registry/config/config.yml

CMD /bin/true
