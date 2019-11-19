# nimskia
experimental nim wrapper around skia (unstable) C API

tested on skia revision: 3a296e0fdbe4e327e361d33aae98fe7cf2805488

## Build Skia
```shell
cd skia
bin/sync
gn gen out/Shared --args='is_official_build=true is_component_build=true'
ninja -C out/Shared
```
to run the GLFW example build skia with the nimskia/extra sources included:
```shell
cp nimskia/extra/sk_gpu.c skia/src/c
cp nimskia/extra/sk_gpu.h skia/include/c
```
and modify skia/gn/core.gni as follows:
```shell
...
skia_core_sources = [
  "$_src/c/sk_imageinfo.cpp",
  "$_src/c/sk_paint.cpp",
  "$_src/c/sk_surface.cpp",
  "$_src/c/sk_gpu.cpp", # include sk_gpu.cpp in the build
  "$_src/c/sk_types_priv.h",
...
```
(just a fast, hacky solution to get the bare minimum to setup a simple 
example using a gl backend)
 ## Generate the bindings
```shell
cd nimskia
nimgen nimgen.cfg
```

## Examples
<img src="https://github.com/mvenditto/nimskia/blob/master/nimskia/docs/images/nimskia_glfw.png" 
width="320" height="240" />

### TODO list
- [ ] refactor nimgen.cfg, its actually a mess
- [ ] rewrite and expand the readme
