import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_paint,
  sk_enums,
  sk_path,
  sk_point
]
import sample_base
import math
import nimgl/glfw

type
  DrawMode = enum
    FillOnly
    StrokeOnly
    StrokeThenFill
    FillThenStroke

const
  w = 640
  h = 480
  title = "sample: path fill types"
  drawModes = [FillOnly, StrokeOnly, StrokeThenFill, FillThenStroke]
  fillTypes = [Winding, EvenOdd, InverseWinding, InverseEvenOdd]
  
var
  fillMode = Winding
  drawMode = FillOnly

proc keyProc(key: int32, scancode: int32, action: int32, mods: int32) = 
  if key == GLFWKey.F and action == GLFWPress:
    fillMode = fillTypes[(fillMode.int16 + 1) mod len(fillTypes)]
    echo $fillMode
  if key == GLFWKey.D and action == GLFWPress:
    drawMode = drawModes[(drawMode.int16 + 1) mod len(drawModes)]
    echo $drawMode

proc main() =

  customKeyProc = keyProc

  var path = newSkPath();
  defer: path.dispose()

  let center = newSkPoint(w / 2, h / 2)
  let radius = 0.35 * min(w, h)

  discard path.moveTo(w / 2, h / 2 - radius + 20);

  for i in 1..4:
    var angle = i.float64 * 4.0 * PI / 5.0
    let p = center + (radius * sin(angle), -radius * cos(angle))
    discard path.lineTo(p.x, p.y)
  
  path.close()

  let strokePaint = newSkPaint()
  strokePaint.style = Stroke
  strokePaint.color = Red
  strokePaint.strokeWidth = 25
  strokePaint.antialias = true
  defer: strokePaint.dispose()

  let fillPaint = newSkPaint()
  fillPaint.color = Blue
  fillPaint.style = Fill
  defer: fillPaint.dispose()

  let textPaint = newSkPaint()
  textPaint.color = Black
  textPaint.textSize = 18
  textPaint.textAlign = Left
  textPaint.antialias = true
  defer: textPaint.dispose()




  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(White)

    path.fillType = fillMode

    case drawMode:
      of FillOnly:
        canvas.drawPath(path, fillPaint)
      of StrokeOnly:
        canvas.drawPath(path, strokePaint)
      of StrokeThenFill:
        canvas.drawPath(path, strokePaint)
        canvas.drawPath(path, fillPaint)
      of FillThenStroke:
        canvas.drawPath(path, fillPaint)
        canvas.drawPath(path, strokePaint)
    
    case fillMode:
      of InverseEvenOdd, InverseWinding:
        textPaint.color = White
      else:
        textPaint.color = Black

    canvas.drawText("fillType=" & $fillMode & " (press F to change)", 10, 20, textPaint)
    canvas.drawText("drawMode=" & $drawMode & " (press D to change)", 10, 20 + textPaint.fontSpacing, textPaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
