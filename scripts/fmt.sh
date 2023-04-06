#!/bin/bash
set -e
docker run --rm -v "$(pwd):/project" -w /project hashicorp/packer:1.8 fmt .
