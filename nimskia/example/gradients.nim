import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_color,
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

  var colors = [
    (0, 0, 255).SKColor, 
    (0, 255, 0).SKColor
  ]
  let linearGrad = newLinearGradient(
    (0.0, 0.0),
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

  let sweepColors = [
    (0, 255, 255).SKColor,
    (255, 0, 255).SKColor,
    (255, 255, 0).SKColor,
    (0, 255, 255).SKColor
  ]
  let sweepGrad = newSweepGradient(
    (rw * 0.5, rh * 1.5),
    rw * 0.5,
    sweepColors,
    Clamp,
    0.0,
    360.0
  )
  defer: sweepGrad.dispose()

  let perlinNoise = newPerlinNoiseFractal(
    0.5, 0.5, 4, 0
  )
  defer: perlinNoise.dispose()

  let perlinNoiseT = newPerlinNoiseTurbolence(
    0.05, 0.05, 4, 0
  )
  defer: perlinNoiseT.dispose()
  
  let composed = compose(sweepGrad, perlinNoiseT, SrcOver)
  defer: composed.dispose()

  var r0: SKRect = newRect(0f, 0f, rw, rh)
  var r1: SKRect = newRect(rw, 0f, rw+rw, rh)
  var r2: SKRect = newRect(2*rw, 0f, rw*3, rh)
  var r3: SKRect = newRect(0f, rh, rw, rh * 2)
  var r4: SKRect = newRect(rw, rh, rw+rw, rh * 2)
  var r5: SKRect = newRect(2*rw, rh, rw*3, rh * 2)
  var r6: SKRect = newRect(0f, 2*rh, rw, rh * 3)

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

    paint.shader = sweepGrad
    canvas.drawRect(r3, paint)
    canvas.drawRect(r3, stroke)

    paint.shader = perlinNoise
    canvas.drawRect(r4, paint)
    canvas.drawRect(r4, stroke)

    paint.shader = perlinNoiseT
    canvas.drawRect(r5, paint)
    canvas.drawRect(r5, stroke)

    paint.shader = composed
    canvas.drawRect(r6, paint)
    canvas.drawRect(r6, stroke)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
