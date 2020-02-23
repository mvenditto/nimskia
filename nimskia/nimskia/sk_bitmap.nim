
import ../wrapper/sk_types
import ../wrapper/sk_bitmap
import ../wrapper/sk_general

import sk_color
import sk_imageinfo
import sk_colorspace
import sk_codec
import sk_enums
import sk_pixmap
import sk_image

import internals/native

type 
  SkBitmap* = ref object of SkObject[sk_bitmap_t]

proc newSkBitmap*(): SkBitmap =
  SkBitmap(native: sk_bitmap_new())

proc dispose*(this: SkBitmap) =
  sk_bitmap_destructor(this.native)

proc erase*(this: SkBitmap, color: SkColor) =
  sk_bitmap_erase(this.native, color)

proc reset*(this: SkBitmap) =
  sk_bitmap_reset(this.native)

proc info*(this: SkBitmap): SkImageInfo =
  var info = cast[ptr sk_imageinfo_t](alloc(sizeof(sk_imageinfo_t)))
  sk_bitmap_get_info(this.native, info)
  SkImageInfo(native: info[])

template isReadyToDraw*(this: SkBitmap): bool =
  sk_bitmap_ready_to_draw(this.native)

proc colorType*(this: SkBitmap): SkColorType =
  this.info.colorType

proc width*(this: SkBitmap): int =
  this.info.width

proc height*(this: SkBitmap): int =
  this.info.height

proc pixels*(this: SkBitmap, length: var int): pointer = 
  sk_bitmap_get_pixels(this.native, length.addr)

proc `pixels=`*(this: SkBitmap, pixels: pointer) =
  sk_bitmap_set_pixels(this.native, pixels)

proc tryAllocatePixels(this: SkBitmap, info: SkImageInfo, rowBytes: int): bool =
  sk_bitmap_try_alloc_pixels(this.native, info.native.addr, rowBytes)

proc newSkBitmap*(info: SkImageInfo): SkBitmap =
  var bitmap = newSkBitmap()
  if not tryAllocatePixels(bitmap, info, info.rowBytes):
    return nil
  result = bitmap

proc newSkBitmap*(width: int, height: int, colorType: SkColorType, alphaType: SkAlphaType): SkBitmap =
  newSkBitmap(newSkImageInfo(width, height, colorType, alphaType, nil))

proc newSkBitmap*(width: int, height: int, isOpaque: bool = false): SkBitmap =
  newSkBitmap(width, height, platformColorType() ,if isOpaque: Opaque else: Premul)
  
proc decodeBitmap*(codec: SkCodec, info: SkImageInfo): SkBitmap =
  var bitmap = newSkBitmap(info)
  var length: int
  var res = codec.pixels(info, bitmap.pixels(length))
  if res != SkCodecResult.Success and res != SkCodecResult.IncompleteInput:
    bitmap.dispose()
    bitmap = nil
  return bitmap

proc decodeBitmap*(codec: SkCodec): SkBitmap =
  var info = codec.info
  if info.alphaType == SkAlphaType.Unpremul:
    info.alphaType = SkAlphaType.Premul
  info.colorspace = nil
  result = decodeBitmap(codec, info)

proc decodeBitmap*(path: string): SkBitmap =
  let(_, codec) = newSkCodec(path)
  if isNil codec:
    return nil
  return decodeBitmap(codec)


proc canCopyTo*(this: SkBitmap, colorType: SkColorType): bool = 
    let srcCT = this.colorType

    if srcCT == UnknownColorType:
      return false
    
    if srcCT == Alpha8 and colorType != Alpha8:
      return false # can't convert from alpha to non-alpha

    let sameConfigs = (srcCT == colorType)

    case colorType:
      of SkColorType.Alpha8,
          SkColorType.Rgb565,
          SkColorType.Rgba8888,
          SkColorType.Bgra8888,
          SkColorType.Rgb888x,
          SkColorType.Rgba1010102,
          SkColorType.Rgb101010x,
          SkColorType.RgbaF16:
        return true
      of Gray8:
        if not sameConfigs:
          return false
        return true
      of Argb4444:
        return sameConfigs or srcCT == platformColorType()
      else:
        return false

proc peekPixels*(this: SkBitmap, pixmap: SkPixmap): bool =
  assert not isNil pixmap
  sk_bitmap_peek_pixels(this.native, pixmap.native)

proc peekPixels*(this: SkBitmap): SkPixmap =
  result = newSkPixmap()
  if not this.peekPixels(result):
    result.dispose()
    return nil

proc swap*(this: SkBitmap, other: SkBitmap) =
  sk_bitmap_swap(this.native, other.native)

template getPixel*(this: SkBitmap, x, y: int): SkColor =
  sk_bitmap_get_pixel_color(this.native, x.cint, y.cint).SkColor

template setPixel*(this: SkBitmap, x: int, y: int, color: SkColor) =
  sk_bitmap_set_pixel_color(this.native, x.cint, y.cint, color.sk_color_t)

proc `[]`*(this: SkBitmap, x, y: int): SkColor = 
  getPixel(this, x, y)

proc `[]=`*(this: SkBitmap, x: int, y: int, color: SkColor) = 
  setPixel(this, x, y, color)

proc copyTo*(this: SkBitmap, destination: SkBitmap, colorType: SkColorType): bool =
  assert not isNil destination
  
  if not this.canCopyTo(colorType):
    return false

  var srcPM = this.peekPixels()
  if isNil srcPM:
    return false

  let dstInfo = srcPM.info.withColorType(colorType)
  if colorType == Rgb565:
    if srcPM.alphaType != Opaque:
      srcPM = srcPM.withAlphaType(Opaque) 
      dstInfo.alphaType = Opaque
  elif colorType == RgbaF16:
    dstInfo.colorspace = newSkSrgbLinearColorSpace()
    if isNil srcPM.colorspace:
      srcPM = srcPM.withColorSpace(newSkSrgbColorSpace())
  
  var tmpDst = newSkBitmap()
  if not tmpDst.tryAllocatePixels(dstInfo, dstInfo.rowBytes):
    return false

  var dstPM = tmpDst.peekPixels()
  if isNil dstPM:
    return false

  if srcPM.colorType == RgbaF16 and dstPM.colorspace == nil:
    dstPM = dstPM.withColorSpace(newSkSrgbColorSpace())

  if colorType != RgbaF16 and srcPM.colorType != RgbaF16 and dstPM.colorspace == srcPM.colorspace:
    dstPM = dstPM.withColorSpace(nil)
    srcPM = srcPM.withColorSpace(nil)
  
  if not srcPM.readPixels(dstPM):
    return false

  destination.swap(tmpDst)

  return true
  
proc copy*(this: SkBitmap, colorType: SkColorType): SkBitmap =
  result = newSkBitmap()
  if not this.copyTo(result, colorType):
    result.dispose()
    return nil

proc bitmapFrom*(img: SkImage): SkBitmap =
  assert not isNil img
  let info = newSkImageInfo(img.width, img.height, platformColorType, img.alphaType, nil)
  result = newSkBitmap(info)
  var lenght: int
  if not img.readPixels(info, result.pixels(lenght)):
    result.dispose()
    result = nil



  


  
  
  





