import ../wrapper/sk_types
import ../wrapper/sk_surface

import sk_enums
import sk_canvas
import sk_imageinfo
import sk_image
import sk_colorspace
import gr_context


type
  SkSurface* = ref object
    native*: ptr sk_surface_t
    canvas*: SkCanvas
    props*: SkSurfaceProps

  SkSurfaceProps* = ref object
    native*: ptr sk_surfaceprops_t
    pixelGeometry*: SkPixelGeometry

### SkSurfaceProps

proc newSkSurfaceProps*(pixelGeometry: SkPixelGeometry): SkSurfaceProps =
  var x: sk_surfaceprops_t 
  SkSurfaceProps(native: x.addr, pixelGeometry: pixelGeometry)

### SkSurface

proc newSkSurface*(info: SkImageInfo, rowBytes: int, props: SkSurfaceProps): SkSurface =
  var surf = sk_surface_new_raster(
    info.native.addr,
    rowBytes, 
    if isNil props: nil else: props.native
  )
  var nativeCanvas = sk_surface_get_canvas(surf)
  SkSurface(
    native: surf, 
    props: props,
    canvas: SkCanvas(native: nativeCanvas) 
  )

proc newSkSurface*(info: SkImageInfo): SkSurface =
  return newSkSurface(info, 0, nil)

proc newSkSurface*(info: SkImageInfo, rowBytes: int): SkSurface =
  return newSkSurface(info, rowBytes, nil)

proc newSkSurface*(info: SkImageInfo, props: SkSurfacePRops): SkSurface =
  return newSkSurface(info, 0, props)

proc newSkSurface*(
  ctx: GRContext, 
  target: GRBackendRenderTarget, 
  origin: GRSurfaceOrigin, 
  colorType: SkColorType,
  colorspace: SkColorspace,
  props: SkSurfaceProps
): SkSUrface =
  assert(not isNil ctx, "Context cannot be nil")
  assert(not isNil target, "Target cannot be nil")  
  echo $(cast[uint32](ctx))
  echo $(cast[uint32](target))
  echo $(cast[uint32](colorType))
  
  var surf = sk_surface_new_backend_render_target(
    ctx.native, 
    target.native, 
    origin.gr_surfaceorigin_t,
    colorType.sk_colortype_t,
    if not isNil colorspace: colorspace.native else: nil,
    if not isNil props: props.native else: nil,
  )
  SkSurface(
    native: surf, 
    props: props, 
    canvas: SkCanvas(native: sk_surface_get_canvas(surf))
  )

# TODO: implemente raster direct surface

proc dispose*(this: SkSurface) = sk_surface_unref(this.native)

proc snapshot*(this: SkSurface): SkImage =
  var image = sk_surface_new_image_snapshot(this.native)
  return SkImage(native: image)

proc newSkSurface*(context: GRContext, budgeted: bool, info: SkImageInfo): SkSurface =
  var surf = sk_surface_new_render_target(context.native, budgeted, info.native.addr, 0, BottomLeft.gr_surfaceorigin_t, nil, false)
  SkSurface(
    native: surf,
    props: nil,
    canvas: SkCanvas(native: sk_surface_get_canvas(surf))
  )