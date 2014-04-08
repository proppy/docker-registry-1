docker-registry
===============

Sources for [google/docker-registry](https://index.docker.io/u/google/docker-registry/), [Docker Registry](https://github.com/dotcloud/docker-registry) image to push/pull your [Docker](https://www.docker.io/) images to/from [Google Cloud Storage](https://cloud.google.com/products/cloud-storage/).

- Uses 'gcs' as a storage option
- Has OAuth2 support built in
- Works locally and on [Google Compute Engine] (https://cloud.google.com/products/compute-engine/)


### Building google/docker-registry image

1) Build base image, docker-registry-base, containing filesystem only:

```
docker build -t docker-registry-base path/to/cloned/git/repo/docker-registry/filesystem
```

2) Flatten that image:

```
docker run --name docker-registry-files docker-registry-base
docker export docker-registry-files > docker-registry-files.tar
```

3) Create another base image, docker-registry-filesystem, from previously exported files:

```
docker import - docker-registry-filesystem < docker-registry-files.tar
```

4) Build the resulting google/docker-registry (add metadata to the image such as volumes, environment variables, exposed ports etc):

```
build -t google/docker-registry path/to/cloned/git/repo/docker-registry
```

5) Clean up:

```
docker rm docker-registry-files
docker rmi docker-registry-base
rm docker-registry-files.tar
```

Steps 1-3 are done to reduce the size of the resulting image removing some dependencies needed for build step only.
Build commmands for docker-registry-filesystem are in filesystem/build.sh


### Usage

After [google/docker-registry](https://index.docker.io/u/google/docker-registry) is built or pulled from the [public registry]( https://index.docker.io/u/google/docker-registry) you can push/pull docker images to/from your [Google Cloud Storage](https://cloud.google.com/products/cloud-storage/) bucket.

#### Locally

1) Start the registry and mount your credentials from a data container named gcloud-config. You also need to pass some environment variables to your container, i.e. GCS_BUCKET and an EMAIL address that you have logged in with. For more information about getting OAuth2 credentials please refer to [google/cloud-sdk](https://index.docker.io/u/google/cloud-sdk/) documentation.

```
docker run -d -e GCS_BUCKET=yet-another-docker-bucket -e EMAIL=<your email> -p 5000:5000 --volumes-from gcloud-config google/docker-registry 
```

2) Now you can store your images on GCS!

```
docker push localhost:5000/myawesomeimage
```

#### Google Compute Engine

On [Google Compute Engine] (https://cloud.google.com/products/compute-engine/) instance you don't need to mount any volumes or pass your email. All necessary information will be received from Metadata Server:

```
docker run -d -e GCS_BUCKET=yet-another-docker-bucket -p 5000:5000 google/docker-registry 
```

For more information about usage please refer to [google/docker-registry](https://index.docker.io/u/google/docker-registry/) docs.
