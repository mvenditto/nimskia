import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_colors,
  sk_enums,
  sk_matrix,
  sk_rect
]
import sample_base

const
  w = 320
  h = 320
  hw = w / 2
  hh = h / 2
  str = "R"
  title = "sample: canvas autoRestore"

proc main() =

  let paint = newSkPaint()
  defer: paint.dispose()

  paint.antialias = true
  paint.color = Black
  paint.textSize=128
  paint.strokeWidth = 4.0

  var textBounds = new(SkRect)
  paint.measureText(str, textBounds)
  let tx = hw - textBounds.width / 2
  let ty = hh + textBounds.height / 2

  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(DefaultBg)
    paint.color = Gray

    canvas.autoRestore:
      canvas.translate(tx,ty)
      canvas.skew(-1.5, 0.0)
      canvas.translate(-tx,-ty)
      canvas.drawText(str, tx, ty, paint)

    paint.color = Black
    canvas.drawText(str, tx, ty, paint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
