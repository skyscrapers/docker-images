# docker-images

This repository contains the Docker setup to build a number of derived/customised
Docker images. Each folder contains the setup for a single image.

The Concourse pipeline to build all images can be found in the 
[skyscrapers/ci](https://github.com/skyscrapers/ci) repository.

## concourse

This is a tweaked version of the official upstream concourse image.

We didn't want to use volumes to set the SSH keys so we pull them down from an S3 bucket. All environment variables are the same as the official concourse image. We only added one extra and that is `_CONCOURSE_KEYS_S3`, that expects as input the following format `s3://<bucket_name>`
