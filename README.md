# Dev Container Images

Dev containers providing development environments for programmers working of different types of projects.

## Content

* [Cloud Developer](cloud-developer/README.md)
* [Web Developer](web-developer/README.md)

## Prerequisites

1. Install Docker engine (e.g.: Rancher Desktop on Windows)
2. (Optional) Share local git credentials with dev container (see [documentation](https://code.visualstudio.com/remote/advancedcontainers/sharing-git-credentials))

## Known issues

* using root user
* users mustn't be added in Dockerfile ([link](https://cloud.google.com/workstations/docs/customize-container-images#cloud-workstations-base-image-structure))
* command completion doesn't work
