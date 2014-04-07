#!/bin/bash

docker build -t docker-registry-base .
docker run --name docker-registry-files docker-registry-base
docker export docker-registry-files > docker-registry-files.tar

docker import - docker-registry-filesystem < docker-registry-files.tar

docker rm docker-registry-files
docker rmi docker-registry-base
rm docker-registry-files.tar
