# docker-images

This repository contains the Docker setup to build a number of derived/customised
Docker images. Each folder contains the setup for a single image.

The Concourse pipeline to build all images can be found in the
[skyscrapers/ci](https://github.com/skyscrapers/ci) repository.

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

## aws-nuke

Docker image containing the [aws-nuke](https://github.com/rebuy-de/aws-nuke) binary. Based on alpine.

## fluent-bit

A [fluent-bit](https://github.com/fluent/fluent-bit) image including the [logzio-output](https://github.com/logzio/fluent-bit-logzio-output) and [grafana-loki](https://github.com/grafana/loki/tree/main/clients/cmd/fluent-bit) output plugins.

You can control which versions are built via the following `ARG`s:

```docker
ARG FLB_VERSION=1.8.11-debug
```

## kubectl

Amazon/aws-cli based docker image containing the [`awscli`](https://github.com/aws/aws-cli), [`kubectl`](https://github.com/kubernetes/kubectl) and [`jq`](https://github.com/stedolan/jq).

You can control which versions are built via the following `ARG`s:

```docker
ARG KUBECTL_VERSION=v1.13.3
```

## yq

Alpine based docker image with [`yq`](https://github.com/kislyuk/yq) and [`jq`](https://stedolan.github.io/jq/) tools pre-installed.

## spruce

Alpine based docker image [Spruce](https://github.com/geofffranks/spruce) pre-installed.
