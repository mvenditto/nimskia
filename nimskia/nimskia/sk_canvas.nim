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
import sk_data
import sk_point
import sk_vertices
import sk_lattice

import sequtils
import sugar

import internals/native

type
  SkCanvas* = ref object of SkObject[sk_canvas_t]

proc newSkCanvas*(bitmap: SkBitmap): SkCanvas =
  SkCanvas(native: sk_canvas_new_from_bitmap(bitmap.native))

proc translate*(this: SkCanvas, cx, cy: float) = 
  sk_canvas_translate(this.native, cx, cy)

proc scale*(this: SkCanvas, sx, sy: float) = 
  sk_canvas_scale(this.native, sx, sy)

proc scale*(this: SkCanvas, sx, sy, px, py: float) =
  sk_canvas_translate(this.native, px, py)
  sk_canvas_scale(this.native, sx, sy) 
  sk_canvas_translate(this.native, -px, -py)

proc rotateDegrees*(this: SkCanvas, degrees: float) = 
  sk_canvas_rotate_degrees(this.native, degrees)

proc rotateRadians*(this: SkCanvas, radians: float) = 
  sk_canvas_rotate_radians(this.native, radians)

proc drawPaint*(this: SkCanvas, paint: SkPaint) =
  sk_canvas_draw_paint(this.native, paint.native)

proc drawRect*(this: SkCanvas, rect: SkRect, paint: SkPaint) =
  sk_canvas_draw_rect(this.native, rect.native.addr, paint.native)

proc drawRect*(this: SkCanvas, rect: SkRectI, paint: SkPaint) =
  # TODO: fixme
  var r: SkRect = (rect.top.float, rect.left.float, rect.bottom.float, rect.right.float)
  sk_canvas_draw_rect(this.native, r.native.addr, paint.native)

proc drawRoundRect*(this: SkCanvas, rect: SkRect, rx: float, ry: float, paint: SkPaint) =
  sk_canvas_draw_round_rect(this.native, cast[ptr sk_rect_t](rect.native.addr), rx, ry, paint.native)

proc drawCircle*(this: SkCanvas, cx, cy, radius: float, paint: SkPaint) =
  sk_canvas_draw_circle(this.native, cx, cy, radius, paint.native)

proc drawOval*(this: SkCanvas, bounds: SkRect, paint: SkPaint) =
  sk_canvas_draw_oval(this.native, bounds.native.addr, paint.native)

proc drawImage*(this: SkCanvas, image: SkImage, cx: float, cy:float, paint: SkPaint) =
  sk_canvas_draw_image(this.native, image.native, cx, cy, paint.native)

proc drawColor*(this: SkCanvas, color: SkColor, mode: SkBlendMode) =
  sk_canvas_draw_color(this.native, color.sk_color_t, mode.sk_blendmode_t)

proc drawPath*(this: SkCanvas, path: SkPath, paint: SkPaint) =
  sk_canvas_draw_path(this.native, path.native, paint.native)

proc drawLine*(this: SkCanvas, x1: float, y1: float, x2: float, y2: float, paint: SkPaint) =
  sk_canvas_draw_line(this.native, x1, y1, x2, y2, paint.native)

proc drawBitmap*(this: SkCanvas, bitmap: SkBitmap, left: float, top: float, paint: SkPaint) =
  sk_canvas_draw_bitmap(
    this.native,
    bitmap.native,
    left,
    top,
    paint.native
  )

proc drawBitmap*(this: SkCanvas, bitmap: SkBitmap, left: float, top: float) =
  var paint = newSkPaint()
  drawBitmap(this, bitmap, left, top, paint)
  paint.dispose()

proc drawBitmap*(this: SkCanvas, bitmap: SkBitmap) =
  var paint = newSkPaint()
  drawBitmap(this, bitmap, 0, 0, paint)
  paint.dispose()

proc drawText*(this: SkCanvas, text: string, x: float, y: float, paint: SkPaint) =
  sk_canvas_draw_text(this.native, text.cstring, len(text), x, y, paint.native)

