
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

type 
  SKBitmap* = ref object
    native*: ptr sk_bitmap_t

proc newBitmap*(): SKBitmap =
  SKBitmap(native: sk_bitmap_new())

proc dispose*(this: SKBitmap) =
  sk_bitmap_destructor(this.native)

proc erase*(this: SKBitmap, color: SKColor) =
  sk_bitmap_erase(this.native, color)

proc reset*(this: SKBitmap) =
  sk_bitmap_reset(this.native)

proc info*(this: SKBitmap): SKImageInfo =
  var info = cast[ptr sk_imageinfo_t](alloc(sizeof(sk_imageinfo_t)))
  sk_bitmap_get_info(this.native, info)
  SKImageInfo(native: info[])

template isReadyToDraw*(this: SKBitmap): bool =
  sk_bitmap_ready_to_draw(this.native)

proc colorType*(this: SKBitmap): SKColorType =
  this.info.colorType

proc width*(this: SKBitmap): int =
  this.info.width

proc height*(this: SKBitmap): int =
  this.info.height

proc pixels*(this: SKBitmap, length: var int): pointer = 
  sk_bitmap_get_pixels(this.native, length.addr)

proc `pixels=`*(this: SKBitmap, pixels: pointer) =
  sk_bitmap_set_pixels(this.native, pixels)

proc tryAllocatePixels(this: SKBitmap, info: SKImageInfo, rowBytes: int): bool =
  sk_bitmap_try_alloc_pixels(this.native, info.native.addr, rowBytes)

proc newBitmap*(info: SKImageInfo): SKBitmap =
  var bitmap = newBitmap()
  if not tryAllocatePixels(bitmap, info, info.rowBytes):
    return nil
  result = bitmap

proc newBitmap*(width: int, height: int, colorType: SKColorType, alphaType: SKAlphaType): SKBitmap =
  newBitmap(newImageInfo(width, height, colorType, alphaType, nil))

proc newBitmap*(width: int, height: int, isOpaque: bool = false): SKBitmap =
  newBitmap(width, height, platformColorType() ,if isOpaque: Opaque else: Premul)
  
proc decodeBitmap*(codec: SKCodec, info: SKImageInfo): SKBitmap =
  var bitmap = newBitmap(info)
  var length: int
  var res = codec.pixels(info, bitmap.pixels(length))
  if res != SKCodecResult.Success and res != SKCodecResult.IncompleteInput:
    bitmap.dispose()
    bitmap = nil
  return bitmap

proc decodeBitmap*(codec: SKCodec): SKBitmap =
  var info = codec.info
  if info.alphaType == SKAlphaType.Unpremul:
    info.alphaType = SKAlphaType.Premul
  info.colorspace = nil
  result = decodeBitmap(codec, info)

proc decodeBitmap*(path: string): SKBitmap =
  let(_, codec) = newCodec(path)
  if isNil codec:
    return nil
  return decodeBitmap(codec)


proc canCopyTo*(this: SKBitmap, colorType: SKColorType): bool = 
    let srcCT = this.colorType

    if srcCT == UnknownColorType:
      return false
    
    if srcCT == Alpha8 and colorType != Alpha8:
      return false # can't convert from alpha to non-alpha

    let sameConfigs = (srcCT == colorType)

    case colorType:
      of SKColorType.Alpha8,
          SKColorType.Rgb565,
          SKColorType.Rgba8888,
          SKColorType.Bgra8888,
          SKColorType.Rgb888x,
          SKColorType.Rgba1010102,
          SKColorType.Rgb101010x,
          SKColorType.RgbaF16:
        return true
      of Gray8:
        if not sameConfigs:
          return false
        return true
      of Argb4444:
        return sameConfigs or srcCT == platformColorType()
      else:
        return false

proc peekPixels*(this: SKBitmap, pixmap: SKPixmap): bool =
  assert not isNil pixmap
  sk_bitmap_peek_pixels(this.native, pixmap.native)

proc peekPixels*(this: SKBitmap): SKPixmap =
  result = newPixmap()
  if not this.peekPixels(result):
    result.dispose()
    return nil

proc swap*(this: SKBitmap, other: SKBitmap) =
  sk_bitmap_swap(this.native, other.native)

template getPixel*(this: SKBitmap, x, y: int): SKColor =
  sk_bitmap_get_pixel_color(this.native, x.cint, y.cint).SKColor

proc copyTo*(this: SKBitmap, destination: SKBitmap, colorType: SKColorType): bool =
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
    dstInfo.colorspace = newSrgbLinearColorSpace()
    if isNil srcPM.colorspace:
      srcPM = srcPM.withColorSpace(newSrgbColorSpace())
  
  var tmpDst = newBitmap()
  if not tmpDst.tryAllocatePixels(dstInfo, dstInfo.rowBytes):
    return false

  var dstPM = tmpDst.peekPixels()
  if isNil dstPM:
    return false

  if srcPM.colorType == RgbaF16 and dstPM.colorspace == nil:
    dstPM = dstPM.withColorSpace(newSrgbColorSpace())

  if colorType != RgbaF16 and srcPM.colorType != RgbaF16 and dstPM.colorspace == srcPM.colorspace:
    dstPM = dstPM.withColorSpace(nil)
    srcPM = srcPM.withColorSpace(nil)
  
  if not srcPM.readPixels(dstPM):
    return false

  destination.swap(tmpDst)

  return true
  
proc copy*(this: SKBitmap, colorType: SKColorType): SKBitmap =
  result = newBitmap()
  if not this.copyTo(result, colorType):
    result.dispose()
    return nil

proc bitmapFrom*(img: SKImage): SKBitmap =
  assert not isNil img
  let info = newImageInfo(img.width, img.height, platformColorType, img.alphaType, nil)
  result = newBitmap(info)
  var lenght: int
  if not img.readPixels(info, result.pixels(lenght)):
    result.dispose()
    result = nil



  


  
  
  





