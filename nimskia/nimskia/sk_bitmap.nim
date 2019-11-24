
import ../wrapper/sk_types
import ../wrapper/sk_bitmap

import sk_color
import sk_imageinfo
import sk_codec
import sk_enums

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
  
  
  





