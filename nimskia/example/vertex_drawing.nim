import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_enums,
  sk_point,
  sk_bitmap,
  sk_shader,
  sk_vertices
]
import sample_base

import sequtils
import sugar

const
  w = 640
  h = 480
  hw = w / 2
  hh = h / 2
  title = "sample: vertex drawing (triangle"

proc drawTriangle(canvas: SkCanvas, paint: SkPaint) =

  let r = 65.0
  let(cx,cy) = (hw * 0.5, hh * 0.5)

  let vertices = [
    (cx + r, cy - r).SkPoint,
    (cx - r, cy - r),
    (cx, cy + r)
  ]

  let colors = @[
    Red,
    Green,
    Blue
  ]

  canvas.drawVertices(Triangles, vertices, colors, paint)


proc drawBox(canvas: SkCanvas, paint: SkPaint) =

  let r = 65.0
  let(cx,cy) = (hw * 1.5, hh * 0.5)

  let vertices = [
    (cx - r, cy + r).SkPoint,
    (cx + r, cy + r),
    (cx + r, cy - r),
    (cx - r, cy - r),
  ]

  let colors = @[
    Red,
    Yellow,
    Blue,
    Violet
  ]

  canvas.drawVertices(TriangleFan, vertices, colors, paint)

proc drawTexturedBox(canvas: SkCanvas, paint: SkPaint) =
  
  let r = 65.0
  let(cx,cy) = (hw * 1.5, hh * 1.5)

  let vertices = [
    (cx - r, cy + r).SkPoint,
    (cx + r, cy + r),
    (cx + r, cy - r),
    (cx - r, cy - r),
  ]

  let(tw,th) = (512.0, 512.0)

  let texs = [ 
    (0.0, 0.0).SkPoint,
    (0.0, th),
    (tw, th),
    (0.0, th)
  ]

  let colors = @[
    Red,
    Yellow,
    Blue,
    Violet
  ]

  let verts = copy(TriangleFan, vertices, texs, colors)
  
  canvas.drawVertices(verts, Modulate, paint)


proc drawTexturedTriangle(canvas: SkCanvas, paint: SkPaint) =

  let r = 65.0
  let(cx,cy) = (hw * 0.5, hh * 1.5)

  let vertices = [
    (cx + r, cy - r).SkPoint,
    (cx - r, cy - r).SkPoint,
    (cx, cy + r).SkPoint
  ]

  let(tw,th) = (512.0, 512.0)

  let texs = [ 
    (0.0, 0.0).SkPoint,
    (0.0, th),
    (tw, th)
  ]

  let verts = copy(TriangleFan, vertices, texs)
  
  canvas.drawVertices(verts, Modulate, paint)


proc drawTexturedExagon(canvas: SkCanvas, paint: SkPaint) =

  var r = 64.0
  var hr = 32.0
  var(cx, cy) = (hw, hh)

  let vertices = [
    (cx - hr, cy + r).SkPoint,
    (cx - r,  cy),
    (cx - hr, cy - r),
    (cx + hr, cy - r),
    (cx + r,  cy),
    (cx + hr, cy + r),
  ]

  let colors = @[
    Green,Yellow,White,Violet,Red,Cyan
  ]

  let indices = @[
   0.uint16,1,2,3,4,5
  ]

  r = 512
  hr = 256
  (cx, cy) = (256.0, 256.0)

  let texs = [
    (hr, 0.0).SkPoint,
    (0.0, hr),
    (hr, r),
    (r, r),
    (r - hr, r),
    (r, 0.0)
  ]

  let verts = copy(TriangleFan, vertices, texs, colors, indices)

  canvas.drawVertices(verts, Modulate, paint)




proc main() =

  let paint = newSkPaint()
  defer: paint.dispose()
  paint.antialias = true
  paint.strokeWidth = 2.0
  let bmp = decodeBitmap("resources/images/plasma.png")
  paint.shader = newSkBitmapShader(bmp)
  defer: bmp.dispose()

  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(DefaultBg)
    drawTriangle(canvas, paint)
    drawBox(canvas, paint)
    drawTexturedBox(canvas, paint)
    drawTexturedTriangle(canvas, paint)
    drawTexturedExagon(canvas, paint)
    
  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
