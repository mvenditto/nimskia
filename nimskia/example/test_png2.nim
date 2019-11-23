import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_color, 
  sk_rect, 
  sk_image, 
  sk_data, 
  sk_surface, 
  sk_colorspace, 
  sk_imageinfo, 
  sk_enums,
  sk_colors
]

proc draw(canvas: SKCanvas) =
  let paint = newPaint(color = Blue)
  defer: paint.dispose()
  canvas.drawPaint(paint)

  paint.color = newColorARGB(255, 0, 255, 255) # Cyan
  let rect = newRect(100.float, 100, 540, 380)
  canvas.drawRect(rect, paint)

  paint.color = newColorARGB(0x80, 0x00, 0xFF, 0x00)
  let bounds = newRect(120.0, 120.0, 520.0, 360.0)
  canvas.drawOval(bounds, paint)

proc emitPng(path: string; surface: SKSurface) =
  var image = surface.snapshot()
  defer: image.dispose()
  
  var data = image.encode()
  defer: data.dispose()

  var f = open(path, fmWrite)
  var dataBuff = data.data
  var dataLen = len(data)
  discard f.writeBuffer(dataBuff, dataLen)
  f.close()


proc main() =
  var cs = newSrgbColorSpace()
  var info = newImageInfo(640, 480, Rgba_8888, Premul, cs)
  var surface = newRasterSurface(info)
  assert not isNil surface

  draw(surface.canvas)

  emitPng("out3.png", surface);

main()
