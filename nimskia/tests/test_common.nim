import ../nimskia/[
  sk_bitmap,
  sk_canvas,
  sk_paint,
  sk_colors,
  sk_color,
  sk_rect
]

proc newTestBitmap*(alpha: byte = 255): SKBitmap =
  var bmp = newBitmap(40, 40)
  bmp.erase(Transparent)

  let canvas = newCanvas(bmp)
  defer: canvas.dispose()
  let paint = newPaint()
  defer: paint.dispose()

  var x = bmp.width / 2
  var y = bmp.height / 2

  paint.color = Red.withAlpha(alpha)
  canvas.drawRect(newRect(0, 0, x, y), paint)

  paint.color = Green.withAlpha(alpha)
  canvas.drawRect(newRect(x, 0, x+x, y), paint)

  paint.color = Blue.withAlpha(alpha)
  canvas.drawRect(newRect(0, y, x, y+y), paint)

  paint.color = Yellow.withAlpha(alpha)
  canvas.drawRect(newRect(x, y, x+x, y+y), paint)

  return bmp

proc validateTestBitmap*(bmp: SKBitmap, alpha: byte = 255) =
  assert not isNil bmp
  assert 40 == bmp.width
  assert 40 == bmp.height

  assert Red.withAlpha(alpha) == bmp.getPixel(10, 10)
  assert Green.withAlpha(alpha) == bmp.getPixel(30, 10)
  assert Blue.withAlpha(alpha) == bmp.getPixel(10, 30)
  assert Yellow.withAlpha(alpha) == bmp.getPixel(30, 30)