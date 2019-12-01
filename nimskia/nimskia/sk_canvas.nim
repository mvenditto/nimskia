import ../wrapper/sk_types
import ../wrapper/sk_canvas

import sk_paint
import sk_rect
import sk_image
import sk_color
import sk_enums
import sk_path
import sk_bitmap
import sk_matrix

import macros

type
  SKCanvas* = ref object
    native*: ptr sk_canvas_t

proc newCanvas*(bitmap: SKBitmap): SKCanvas =
  SKCanvas(native: sk_canvas_new_from_bitmap(bitmap.native))

proc translate*(this: SKCanvas, cx, cy: float) = 
  sk_canvas_translate(this.native, cx, cy)

proc scale*(this: SKCanvas, sx, sy: float) = 
  sk_canvas_scale(this.native, sx, sy)

proc scale*(this: SKCanvas, sx, sy, px, py: float) =
  sk_canvas_translate(this.native, px, py)
  sk_canvas_scale(this.native, sx, sy) 
  sk_canvas_translate(this.native, -px, -py)

proc rotateDegrees*(this: SKCanvas, degrees: float) = 
  sk_canvas_rotate_degrees(this.native, degrees)

proc rotateRadians*(this: SKCanvas, radians: float) = 
  sk_canvas_rotate_radians(this.native, radians)

proc drawPaint*(this: SKCanvas, paint: SKPaint) =
  sk_canvas_draw_paint(this.native, paint.native)

proc drawRect*(this: SKCanvas, rect: SKRect, paint: SKPaint) =
  sk_canvas_draw_rect(this.native, rect.native.addr, paint.native)

proc drawRect*(this: SKCanvas, rect: SKRectI, paint: SKPaint) =
  # TODO: fixme
  sk_canvas_draw_rect(this.native, cast[ptr sk_rect_t](rect.native.addr), paint.native)

proc drawCircle*(this: SKCanvas, cx, cy, radius: float, paint: SKPaint) =
  sk_canvas_draw_circle(this.native, cx, cy, radius, paint.native)

proc drawOval*(this: SKCanvas, bounds: SKRect, paint: SKPaint) =
  sk_canvas_draw_oval(this.native, bounds.native.addr, paint.native)

proc drawImage*(this: SKCanvas, image: SKImage, cx: float, cy:float, paint: SKPaint) =
  sk_canvas_draw_image(this.native, image.native, cx, cy, paint.native)

proc drawColor*(this: SKCanvas, color: SKColor, mode: SKBlendMode) =
  sk_canvas_draw_color(this.native, color.sk_color_t, mode.sk_blendmode_t)

proc drawPath*(this: SKCanvas, path: SKPath, paint: SKPaint) =
  sk_canvas_draw_path(this.native, path.native, paint.native)

proc drawBitmap*(this: SKCanvas, bitmap: SKBitmap, left: float, top: float, paint: SKPaint) =
  sk_canvas_draw_bitmap(
    this.native,
    bitmap.native,
    left,
    top,
    paint.native
  )

proc drawBitmap*(this: SKCanvas, bitmap: SKBitmap, left: float, top: float) =
  var paint = newPaint()
  drawBitmap(this, bitmap, left, top, paint)
  paint.dispose()

proc drawBitmap*(this: SKCanvas, bitmap: SKBitmap) =
  var paint = newPaint()
  drawBitmap(this, bitmap, 0, 0, paint)
  paint.dispose()

proc dispose*(this: SKCanvas) =
  sk_canvas_destroy(this.native)

proc save*(this: SKCanvas): int =
  sk_canvas_save(this.native)

proc save_layer*(this: SKCanvas, bounds: SKRect, paint: SKPaint): int =
  sk_canvas_save_layer(this.native, bounds.native.addr, paint.native)

proc restore*(this: SKCanvas) =
  sk_canvas_restore(this.native)

proc clear*(this: SKCanvas, color: SKColor) =
  sk_canvas_clear(this.native, color.sk_color_t)

proc clip*(this: SKCanvas, bounds: SKRect, clipop: SKClipOp, doAA: bool) =
  sk_canvas_clip_rect_with_operation(this.native, bounds.native.addr, clipop.sk_clipop_t, doAA)

proc flush*(this: SKCanvas) =
  sk_canvas_flush(this.native)

proc resetMatrix*(this: SKCanvas) =
  sk_canvas_reset_matrix(this.native)

proc setMatrix*(this: SKCanvas, matrix: SKMatrix) =
  sk_canvas_set_matrix(this.native, matrix.native)

proc concatMatrix*(this: SKCanvas, matrix: SKMatrix) =
  sk_canvas_concat(this.native, matrix.native)

template autoRestore*(canvas: SKCanvas, ops: untyped): untyped =
  discard canvas.save()
  ops
  canvas.restore()