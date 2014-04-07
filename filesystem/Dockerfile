# This file is based on https://github.com/dotcloud/docker-registry/Dockerfile.
# Changes:
#   base image
#   config.yml
#   overwrite run.sh (set BOTO_PATH, use 1 gunicorn worker)

FROM debian:jessie

RUN apt-get update; \
    apt-get install -y git-core build-essential python-dev \
    libevent-dev python-openssl liblzma-dev wget; \
    rm /var/lib/apt/lists/*_*
RUN cd /tmp; wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN cd /tmp; python ez_setup.py; easy_install pip; \
    rm ez_setup.py

#TODO: switch to https://github.com/dotcloud/docker-registry.git
# after https://github.com/dotcloud/docker-registry/pull/308 is in.
RUN git clone https://github.com/ktintc/docker-registry.git /docker-registry

RUN cd /docker-registry && pip install -r requirements.txt

# Overwrite run.sh
ADD run.sh /docker-registry/run.sh

# Registry config.
ADD config.yml /docker-registry/config/config.yml

CMD /bin/true
