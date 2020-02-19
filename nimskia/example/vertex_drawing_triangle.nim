import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_enums,
  sk_point
]
import sample_base

const
  w = 640
  h = 480
  hw = w / 2
  hh = h / 2
  title = "sample: vertex drawing (triangle"

proc main() =

  let paint = newPaint()
  defer: paint.dispose()

  paint.antialias = true
  paint.strokeWidth = 2.0

  let r = 150.0

  var vertices = @[
    (hw - r, hh + r).SKPoint,
    (hw + r, hh + r),
    (hw, hh - r)
  ]

  var colors = @[
    Red,
    Green,
    Blue
  ]

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(LightGray)
    canvas.drawVertices(Triangles, vertices, colors, paint)
    

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
