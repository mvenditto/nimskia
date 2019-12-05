import ../wrapper/sk_types
import ../wrapper/sk_image

import sk_data
import sk_enums
import sk_imageinfo

type
  SKImage* = ref object 
    native*: ptr sk_image_t

proc dispose*(this: SKImage) = sk_image_unref(this.native)

template width*(this: SKImage): int = sk_image_get_width(this.native).int

template height*(this: SKImage): int = sk_image_get_height(this.native).int

template alphaType*(this: SKImage): SKAlphaType = sk_image_get_alpha_type(this.native).SKAlphaType

template uniqueID*(this: SKImage): uint32 = sk_image_get_unique_id(this.native)

proc encode*(this: SKImage): SKData = 
  SKData(native: sk_image_encode(this.native))

proc readPixels*(
  this: SKImage, 
  dstInfo: SKImageInfo, 
  dstPixels: pointer, 
  dstRowBytes: int,
  srcX: int, 
  srcY: int, 
  caching: SKImageCachingHint = Allow): bool =

  sk_image_read_pixels(
    this.native,
    dstInfo.native.addr,
    dstPixels,
    dstRowBytes,
    srcX.cint, srcY.cint,
    caching.sk_image_caching_hint_t
  )

proc readPixels*(
  this: SKImage, 
  dstInfo: SKImageInfo, 
  dstPixels: pointer): bool =

  readPixels(
    this,
    dstInfo,
    dstPixels,
    dstInfo.rowBytes,
    0, 0, Allow
  )