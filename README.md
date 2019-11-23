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
snippet of the "high-level" api build upon the raw bindings (wip)
```nim

proc draw(canvas: SKCanvas) =
  let paint = newPaint(color = Blue)
  defer: paint.dispose()
  canvas.drawPaint(paint)

  paint.color = newColorARGB(255, 0, 255, 255) # Cyan
  let rect = newRect(100.float, 100, 540, 380)
  canvas.drawRect(rect, paint)

  paint.color = newColorARGB(0x80, 0x00, 0xFF, 0x00)
  let bounds = newRect(120.0, 120.0, 520.0, 360.0)
  canvas.drawOval(bounds, paint)

proc emitPng(path: string; surface: SKSurface) =
  var image = surface.snapshot()
  defer: image.dispose()
  
  var data = image.encode()
  defer: data.dispose()

  var f = open(path, fmWrite)
  var dataBuff = data.data
  var dataLen = len(data)
  discard f.writeBuffer(dataBuff, dataLen)
  f.close()

proc main() =
  var cs = newSrgbColorSpace()
  var info = newImageInfo(640, 480, Rgba_8888, Premul, cs)
  var surface = newRasterSurface(info)
  draw(surface.canvas)
  emitPng("out.png", surface);
```
nimskia + glfw (nimgl)

<img src="https://github.com/mvenditto/nimskia/blob/master/nimskia/docs/images/nimskia_glfw.png" 
width="320" height="240" />

### TODO list
- [ ] switch to mono/skia?
- [ ] refactor nimgen.cfg, its actually a mess
- [ ] rewrite and expand the readme