proc drawPositionedText*(this: SkCanvas, text: string, points: seq[SkPoint], paint: SkPaint) =
  sk_canvas_draw_pos_text(this.native, text.cstring, points.len, cast[ptr sk_point_t](points[0].unsafeAddr), paint.native)

proc drawPositionedText*(this: SkCanvas, text: seq[byte], points: seq[SkPoint], paint: SkPaint) =
  
  let str = newString(text.len)
  copyMem(str.cstring, text[0].unsafeAddr, text.len)

  let pointsNative = points.map(p => p[])
  let pointsPtr = cast[ptr sk_point_t](pointsNative[0].unsafeAddr)
 
  sk_canvas_draw_pos_text(
    this.native, 
    str, 
    text.len, 
    pointsPtr, 
    paint.native)


proc dispose*(this: SkCanvas) =
  sk_canvas_destroy(this.native)

proc save*(this: SkCanvas): int =
  sk_canvas_save(this.native)

proc save_layer*(this: SkCanvas, bounds: SkRect, paint: SkPaint): int =
  sk_canvas_save_layer(this.native, bounds.native.addr, paint.native)

proc restore*(this: SkCanvas) =
  sk_canvas_restore(this.native)

proc clear*(this: SkCanvas, color: SkColor) =
  sk_canvas_clear(this.native, color.sk_color_t)

proc clip*(this: SkCanvas, bounds: SkRect, clipop: SkClipOp, doAA: bool) =
  sk_canvas_clip_rect_with_operation(this.native, bounds.native.addr, clipop.sk_clipop_t, doAA)

proc flush*(this: SkCanvas) =
  sk_canvas_flush(this.native)

proc resetMatrix*(this: SkCanvas) =
  sk_canvas_reset_matrix(this.native)

proc setMatrix*(this: SkCanvas, matrix: SkMatrix) =
  sk_canvas_set_matrix(this.native, matrix.native)

proc concatMatrix*(this: SkCanvas, matrix: SkMatrix) =
  sk_canvas_concat(this.native, matrix.native)

proc skew*(this: SkCanvas, sx,sy: float) =
  sk_canvas_skew(this.native, sx, sy)

template autoRestore*(canvas: SkCanvas, ops: untyped): untyped =
  discard canvas.save()
  ops
  canvas.restore()

proc drawLinkDestinationAnnotation*(this: SkCanvas, rect: SkRect, value: SkData) =
  sk_canvas_draw_link_destination_annotation(
    this.native, 
    rect.native.addr, 
    value.native
  )

proc drawLinkDestinationAnnotation*(this: SkCanvas, rect: SkRect, value: string) =
  let data = newSkData(value)
  sk_canvas_draw_link_destination_annotation(
    this.native, 
    rect.native.addr, 
    data.native
  )

proc drawNamedDestinationAnnotation*(this: SkCanvas, point: SkPoint, value: SkData) =
  sk_canvas_draw_named_destination_annotation(
    this.native,
    point[].addr,
    value.native
  )

proc drawNamedDestinationAnnotation*(this: SkCanvas, point: SkPoint, value: string) =
  let data = newSkData(value)
  sk_canvas_draw_named_destination_annotation(
    this.native,
    point[].addr,
    data.native
  )
  
proc drawVertices*(this: SkCanvas, vertices: SkVertices, mode: SkBlendMode, paint: SkPaint) =
  sk_canvas_draw_vertices(
    this.native, vertices.native, mode.sk_blendmode_t, paint.native
  )

proc drawVertices*(
  this: SkCanvas, 
  vmode: SkVertexMode,
  vertices: openArray[SkPoint],
  colors: openArray[SkColor],
  paint: SkPaint
) =
  let verts = copy(vmode, vertices, colors)
  this.drawVertices(verts, Modulate, paint)
  

proc drawBitmapLattice*(this: SkCanvas, bitmap: SkBitmap, lattice: SkLattice, dst: SkRect, paint: SkPaint = nil) = 
  sk_canvas_draw_bitmap_lattice(
    this.native, 
    bitmap.native, 
    lattice.native.addr, 
    dst.native.addr,
    if isNil paint: nil else: paint.native
  )

