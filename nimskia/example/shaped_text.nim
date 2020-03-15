import ../nimskia/[
  sk_canvas,
  sk_canvas_ext,
  sk_bitmap,
  sk_imageinfo,
  sk_typeface,
  sk_shaper,
  sk_paint,
  sk_colors,
  sk_point,
  sk_converters
]

import common_api

proc test() =
  var 
    tf = loadSkTypeFace("resources/fonts/content-font.ttf")
    shaper = newSkShaper(tf)
    paint = newSkPaint()

  paint.antialias = true
  paint.textSize = 64
  paint.typeface = tf

  let(a,b,c) = shaper.shape("متن", paint)
  
  echo (a, b, c)

proc test2() =
  let 
    bmp = newSkBitmap(512, 512) 
    canvas = newSkCanvas(bmp)
    tf = loadSkTypeFace("resources/fonts/content-font.ttf")
    shaper = newSkShaper(tf)
    paint = newSkPaint()
    paint2 = newSkPaint()

  paint.antialias = true
  paint.textSize = 64
  paint.typeface = tf
  paint.color = Blue

  paint2.antialias = true
  paint2.textSize = 64
  paint2.color = Red

  canvas.clear(White)

  canvas.drawText("متن",
    200,
    100,
    paint2)

  canvas.drawShapedText(
    shaper,
    "متن",
    200,
    200,
    paint
  )

  canvas.flush()

  emitPng("snapshots/shapedText.png", bmp)


# test()
test2()