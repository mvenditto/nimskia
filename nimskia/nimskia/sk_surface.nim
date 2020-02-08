import ../wrapper/sk_types
import ../wrapper/sk_surface

import sk_enums
import sk_canvas
import sk_imageinfo
import sk_image
import sk_colorspace
import gr_context


type
  SKSurface* = ref object
    native*: ptr sk_surface_t
    canvas*: SKCanvas
    props*: SKSurfaceProps

  SKSurfaceProps* = ref object
    native*: ptr sk_surfaceprops_t
    pixelGeometry*: SKPixelGeometry

### SKSurfaceProps

proc newSurfaceProps*(pixelGeometry: SKPixelGeometry): SKSurfaceProps =
  var x: sk_surfaceprops_t 
  SKSurfaceProps(native: x.addr, pixelGeometry: pixelGeometry)

### SKSurface

proc newSurface*(info: SKImageInfo, rowBytes: int, props: SKSurfaceProps): SKSurface =
  var surf = sk_surface_new_raster(
    info.native.addr,
    rowBytes, 
    if isNil props: nil else: props.native
  )
  var nativeCanvas = sk_surface_get_canvas(surf)
  SKSurface(
    native: surf, 
    props: props,
    canvas: SKCanvas(native: nativeCanvas) 
  )

proc newSurface*(info: SKImageInfo): SKSurface =
  return newSurface(info, 0, nil)

proc newSurface*(info: SKImageInfo, rowBytes: int): SKSurface =
  return newSurface(info, rowBytes, nil)

proc newSurface*(info: SKImageInfo, props: SKSurfacePRops): SKSurface =
  return newSurface(info, 0, props)

proc newSurface*(
  ctx: GRContext, 
  target: GRBackendRenderTarget, 
  origin: GRSurfaceOrigin, 
  colorType: SKColorType,
  colorspace: SKColorspace,
  props: SKSurfaceProps
): SKSUrface =
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
  SKSurface(
    native: surf, 
    props: props, 
    canvas: SKCanvas(native: sk_surface_get_canvas(surf))
  )

# TODO: implemente raster direct surface

proc dispose*(this: SKSurface) = sk_surface_unref(this.native)

proc snapshot*(this: SKSurface): SKImage =
  var image = sk_surface_new_image_snapshot(this.native)
  return SKImage(native: image)

proc newSurface*(context: GRContext, budgeted: bool, info: SKImageInfo): SKSurface =
  var surf = sk_surface_new_render_target(context.native, budgeted, info.native.addr, 0, BottomLeft.gr_surfaceorigin_t, nil, false)
  SKSurface(
    native: surf,
    props: nil,
    canvas: SKCanvas(native: sk_surface_get_canvas(surf))
  )