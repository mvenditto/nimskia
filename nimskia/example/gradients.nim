import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_shader,
  sk_point,
  sk_rect,
  sk_enums
]
import sample_base

const
  w = 768
  h = 768
  rw: float = 256
  rh: float = 256

  title = "sample: shader gradients"

proc main() =

  var colors = [Blue, Green]
  let linearGrad = newLinearGradient(
    (0, 0),
    (rw, rh),
    colors,
    Clamp
  )
  defer: linearGrad.dispose()

  let radialGrad = newRadialGradient(
    (rw * 1.5, rh * 0.5),
    180,
    colors,
    [1.float, 2],
    Clamp
  )
  defer: radialGrad.dispose()

  let tcpGrad = newTwoPointConicalGradient(
    (rw * 2.5, rh * 0.5),
    rh * 0.5,
    (rw * 2.5, 16.0),
    16.0,
    colors,
    [1.float, 2],
    Clamp
  )
  defer: tcpGrad.dispose()

  var r0: SKRect = newRect(0f, 0f, rw, rh)
  var r1: SKRect = newRect(rw, 0f, rw+rw, rh)
  var r2: SKRect = newRect(2*rw, 0f, rw*3, rh)

  let paint = newPaint()
  defer: paint.dispose()

  let stroke = newPaint()
  stroke.style = Stroke
  stroke.strokeWidth = 2
  stroke.color = DarkGray
  defer: stroke.dispose()

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(White)

    paint.shader = linearGrad
    canvas.drawRect(r0, paint)
    canvas.drawRect(r0, stroke)

    paint.shader = radialGrad
    canvas.drawRect(r1, paint)
    canvas.drawRect(r1, stroke)

    paint.shader = tcpGrad
    canvas.drawRect(r2, paint)
    canvas.drawRect(r2, stroke)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
