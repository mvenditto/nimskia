import ../wrapper/sk_pixmap
import ../wrapper/sk_types

import sk_imageinfo
import sk_enums
import sk_colorspace
import sk_color
import internals/native

type
  SkPixmap* = ref object of SkObject[sk_pixmap_t]

proc newSkPixmap*(): SkPixmap =
  SkPixmap(native: sk_pixmap_new())

proc newSkPixmap*(info: SkImageInfo, pixels: pointer, rowBytes: int): SkPixmap =
  SkPixmap(native: sk_pixmap_new_with_params(info.native.addr, pixels, rowBytes))

proc dispose*(this: SkPixmap) = sk_pixmap_destructor(this.native)

template info*(this: SkPixmap): SkImageInfo = 
  var info: sk_imageinfo_t
  sk_pixmap_get_info(this.native, info.addr)
  SkImageInfo(native: info)

template rowBytes*(this: SkPixmap): int = 
  sk_pixmap_get_row_bytes(this.native)

proc pixels*(this: SkPixmap): pointer = sk_pixmap_get_pixels(this.native)

template alphaType*(this: SkPixmap): SkAlphaType =
  this.info.alphaType

template colorType*(this: SkPixmap): SkColorType =
  this.info.colorType

proc colorspace*(this: SkPixmap): SkColorSpace =
  result = this.info.colorspace
  if result == nil or result.native == nil:
    return nil

proc withAlphaType*(this: SkPixmap, alphaType: SkAlphaType): SkPixmap =
  newSkPixmap(this.info.withAlphaType(alphaType), this.pixels, this.rowBytes)

proc withColorSpace*(this: SkPixmap, colorspace: SkColorSpace): SkPixmap =
  newSkPixmap(this.info.withColorSpace(colorspace), this.pixels, this.rowBytes)

proc readPixels*(
  this: SkPixmap, 
  dstInfo: SkImageInfo, 
  dstPixels: pointer, 
  dstRowBytes: int,
  srcX: int, 
  srcY: int, 
  behavior: SkTransferFunctionBehavior): bool =

  sk_pixmap_read_pixels(
    this.native,
    dstInfo.native.addr,
    dstPixels,
    dstRowBytes,
    srcX.cint, srcY.cint,
    behavior.sk_transfer_function_behavior_t
  )

proc readPixels*(this: SkPixmap, dst: SkPixmap): bool =
  readPixels(this, dst.info, dst.pixels, dst.info.rowBytes, 0, 0, Respect)

proc `[]`*(this: SkPixmap, x, y: int): SkColor =
  sk_pixmap_get_pixel_color(this.native, x.cint, y.cint).SkColor

proc getPixel*(this: SkPixmap, x, y: int): SkColor = this[x, y]
