docker-registry
===============

Sources for [google/docker-registry](https://index.docker.io/u/google/docker-registry/).

For usage please refer to [google/docker-registry](https://index.docker.io/u/google/docker-registry/).

To build docker-registry image first you need to build base image for it called docker-registry-filesystem.
See filesystem/build.sh:

```
 # Prepare files
docker build -t docker-registry-base .
docker run --name docker-registry-files docker-registry-base
docker export docker-registry-files > docker-registry-files.tar

 # Create base image
docker import - docker-registry-filesystem < docker-registry-files.tar

 # Clean up
docker rm docker-registry-files
docker rmi docker-registry-base
rm docker-registry-files.tar
```
