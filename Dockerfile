# This file is based on https://github.com/dotcloud/docker-registry/Dockerfile.
# Changes:
#   Mounting VOLUME with credentilas obtained by google/cloud-sdk
#   ENV vars
#   config.yml
#   overwrite run.sh (set BOTO_PATH, use 1 gunirorn worker)

FROM ubuntu:13.04

RUN apt-get update; \
    apt-get install -y git-core build-essential python-dev \
    libevent1-dev python-openssl liblzma-dev wget; \
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

# This is the default port that docker-registry is listening on.
# Needs to be set into 5000 or the value of REGISTRY_PORT environment variable
# if the latter one is set.
EXPOSE 5000

# Registry config.
ADD config.yml /docker-registry/config/config.yml

# Credentials. Use --volumes-from gcloud-config (google/cloud-sdk).
VOLUME ["/.config"]

# These should be set if credentials are obtained with google/cloud-sdk.
ENV OAUTH2_CLIENT_ID 32555940559.apps.googleusercontent.com
ENV OAUTH2_CLIENT_SECRET ZmssLNjJy2998hD4CTg2ejr2
ENV USER_AGENT "Cloud SDK Command Line Tool"

CMD cd /docker-registry && ./setup-configs.sh && exec ./run.sh
