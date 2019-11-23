import ../wrapper/sk_types
import ../wrapper/sk_surface
import sk_enums
import sk_canvas
import sk_imageinfo
import sk_image


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

proc newRasterSurface*(info: SKImageInfo, rowBytes: int, props: SKSurfacePRops): SKSUrface =
  # props bugged
  var surf = sk_surface_new_raster(
    info.native.addr,
    rowBytes, 
    if isNil props: nil else: props.native
  )
  var nativeCanvas = sk_surface_get_canvas(surf)
  var canvas = SKCanvas(native: nativeCanvas) 
  SKSurface(
    native: surf, 
    props: props,
    canvas: canvas
  )

proc newRasterSurface*(info: SKImageInfo): SKSurface =
  return newRasterSurface(info, 0, nil)

proc dispose*(this: SKSurface) = sk_surface_unref(this.native)

proc snapshot*(this: SKSurface): SKImage =
  var image = sk_surface_new_image_snapshot(this.native)
  return SKImage(native: image)