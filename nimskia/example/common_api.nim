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
  sk_data,
  sk_path,
  sk_bitmap
]

import math

proc star*(r: float, c: float): SkPath =
  result = newSkPath()
  discard result.moveTo(c + r, c)
  for i in 1..7:
    let a = 2.6927937 * i.float
    discard result.lineTo(c + r * cos(a), c + r * sin(a))

proc imageToPng(image: SkImage, path: string) =
  var data = image.encode()
  defer: data.dispose()

  var f = open(path, fmWrite)
  var dataBuff = data.data
  var dataLen = len(data)
  discard f.writeBuffer(dataBuff, dataLen)
  f.close()

proc emitPng*(path: string; surface: SkSurface) =
  var image = surface.snapshot()
  imageToPng(image, path)
  image.dispose()
  

proc emitPng*(path: string, bmp: SkBitmap) = 
  imageToPng(newSkImageFromBitmap(bmp), path)

# assumes a 640x480 surface
proc testDraw*(canvas: SkCanvas) =
    var fill = newSkPaint()
    fill.color = Blue
    canvas.drawPaint(fill)

    fill.color = Cyan
    var rect = newSkRect(100.float, 100, 540, 380)
    canvas.drawRect(rect, fill)

    var stroke = newSkPaint(Red)
    stroke.antialias = true
    stroke.style = Stroke
    stroke.strokeWidth = 5.0
    
    var path = newSkPath()
    discard path.moveTo(50.0, 50.0)
                .lineTo(590.0, 50.0)
                .cubicTo(-490.0, 50.0, 1130.0, 430.0, 50.0, 430.0)
                .lineTo(590.0, 430.0)

    canvas.drawPath(path, stroke)

    fill.color = newSkColorArgb(0x80, 0x00, 0xFF, 0x00)
    var rect2: SkRect = (120.0, 120.0, 520.0, 360.0)
    canvas.drawOval(rect2, fill)

    path.dispose()
    fill.dispose()
    stroke.dispose()