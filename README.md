# docker-images

This repository contains the Docker setup to build a number of derived/customised
Docker images. Each folder contains the setup for a single image.

The Concourse pipeline to build all images can be found in the
[skyscrapers/ci](https://github.com/skyscrapers/ci) repository.

## actions-runner

This is a Docker image based on the official GitHub Actions runner image. It is used to run GitHub Actions on a self-hosted runner in a Kubernetes cluster.
Our layer adds our most used tools onto the official image.

The image is build with GitHub actions and pushed to the `ghcr.io/skyscrapers/actions-runner` repository.

## Atlantis

This is a Docker image for [Atlantis](https://www.runatlantis.io/). We put our layer on top of the official Atlantis image that inludes our tools from our Terragrunt image.

## Inotify-tools

This is an Alpine based Docker image with the `inotify-tools` package installed.

## Terragrunt

This is a Docker image that contains all the tools needed to run Terragrunt in Skyscrapers:

* [AWS CLI](https://aws.amazon.com/cli/)
* [Helm](https://helm.sh/)
* [Kubectl](https://kubernetes.io/docs/reference/kubectl/overview/)
* [OpenTofu](https://github.com/opentofu/opentofu)
* [Sops](https://github.com/mozilla/sops)
* [Terragrunt](https://terragrunt.gruntwork.io/)

## fluent-bit

A [fluent-bit](https://github.com/fluent/fluent-bit) image including the [logzio-output](https://github.com/logzio/fluent-bit-logzio-output) output plugin.

You can control which versions are built via the following `ARG`s:

```docker
ARG FLB_VERSION=2.2.1-debug
```

## yq

Alpine based docker image with [`yq`](https://github.com/kislyuk/yq) and [`jq`](https://stedolan.github.io/jq/) tools pre-installed.

## spruce

Alpine based docker image [Spruce](https://github.com/geofffranks/spruce) pre-installed.
