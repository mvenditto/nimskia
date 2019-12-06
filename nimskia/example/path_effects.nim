import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_paint,
  sk_enums,
  sk_path,
  sk_rect,
  sk_patheffect,
  sk_imageinfo,
  sk_surface
]
import sample_base

const
  w = 480
  h = 480
  title = "sample: path effects"

proc main() =

  let dash = newPath().addOval(newRectF(0,0,16,6), Clockwise)

  let strokePaint = newPaint()
  strokePaint.style = Stroke
  strokePaint.color = Blue
  strokePaint.strokeWidth = 2
  strokePaint.strokeCap = RoundCap
  strokePaint.antialias = true
  strokePaint.pathEffect = new1DPathEffect(dash, 32.0, 0.0, Rotate)
  
  # newDescretePathEffect(10.0, 5.0, 132344)
  
  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(White)
    
    canvas.drawCircle(240, 240, 122,strokePaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
