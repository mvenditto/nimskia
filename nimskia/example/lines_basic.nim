import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_paint,
  sk_enums
]
import sample_base
import streams
import strformat

const
  w = 640
  h = 480
  title = "sample: line and stroke caps"


proc main() =

  let textPaint = newPaint()
  textPaint.color = Black
  textPaint.textSize = 40
  textPaint.textAlign = Center
  textPaint.antialias = true
  defer: textPaint.dispose()

  let thickLinePaint = newPaint()
  thickLinePaint.color = Orange
  thickLinePaint.style = Stroke
  thickLinePaint.strokeWidth = 35
  thickLinePaint.antialias = true
  defer: thickLinePaint.dispose()

  let thinLinePaint = newPaint()
  thinLinePaint.color = Black
  thinLinePaint.style = Stroke
  thinLinePaint.strokeWidth = 2
  thinLinePaint.antialias = true
  defer: thinLinePaint.dispose()

  let xText = w / 2
  let xLine1 = 100.float
  let xLine2 = w - xLine1

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(White)

    var y = textPaint.fontSpacing
    for cap in SKStrokeCap:
      canvas.drawText($cap, xText, y, textPaint)
      y += textPaint.fontSpacing;

      thickLinePaint.strokeCap = cap
      canvas.drawLine(xLine1, y, xLine2, y, thickLinePaint)

      canvas.drawLine(xLine1, y, xLine2, y, thinLinePaint);
      y += 2 * textPaint.fontSpacing;

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
