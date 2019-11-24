import ../wrapper/sk_types
import ../wrapper/sk_paint

import sk_color
import sk_enums

type
  SKPaint* = ref object
    native*: ptr sk_paint_t

proc dispose*(this: SKPaint) = sk_paint_delete(this.native)

template isAntialias*(this: SKPaint): bool = sk_paint_is_antialias(this.native)

proc `antialias=`*(this: SKPaint, enabled: bool) = 
  sk_paint_set_antialias(this.native, enabled)

template color*(this: SKPaint): SKColor = sk_paint_get_color(this)

proc `color=`*(this: SKPaint, color: SKColor) =
  sk_paint_set_color(this.native, color.sk_color_t) 

proc `color=`*(this: SKPaint, argb: (byte,byte,byte,byte)) =
  var(a,r,g,b) = argb
  sk_paint_set_color(this.native, newColorARGB(a,r,g,b)) 

template isStroke*(this: SKPaint): bool = sk_paint_is_stroke(this.native)

template `stroke=`*(this: SKPaint, stroke: bool) = 
  sk_paint_set_stroke(this.native, enabled)

template style*(this: SKPaint): SKPaintStyle = 
  sk_paint_get_style(this.native).SKPaintStyle

template `style=`*(this: SKPaint, style: SKPaintStyle) = 
  sk_paint_set_style(this.native, cast[sk_paint_style_t](style))

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

proc newPaint*(a,r,g,b: byte): SKPaint = 
  result = newPaint()
  result.color = newColorARGB(a,r,g,b)
