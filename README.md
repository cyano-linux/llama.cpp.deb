# llama.cpp for Debian 13 (OpenBLAS, CUDA, Vulkan)

```bash
podman run -it --rm -v $PWD:/mnt -w /mnt docker.io/amd64/debian:13
```

In container:

```bash
# optionally set mirror:
export MIRROR=mirrors.kernel.org

./dep.sh
./build.sh
```
