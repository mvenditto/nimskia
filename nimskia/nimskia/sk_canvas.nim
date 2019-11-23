import ../wrapper/sk_types
import ../wrapper/sk_canvas
import sk_paint
import sk_rect
import sk_image

type
  SKCanvas* = ref object
    native*: ptr sk_canvas_t

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