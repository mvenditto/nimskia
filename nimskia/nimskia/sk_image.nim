import ../wrapper/sk_types
import ../wrapper/sk_image

import sk_data
import sk_enums
import sk_imageinfo

import internals/native

type
  SkImage* = ref object of SkObject[sk_image_t]

proc dispose*(this: SkImage) = sk_image_unref(this.native)

template width*(this: SkImage): int = sk_image_get_width(this.native).int

template height*(this: SkImage): int = sk_image_get_height(this.native).int

template alphaType*(this: SkImage): SkAlphaType = sk_image_get_alpha_type(this.native).SkAlphaType

template uniqueID*(this: SkImage): uint32 = sk_image_get_unique_id(this.native)

proc encode*(this: SkImage): SkData = 
  SkData(native: sk_image_encode(this.native))

proc readPixels*(
  this: SkImage, 
  dstInfo: SkImageInfo, 
  dstPixels: pointer, 
  dstRowBytes: int,
  srcX: int, 
  srcY: int, 
  caching: SkImageCachingHint = Allow): bool =

  sk_image_read_pixels(
    this.native,
    dstInfo.native.addr,
    dstPixels,
    dstRowBytes,
    srcX.cint, srcY.cint,
    caching.sk_image_caching_hint_t
  )

proc readPixels*(
  this: SkImage, 
  dstInfo: SkImageInfo, 
  dstPixels: pointer): bool =

  readPixels(
    this,
    dstInfo,
    dstPixels,
    dstInfo.rowBytes,
    0, 0, Allow
  )