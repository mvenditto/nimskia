import ../nimskia/[
  sk_canvas, 
  sk_paint,
  sk_color,
  sk_colors,
  sk_enums,
  sk_rect,
  sk_path,
  sk_surface,
  sk_image,
  sk_data
]

proc emitPng*(path: string; surface: SKSurface) =
  var image = surface.snapshot()
  defer: image.dispose()
  
  var data = image.encode()
  defer: data.dispose()

  var f = open(path, fmWrite)
  var dataBuff = data.data
  var dataLen = len(data)
  discard f.writeBuffer(dataBuff, dataLen)
  f.close()

# assumes a 640x480 surface
proc testDraw*(canvas: SKCanvas) =
    var fill = newPaint()
    fill.color = Blue
    canvas.drawPaint(fill)

    fill.color = Cyan
    var rect = newRect(100.float, 100, 540, 380)
    canvas.drawRect(rect, fill)

    var stroke = newPaint(Red)
    stroke.antialias = true
    stroke.style = Stroke
    stroke.strokeWidth = 5.0
    
    var path = newPath()
    discard path.moveTo(50.0, 50.0)
                .lineTo(590.0, 50.0)
                .cubicTo(-490.0, 50.0, 1130.0, 430.0, 50.0, 430.0)
                .lineTo(590.0, 430.0)

    canvas.drawPath(path, stroke)

    fill.color = newColorArgb(0x80, 0x00, 0xFF, 0x00)
    var rect2: SKRect = (120.0, 120.0, 520.0, 360.0)
    canvas.drawOval(rect2, fill)

    path.dispose()
    fill.dispose()
    stroke.dispose()