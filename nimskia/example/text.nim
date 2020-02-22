import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_enums,
  sk_rect,
  sk_paint
]
import sample_base

const
  w = 640
  h = 480
  title = "sample: text basics"

proc main() =

  let textPaint = newSkPaint(Chocolate)
  textPaint.antialias = true
  let str = "Hello NimSkia!";
  let textWidth = textPaint.measureText(str)
  
  textPaint.textSize = 0.9 * w * textPaint.textSize / textWidth

  var textBounds = new(SkRect)
  textPaint.measureText(str, textBounds)
  echo $textBounds

  let xText = w / 2 - textBounds.midX
  let yText = h / 2 - textBounds.midY

  let framePaint = newSkPaint()
  framePaint.style = Stroke
  framePaint.strokeWidth = 4.0
  framePaint.antialias = true
  defer: framePaint.dispose()

  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(White)
    canvas.drawText(str, xText, yText, textPaint)
    var textFrame = textBounds.inflated(10, 10)
    textFrame.offset(xText, yText)
    framePaint.color = Blue
    canvas.drawRoundRect(textFrame, 20, 20, framePaint)
    textFrame.inflate(10, 10)
    framePaint.color = DarkBlue
    canvas.drawRoundRect(textFrame, 30, 30, framePaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
