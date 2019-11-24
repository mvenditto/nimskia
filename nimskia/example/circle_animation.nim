import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_color,
  sk_colors,
  sk_enums
]
import sample_base
import math

const
  w = 800
  h = 600
  hw = w / 2
  hh = h / 2
  radius = 75
  cycleTime: float64 = 1000
  title = "sample: circle expand animation"

proc main() =

  let paint = newPaint()
  defer: paint.dispose()
  paint.antialias = true
  paint.style = Stroke
  paint.color = Blue

  var elapsedTot: float64 = 0  
  var elapsed: float64 = 0
  var t = 0.0

  proc fmod(x,y: float64): float64 =
    x - trunc(x / y) * y

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(MidnightBlue)
    
    elapsed += dt * 1000
    elapsedTot += dt * 1000

    if elapsed >= 33:
      t = cast[float](fmod(elapsedTot, cycleTime) / cycleTime)
      elapsed = 0
    
    for c in 0..5:
      let r = radius * (c.float + t)
      paint.strokeWidth = radius / 4 * (if c == 0: t else: 1)
      let a = (255 * (1 - c / 5)).int
      paint.color = (a, 0xBC, 0xEE, 0xFF)
      canvas.drawCircle(hw, hh, r, paint)
    
    canvas.flush()

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
