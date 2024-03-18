#!/bin/sh

docker run --rm -it -v ./:/app registry.gitlab.com/vigigloo/tools/helm-readme-generator:2.6.0.1 -v values.yaml -r README.md
