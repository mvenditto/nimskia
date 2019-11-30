import ../wrapper/sk_types
import ../wrapper/sk_paint

import sk_color
import sk_enums
import sk_shader

type
  SKPaint* = ref object
    native*: ptr sk_paint_t

proc dispose*(this: SKPaint) = sk_paint_delete(this.native)

template isAntialias*(this: SKPaint): bool = sk_paint_is_antialias(this.native)

proc `antialias=`*(this: SKPaint, enabled: bool) = 
  sk_paint_set_antialias(this.native, enabled)

template color*(this: SKPaint): SKColor = 
  sk_paint_get_color(this.native).SKColor

proc `color=`*(this: SKPaint, color: SKColor) =
  sk_paint_set_color(this.native, color.sk_color_t)

proc `color=`*(this: SKPaint, argb: (int,int,int,int)) =
  var(a,r,g,b) = argb
  sk_paint_set_color(this.native, newColorARGB(a,r,g,b)) 

template style*(this: SKPaint): SKPaintStyle = 
  sk_paint_get_style(this.native).SKPaintStyle

proc `style=`*(this: SKPaint, style: SKPaintStyle) = 
  sk_paint_set_style(this.native, cast[sk_paint_style_t](style))

proc isStroke*(this: SKPaint): bool = 
  this.style == Stroke

proc `shader=`*(this: SKPaint, shader: SKShader) =
  sk_paint_set_shader(
    this.native, 
    if not isNil shader: shader.native else: nil
  )

proc shader*(this: SKPaint): SKShader = 
  SKShader(native: sk_paint_get_shader(this.native))

template strokeWidth*(this: SKPaint): float = 
  sk_paint_get_stroke_width(this.native).float

proc `strokeWidth=`*(this: SKPaint, strokeWidth: float) =
  sk_paint_set_stroke_width(this.native, strokeWidth) 

template miterWidth*(this: SKPaint): float = sk_paint_get_stroke_miter(this.native)

proc `miterWidth=`*(this: SKPaint, miterWidth: float) =
  sk_paint_set_stroke_miter(this.native, miterWidth) 

template strokeCap*(this: SKPaint): SKStrokeCap = 
  sk_paint_get_stroke_cap(this.native).SKStrokeCap

proc `strokeCap=`*(this: SKPaint, capType: SKStrokeCap) =
  sk_paint_set_stroke_cap(this.native, capType.sk_stroke_cap_t) 

template joinCap*(this: SKPaint): SKStrokeJoin = 
  sk_paint_get_stroke_join(this.native).SKStrokeJoin

proc `joinCap=`*(this: SKPaint, jointType: SKStrokeJoin) =
  sk_paint_set_stroke_join(this.native, jointType.sk_stroke_join_t) 

proc newPaint*(): SKPaint = SKPaint(native: sk_paint_new())

proc newPaint*(color: SKColor): SKPaint = 
  result = newPaint()
  result.color = color

proc newPaint*(a,r,g,b: int): SKPaint = 
  result = newPaint()
  result.color = newColorARGB(a,r,g,b)
