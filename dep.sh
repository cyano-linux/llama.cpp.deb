#!/bin/bash

set -euxo pipefail

if [[ -v MIRROR ]] ; then
  sed -i -e "s/deb.debian.org/${MIRROR}/" /etc/apt/sources.list.d/debian.sources
fi

sed -i -e 's/^Components: .*$/Components: main contrib non-free/' /etc/apt/sources.list.d/debian.sources

apt update
env DEBIAN_FRONTEND=noninteractive \
  apt install -y --no-install-recommends \
    build-essential cmake git pkgconf \
    libopenblas-dev \
    libvulkan-dev glslc \
    nvidia-cuda-toolkit
