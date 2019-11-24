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

import common_api

proc main() =
  var cs = newSrgbColorSpace()
  var info = newImageInfo(640, 480, Rgba_8888, Premul, cs)
  var surface = newSurface(info)
  assert not isNil surface

  testDraw(surface.canvas)

  emitPng("outPNG.png", surface);

main()
