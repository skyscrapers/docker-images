# docker-images

This repository contains the Docker setup to build a number of derived/customised
Docker images. Each folder contains the setup for a single image.

The Concourse pipeline to build all images can be found in the 
[skyscrapers/ci](https://github.com/skyscrapers/ci) repository.

## concourse

This is a tweaked version of the official upstream concourse image.

We didn't want to use volumes to set the SSH keys so we pull them down from an S3 bucket. All environment variables are the same as the official concourse image. We only added one extra and that is `_CONCOURSE_KEYS_S3`, that expects as input the following format `s3://<bucket_name>`

## packer

This is a Docker image containing the following tools:

* Ruby
* [Racker](https://github.com/aspring/racker)
* [r10k](https://github.com/puppetlabs/r10k)
* [Packer](https://www.packer.io/)

All these tools are used to succesfully build AWS images for the Skyscrapers customers.
The Racker tool is used to deep merge a generic (Ruby) template with 
customer specific extensions before generating a JSON Packer template.

To build this image, a build argument is required:
* `PACKER_VERSION`

You can specify it in a manual build like this:
`$ docker build --build-arg PACKER_VERSION=1.0.4 -t skyscrapers/packer:1.0.4 .`
