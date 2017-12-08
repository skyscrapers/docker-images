Extension to PostgreSQL 9.5 for Zenhub Charts
=============================================

This image is an extension to the official _postgres_ image which creates an empty database
at first boot for Zenhub Charts.

## Prerequisites

* [Docker](https://www.docker.com/) v1.5.0 or up
* Internet access
* A Unix shell (Cygwin might work but is not tested)

## Building the image

The image is built as part of `docker-compose up` in the project root.

Extending the PostgreSQL image is described in the section 
[How to extend this image](https://registry.hub.docker.com/_/postgres/)
of the PostgreSQL Docker Hub page.
