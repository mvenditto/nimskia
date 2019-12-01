import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_paint,
  sk_enums,
  sk_path,
  sk_imageinfo
]
import sample_base
import streams
import strformat

const
  w = 640
  h = 480
  title = "sample: path basics"


proc main() =

  var path = newPath();

  path.moveTo(0.5f * w, 0.1f * h) # Define the first contour
      .lineTo(0.2f * w, 0.4f * h)
      .lineTo(0.8f * w, 0.4f * h)
      .lineTo(0.5f * w, 0.1f * h)
      .moveTo(0.5f * w, 0.6f * h) # Define the second contour
      .lineTo(0.2f * w, 0.9f * h)
      .lineTo(0.8f * w, 0.9f * h)
      .close()

  let strokePaint = newPaint()
  strokePaint.style = Stroke
  strokePaint.color = Magenta
  strokePaint.strokeWidth = 25
  strokePaint.antialias = true
  defer: strokePaint.dispose()

  let fillPaint = newPaint()
  fillPaint.color = Cyan
  fillPaint.style = Fill
  defer: fillPaint.dispose()


  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(White)
    canvas.drawPath(path, fillPaint)
    canvas.drawPath(path, strokePaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
