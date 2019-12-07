import unittest

import ../nimskia/[
  sk_bitmap,
  sk_enums,
  sk_imageinfo,
  sk_color,
  sk_colors,
  sk_surface,
  sk_canvas
]

import test_common
import ../example/common_api

suite "sk bitmap tests":
  test "bitmap can copy is correct":
    var bmp = newTestBitmap()
    check(bmp.canCopyTo(Alpha8))
    check(bmp.canCopyTo(Rgb565))
    check(bmp.canCopyTo(Argb4444))
    check(bmp.canCopyTo(Bgra8888))
    check(bmp.canCopyTo(Rgba8888))
    check(bmp.canCopyTo(RgbaF16))

    check(not bmp.canCopyTo(UnknownColorType));
    check(not bmp.canCopyTo(Gray8));
    bmp.dispose()
  
  test "does not crash when decoding invalid path":
    let path = "file-does-not-exist.png"
    let bmp = decodeBitmap(path)
    check(isNil bmp)
    if not isNil bmp: bmp.dispose()

  test "copy index8 to platform preserves data":
    let bmp = decodeBitmap("resources/index8.png")
    let platform = bmp.copy(platformColorType)
    check(0x7EA4C639.SKColor == platform.getPixel(182, 348))
    check(platformColorType == bmp.colorType)

  test "overwrite index8 to platform preserves data":
    let bmp = decodeBitmap("resources/index8.png")
    check(bmp.copyTo(bmp, platformColorType))
    check(0x7EA4C639.SKColor == bmp.getPixel(182, 348))
    check(platformColorType == bmp.colorType)

  test "bitmap copy to alpha8 preserves data":
    var bmp = newTestBitmap()

    var alpha8 = bmp.copy(Alpha8)
  
    check(Black == alpha8.getPixel(10, 10))
    check(Black == alpha8.getPixel(30, 10))
    check(Black == alpha8.getPixel(10, 30))
    check(Black == alpha8.getPixel(30, 30))
    check(Alpha8 == alpha8.colorType)

    bmp.dispose()
    bmp = newTestBitmap(127)
    alpha8.dispose()
    alpha8 = bmp.copy(Alpha8)
    
    check(Black.withAlpha(127) == alpha8.getPixel(10, 10))
    check(Black.withAlpha(127) == alpha8.getPixel(30, 10))
    check(Black.withAlpha(127) == alpha8.getPixel(10, 30))
    check(Black.withAlpha(127) == alpha8.getPixel(30, 30))
    check(Alpha8 == alpha8.colorType)

  test "bitmap copy to argb4444 preserves data":
    var bmp = newTestBitmap()
    
    var argb4444= bmp.copy(Argb4444)  
  
    check(0xffff0000.SKColor == argb4444.getPixel(10, 10))
    check(0xff007700.SKColor == argb4444.getPixel(30, 10))
    check(0xff0000ff.SKColor == argb4444.getPixel(10, 30))
    check(0xffffff00.SKColor == argb4444.getPixel(30, 30))
    check(Argb4444 == argb4444.colorType)

    bmp.dispose()
    bmp = newTestBitmap(127)
    argb4444.dispose()
    argb4444 = bmp.copy(Argb4444)
    
    check(0x77ff0000.SKColor == argb4444.getPixel(10, 10))
    check(0x77006d00.SKColor == argb4444.getPixel(30, 10))
    check(0x770000ff.SKColor == argb4444.getPixel(10, 30))
    check(0x77ffff00.SKColor == argb4444.getPixel(30, 30))
    check(Argb4444 == argb4444.colorType)

  test "bitmap copy to argb565 preserves data":
    var bmp = newTestBitmap()
    
    var rgb565= bmp.copy(Rgb565)  
  
    check(0xffff0000.SKColor == rgb565.getPixel(10, 10))
    check(0xff008200.SKColor == rgb565.getPixel(31, 10))
    check(0xff0000ff.SKColor == rgb565.getPixel(10, 30))
    check(0xffffff00.SKColor == rgb565.getPixel(30, 30))
    check(Rgb565 == rgb565.colorType)

    bmp.dispose()
    bmp = newTestBitmap(127)
    rgb565.dispose()
    rgb565 = bmp.copy(Rgb565)
    
    check(0xff7b0000.SKColor == rgb565.getPixel(10, 10))
    check(0xff004100.SKColor == rgb565.getPixel(31, 10))
    check(0xff00007b.SKColor == rgb565.getPixel(10, 30))
    check(0xff7b7d00.SKColor == rgb565.getPixel(30, 30))
    check(Rgb565 == rgb565.colorType)

  test "bitmap copy to rgbaf16 preserves data":
    var bmp = newTestBitmap()
    
    var rgbaF16 = bmp.copy(RgbaF16)
    
    check(0xffff0000.SKColor == rgbaF16.getPixel(10, 10))
    check(0xff003700.SKColor == rgbaF16.getPixel(30, 10))
    check(0xff0000ff.SKColor == rgbaF16.getPixel(10, 30))
    check(0xffffff00.SKColor == rgbaF16.getPixel(30, 30))
    check(RgbaF16 == rgbaF16.colorType)

    bmp.dispose()
    bmp = newTestBitmap(127)
    rgbaF16.dispose()
    rgbaF16 = bmp.copy(RgbaF16)
    
    check(0x7f6d0000.SKColor == rgbaF16.getPixel(10, 10))
    check(0x7f001a00.SKColor == rgbaF16.getPixel(30, 10))
    check(0x7f00006d.SKColor == rgbaF16.getPixel(10, 30))
    check(0x7f6d6d00.SKColor == rgbaF16.getPixel(30, 30))
    check(RgbaF16 == rgbaF16.colorType)  

  test "bitmap copy to invalid is nil":
    var bmp = newTestBitmap()

    validateTestBitmap(bmp)
    validateTestBitmap(bmp.copy(platformColorType))

    check(isNil bmp.copy(UnknownColorType))
    check(isNil bmp.copy(Gray8))

    check(isNil (bmp.copy(Alpha8).copy(platformColorType)))

  test "bitmap decode draws correctly":
    let bmp = decodeBitmap("resources/color-wheel.png")
    defer: bmp.dispose()
    let surface = newSurface(newImageInfo(200, 200))
    defer: surface.dispose()
    let canvas = surface.canvas
    canvas.clear(White)
    canvas.drawBitmap(bmp, 0, 0)
    let img = surface.snapshot()
    let bmp2 = bitmapFrom(img)
    defer: bmp2.dispose()
    check((2, 255, 42).SKColor == bmp2.getPixel(20, 20))
    check((1, 83, 255).SKColor == bmp2.getPixel(108, 20))
    check((255, 166, 1).SKColor == bmp2.getPixel(20, 108))
    check((255, 1, 214).SKColor == bmp2.getPixel(108, 108))
  
  test "subscript operator works correctly":
    let bmp = newTestBitmap()
    check(Red == bmp[10,10])
    bmp[10,10] = Violet
    check(Violet == bmp[10,10])


    

  
  
