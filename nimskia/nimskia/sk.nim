import ../wrapper/sk_types
import ../wrapper/sk_surface
import ../wrapper/sk_imageinfo
import ../wrapper/sk_image
import ../wrapper/sk_colorspace
import ../wrapper/sk_data
import ../wrapper/sk_paint
import ../wrapper/sk_canvas

type
  SKCanvas* = ref object
    native*: ptr sk_canvas_t

  SKSurface* = ref object
    native*: ptr sk_surface_t
    canvas*: SKCanvas
    props*: SKSurfaceProps
  
  SKSurfaceProps* = ref object
    native*: ptr sk_surfaceprops_t
    pixelGeometry*: SKPixelGeometry

  SKImageInfo* = ref object
    native*: ptr sk_imageinfo_t
    colorspace*: SKColorSpace

  SKImage* = ref object 
    native*: ptr sk_image_t

  SKColorSpace* = ref object
    native*: ptr sk_colorspace_t

  SKData* = ref object
    native*: ptr sk_data_t

  SKPaint* = ref object
    native*: ptr sk_paint_t

  SKRect* = ref object
    native*: sk_rect_t
  
  SKRectI* = ref object
    native*: sk_irect_t

  SKColor* = uint32

  SKPixelGeometry* = enum
    UnknownPixelGeom = UNKNOWN_SK_PIXELGEOMETRY, 
    Rgb_H = RGB_H_SK_PIXELGEOMETRY, 
    Bgr_H = BGR_H_SK_PIXELGEOMETRY,
    Rgb_V = RGB_V_SK_PIXELGEOMETRY, 
    Bgr_V = BGR_V_SK_PIXELGEOMETRY

  SKColorType* = enum
    UnknownColorType = UNKNOWN_SK_COLORTYPE, 
    Rgba_8888 = RGBA_8888_SK_COLORTYPE, 
    Bgra_8888 = BGRA_8888_SK_COLORTYPE,
    Alpha_8 = ALPHA_8_SK_COLORTYPE, 
    Gray_8 = GRAY_8_SK_COLORTYPE, 
    Rgba_F16 =RGBA_F16_SK_COLORTYPE,
    Rgba_F32 = RGBA_F32_SK_COLORTYPE
  
  SKAlphaType* = enum
    Opaque = OPAQUE_SK_ALPHATYPE, 
    Premul = PREMUL_SK_ALPHATYPE, 
    Unpremul = UNPREMUL_SK_ALPHATYPE
  
  SKStrokeCap* = enum
    ButtCap = BUTT_SK_STROKE_CAP, 
    RoundCap = ROUND_SK_STROKE_CAP, 
    SquareCap = SQUARE_SK_STROKE_CAP
  
  SKStrokeJoin* = enum
    MitelJoint = MITER_SK_STROKE_JOIN, 
    RoundJoint = ROUND_SK_STROKE_JOIN, 
    BevelJoint = BEVEL_SK_STROKE_JOIN

template left*(rect: untyped): untyped = rect.left
template top*(rect: untyped): untyped = rect.top
template right*(rect: untyped): untyped = rect.right
template bottom*(rect: untyped): untyped = rect.bottom

proc newRect*(left, top, right, bottom: float): SKRect =
  var rect: sk_rect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRect(native: rect)

proc newRect*(topLeft: (float, float), bottomRight: (float, float)): SKRect =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (float, float), width, heigth: float): SKRect =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + heigth)

### SKRectI

proc newRect*(left, top, right, bottom: int32): SKRectI =
  var rect: sk_irect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRectI(native: rect)

proc newRect*(topLeft: (int32, int32), bottomRight: (int32, int32)): SKRectI =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (int32, int32), width, heigth: int32): SKRectI =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + heigth)

### SKColor

template r*(color: SKColor): byte = sk_color_get_r(color)
template g*(color: SKColor): byte = sk_color_get_g(color)
template b*(color: SKColor): byte = sk_color_get_b(color)
template a*(color: SKColor): byte = sk_color_get_a(color)

template newColorARGB*(a, r, g, b: byte): SKColor = 
  sk_color_set_argb(a, r, g, b).SKColor

### SKColorSpace

proc dispose*(this: SKColorSpace) = sk_colorspace_unref(this.native)

proc newSrgbColorSpace*(): SKColorSpace = SKColorSpace(native: sk_colorspace_new_srgb())

### SKImageInfo

template width*(this: SKImageInfo): int32 = sk_imageinfo_get_width(this.native)

template heigth*(this: SKImageInfo): int32 = sk_imageinfo_get_heigth(this.native)

template colorType*(this: SKImageInfo): SKColorType = sk_imageinfo_get_colortype.SKColorType

template alphaType*(this: SKImageInfo): SKAlphaType = sk_imageinfo_get_alphatype.SKAlphaType

proc dispose*(this: SKImageInfo) = sk_imageinfo_delete(this.native)

proc newImageInfo*(width: int, heigth: int, colorType: SKColorType , alphaType: SKAlphaType, colorspace: SKColorSpace): SKImageInfo =
  let imageInfo = sk_imageinfo_new(
    width.cint, 
    heigth.cint, 
    colorType.sk_colortype_t, 
    alphaType.sk_alphatype_t, 
    colorspace.native)
  SKImageInfo(native: imageInfo, colorspace: colorspace)

