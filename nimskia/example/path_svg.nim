import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_paint,
  sk_enums,
  sk_path
]
import sample_base

const
  w = 640
  h = 480
  title = "sample: path svg"

const svgString = """
M 160 140 L 150 50 220 103               
M 320 140 L 330 50 260 103             
M 215 230 L 40 200                       
M 215 240 L 40 240 
M 215 250 L 40 280 
M 265 230 L 440 200                      
M 265 240 L 440 240 
M 265 250 L 440 280 
M 240 100                                
A 100 100 0 0 1 240 300 
A 100 100 0 0 1 240 100 Z 
M 180 170                                
A 40 40 0 0 1 220 170 
A 40 40 0 0 1 180 170 Z 
M 300 170                                
A 40 40 0 0 1 260 170 
A 40 40 0 0 1 300 170 Z
"""

proc main() =

  var path = parseSvgPathData(svgString)
  let strokePaint = newPaint()
  strokePaint.style = Stroke
  strokePaint.color = RosyBrown
  strokePaint.strokeWidth = 8
  strokePaint.antialias = true
  defer: strokePaint.dispose()

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(White)
    canvas.autoRestore:
      canvas.translate(75,50)
      canvas.drawPath(path, strokePaint)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
