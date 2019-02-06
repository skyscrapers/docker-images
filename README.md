# docker-images

This repository contains the Docker setup to build a number of derived/customised
Docker images. Each folder contains the setup for a single image.

The Concourse pipeline to build all images can be found in the
[skyscrapers/ci](https://github.com/skyscrapers/ci) repository.

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

## packer g10k

This is a Docker image containing the following tools:

* Go
* [g10k](https://github.com/xorpaul/g10k)
* [Packer](https://www.packer.io/)

All these tools are used to succesfully build AWS images for the Skyscrapers customers, supports g10k as faster replacement for r10k for building Puppet modules.

To build this image, a build argument is required:
* `PACKER_VERSION`

You can specify it in a manual build like this:
`$ docker build --build-arg PACKER_VERSION=1.0.4 -t skyscrapers/packer-g10k:1.0.4 .`

## Teleport

This is a Docker image for [Teleport](https://gravitational.com/teleport/)

This will build a Teleport image from the Debian base image. This Dockerfile expects the released Teleport binaries in `teleport/teleport` folder.

## volume-populator

This container is used to populate volumes from configmaps. Useful in Kubernetes as an init container to populate a volume with data before the application starts.

## nginx

This is a Nginx Docker image based on the [upstream Docker image](https://hub.docker.com/_/nginx/).

We want to monitor Nginx and for this we need the [VTS Nginx module](https://github.com/vozlt/nginx-module-vts) to have enhanced metrics. To activate VTS we have to build the binary from scratch.

## aws-nuke

Docker image containing the [aws-nuke](https://github.com/rebuy-de/aws-nuke) binary. Based on alpine.

## kops

Apline based docker image continaing the [`awscli`](https://github.com/aws/aws-cli), [`kops`](https://github.com/kubernetes/kops) and [`kubectl`](https://github.com/kubernetes/kubectl).

You can control which versions are built via the following `ARG`s:

```docker
ARG AWSCLI_VERSION=1.16.97
ARG KOPS_VERSION=1.11.0
ARG KUBECTL_VERSION=v1.13.3
```
