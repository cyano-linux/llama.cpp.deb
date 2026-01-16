#!/bin/bash

set -euxo pipefail

if [[ -d build ]] ; then
  rm -rf build
fi

if [[ -d pkg ]] ; then
  rm -rf pkg
fi

cmake -S llama.cpp -B build \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DLLAMA_BUILD_TESTS=OFF \
  -DGGML_NATIVE=OFF \
  -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS \
  -DGGML_VULKAN=ON \
  -DGGML_CUDA=ON

cmake --build build --parallel $(nproc)
DESTDIR=$PWD/pkg cmake --install build

mkdir -p pkg/DEBIAN
_version=$(cd llama.cpp && git rev-list HEAD --count)
sed "s/__VERSION__/$_version/" control.in > pkg/DEBIAN/control
dpkg-deb --build pkg llama.cpp_${_version}_amd64.deb
