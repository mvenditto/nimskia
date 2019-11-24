import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_enums
]
import sample_base

const
  w = 640
  h = 480
  hw = w / 2
  hh = h / 2
  radius = w / 4
  title = "sample: simple circle drawing"

proc main() =

  let paint = newPaint()
  defer: paint.dispose()

  paint.antialias = true
  paint.strokeWidth = 4.0

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(LightGray)
    paint.color = Blue
    paint.style = Fill
    canvas.drawCircle(hw, hh, radius, paint)
    paint.color = Red
    paint.style = Stroke
    canvas.drawCircle(hw, hh, radius, paint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
