import ../nimskia/[
  sk_canvas,
  sk_canvas_ext,
  sk_bitmap,
  sk_imageinfo,
  sk_typeface,
  sk_shaper,
  sk_enums,
  sk_colorspace,
  sk_surface,
  sk_paint,
  sk_colors,
  sk_point,
  sk_converters
]

import common_api

const
  lorem = "Lorem ipsum dolor sit amet == =>"

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

proc testLigatures() =

  let
    cs = newSkSrgbColorSpace()
    info = newSkImageInfo(512, 512, Rgba_8888, Unpremul, cs)
    surface = newSkSurface(info)
    tf = newSkTypeface("Fira Code")
    shaper = newSkShaper(tf)
  
  var paint = newSkPaint()

  paint.antialias = true
  paint.textSize = 24
  paint.typeface = tf
  paint.color = Black

  surface.canvas.clear(White)
  surface.canvas.drawShapedText(
    shaper,
    lorem,
    32,
    200,
    paint
  )
  surface.canvas.flush()

  paint.subpixelText = true

  surface.canvas.drawShapedText(
    shaper,
    lorem,
    32,
    300,
    paint
  )

  emitPng("snapshots/shapedText.png", surface)

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
testLigatures()