import ../nimskia/[
  sk_bitmap,
  sk_canvas,
  sk_paint,
  sk_colors,
  sk_color,
  sk_rect
]

import gl_contexts/[
  gl_context,
  glfw_context
]

proc newTestBitmap*(alpha: byte = 255): SkBitmap =
  var bmp = newSkBitmap(40, 40)
  bmp.erase(Transparent)

  let canvas = newSkCanvas(bmp)
  defer: canvas.dispose()
  let paint = newSkPaint()
  defer: paint.dispose()

  var x = bmp.width / 2
  var y = bmp.height / 2

  paint.color = Red.withAlpha(alpha)
  canvas.drawRect(newSkRect(0, 0, x, y), paint)

  paint.color = Green.withAlpha(alpha)
  canvas.drawRect(newSkRect(x, 0, x+x, y), paint)

  paint.color = Blue.withAlpha(alpha)
  canvas.drawRect(newSkRect(0, y, x, y+y), paint)

  paint.color = Yellow.withAlpha(alpha)
  canvas.drawRect(newSkRect(x, y, x+x, y+y), paint)

  return bmp

proc validateTestBitmap*(bmp: SkBitmap, alpha: byte = 255) =
  assert not isNil bmp
  assert 40 == bmp.width
  assert 40 == bmp.height

  assert Red.withAlpha(alpha) == bmp.getPixel(10, 10)
  assert Green.withAlpha(alpha) == bmp.getPixel(30, 10)
  assert Blue.withAlpha(alpha) == bmp.getPixel(10, 30)
  assert Yellow.withAlpha(alpha) == bmp.getPixel(30, 30)

proc createGlContext*(): GlContext =
  result = newGlfwContext()