### SKSurfaceProps

proc newSurfaceProps*(pixelGeometry: SKPixelGeometry): SKSurfaceProps =
  var x: sk_surfaceprops_t
  x.pixelGeometry = (sk_pixelgeometry_t) pixelGeometry  
  SKSurfaceProps(native: x.addr, pixelGeometry: pixelGeometry)

### SKSurface

proc newRasterSurface*(info: SKImageInfo, props: SKSurfacePRops): SKSUrface =
  # props bugged
  var surf = sk_surface_new_raster(
    info.native, 
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
  return newRasterSurface(info, nil)

proc dispose*(this: SKSurface) = sk_surface_unref(this.native)

proc snapshot*(this: SKSurface): SKImage =
  var image = sk_surface_new_image_snapshot(this.native)
  return SKImage(native: image)

### SKData

proc newEmptyData*(): SKData = 
  SKData(native: sk_data_new_empty())

proc newDataWithCopy*(src: pointer, size: int): SKData = 
  SKData(native: sk_data_new_with_copy(src, size))

proc newDataFromMalloc*(memory: pointer, length: int): SKData =
  SKData(native: sk_data_new_from_malloc(memory, length))

proc newDataSubset*(data: SKData, offset: int, length: int): SKData =
  SKData(native: sk_data_new_subset(data.native, offset, length))

proc dispose*(data: SKData) = sk_data_unref(data.native)

template size*(this: SKData): int = sk_data_get_size(this.native)

template data*(this: SKData): pointer = sk_data_get_data(this.native)

template len*(this: SKData): int = size(this)

### SKImage

proc dispose*(this: SKImage) = sk_image_unref(this.native)

template width*(this: SKImage): int32 = sk_image_get_width(this.native)

template heigth*(this: SKImage): int32 = sk_image_get_heigth(this.native)

template uniqueID*(this: SKImage): uint32 = sk_image_get_unique_id(this.native)

proc encode*(this: SKImage): SKData = 
  SKData(native: sk_image_encode(this.native))

### SKPaint

proc dispose*(this: SKPaint) = sk_paint_delete(this.native)

template isAntialias*(this: SKPaint): bool = sk_paint_is_antialias(this.native)

proc `antialias=`*(this: SKPaint, enabled: bool) = 
  sk_paint_set_antialias(this.native, enabled)

template color*(this: SKPaint): SKColor = sk_paint_get_color(this)

proc `color=`*(this: SKPaint, color: SKColor) =
  sk_paint_set_color(this.native, color.sk_color_t) 

template isStroke*(this: SKPaint): bool = sk_paint_is_stroke(this.native)

template `stroke=`*(this: SKPaint, stroke: bool) = 
  sk_paint_set_stroke(this.native, enabled)

template strokeWidth*(this: SKPaint): float = sk_paint_get_stroke_width(this)

proc `strokeWidth=`*(this: SKPaint, strokeWidth: float) =
  sk_paint_set_stroke_width(this.native, strokeWidth) 

template miterWidth*(this: SKPaint): float = sk_paint_get_stroke_miter(this)

proc `miterWidth=`*(this: SKPaint, miterWidth: float) =
  sk_paint_set_stroke_miter(this.native, miterWidth) 

template strokeCap*(this: SKPaint): SKStrokeCap = sk_paint_get_stroke_cap(this)

proc `strokeCap=`*(this: SKPaint, capType: SKStrokeCap) =
  sk_paint_set_stroke_cap(this.native, capType.sk_stroke_cap_t) 

template joinCap*(this: SKPaint): SKStrokeJoin = sk_paint_get_stroke_join(this)

proc `joinCap=`*(this: SKPaint, jointType: SKStrokeJoin) =
  sk_paint_set_stroke_join(this.native, jointType.sk_stroke_join_t) 


proc newPaint*(): SKPaint = SKPaint(native: sk_paint_new())

proc newPaint*(color: SKColor): SKPaint = 
  result = newPaint()
  result.color = color

### SKCanvas

proc translate*(this: SKCanvas, cx, cy: float) = 
  sk_canvas_translate(this.native, cx, cy)

proc scale*(this: SKCanvas, sx, sy: float) = 
  sk_canvas_scale(this.native, sx, sy)

proc rotateDegrees*(this: SKCanvas, degrees: float) = 
  sk_canvas_rotate_degrees(this.native, degrees)

proc rotateRadians*(this: SKCanvas, radians: float) = 
  sk_canvas_rotate_radians(this.native, radians)

proc drawPaint*(this: SKCanvas, paint: SKPaint) =
  sk_canvas_draw_paint(this.native, paint.native)

proc drawRect*(this: SKCanvas, rect: SKRect, paint: SKPaint) =
  sk_canvas_draw_rect(this.native, rect.native.addr, paint.native)

proc drawCircle*(this: SKCanvas, cx, cy, radius: float, paint: SKPaint) =
  sk_canvas_draw_circle(this.native, cx, cy, radius, paint.native)

proc drawOval*(this: SKCanvas, bounds: SKRect, paint: SKPaint) =
  sk_canvas_draw_oval(this.native, bounds.native.addr, paint.native)

proc drawImage*(this: SKCanvas, image: SKImage, cx: float, cy:float, paint: SKPaint) =
  sk_canvas_draw_image(this.native, image.native, cx, cy, paint.native)


