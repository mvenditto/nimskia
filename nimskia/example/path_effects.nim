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

  let dash = newSkPath().addOval(newSkRectF(0,0,8,3), Clockwise)
  let oval = newSkPath().addOval(newSkRectF(50,100,430,380), Clockwise)
  let effect1 = sum(
        newSkDescretePathEffect(10.0, 5.0, 795755684),
        newSkDescretePathEffect(20.0, 40.0, 795755684)
    )
  let effect2 = newSk1DPathEffect(dash, 20, 0, Rotate)


  let strokePaint = newSkPaint()
  strokePaint.style = Stroke
  strokePaint.strokeWidth = 2
  strokePaint.strokeCap = RoundCap
  strokePaint.antialias = true
  
  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(White)

    strokePaint.color = Teal
    strokePaint.pathEffect =  effect1
    canvas.drawCircle(240, 240, 100,strokePaint)

    strokePaint.color = DarkRed
    strokePaint.pathEffect =  effect2
    canvas.drawPath(oval, strokePaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
