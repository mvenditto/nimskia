import ../wrapper/sk_pixmap
import ../wrapper/sk_types

import sk_imageinfo
import sk_enums
import sk_colorspace
import internals/native

type
  SKPixmap* = ref object of SKObject[sk_pixmap_t]

proc newPixmap*(): SKPixmap =
  SKPixmap(native: sk_pixmap_new())

proc newPixmap*(info: SKImageInfo, pixels: pointer, rowBytes: int): SKPixmap =
  SKPixmap(native: sk_pixmap_new_with_params(info.native.addr, pixels, rowBytes))

proc dispose*(this: SKPixmap) = sk_pixmap_destructor(this.native)

template info*(this: SKPixmap): SKImageInfo = 
  var info: sk_imageinfo_t
  sk_pixmap_get_info(this.native, info.addr)
  SKImageInfo(native: info)

template rowBytes*(this: SKPixmap): int = 
  sk_pixmap_get_row_bytes(this.native)

proc pixels*(this: SKPixmap): pointer = sk_pixmap_get_pixels(this.native)

template alphaType*(this: SKPixmap): SKAlphaType =
  this.info.alphaType

template colorType*(this: SKPixmap): SKColorType =
  this.info.colorType

proc colorspace*(this: SKPixmap): SKColorSpace =
  result = this.info.colorspace
  if result == nil or result.native == nil:
    return nil

proc withAlphaType*(this: SKPixmap, alphaType: SKAlphaType): SKPixmap =
  newPixmap(this.info.withAlphaType(alphaType), this.pixels, this.rowBytes)

proc withColorSpace*(this: SKPixmap, colorspace: SKColorSpace): SKPixmap =
  newPixmap(this.info.withColorSpace(colorspace), this.pixels, this.rowBytes)

proc readPixels*(
  this: SKPixmap, 
  dstInfo: SKImageInfo, 
  dstPixels: pointer, 
  dstRowBytes: int,
  srcX: int, 
  srcY: int, 
  behavior: SKTransferFunctionBehavior): bool =

  sk_pixmap_read_pixels(
    this.native,
    dstInfo.native.addr,
    dstPixels,
    dstRowBytes,
    srcX.cint, srcY.cint,
    behavior.sk_transfer_function_behavior_t
  )

proc readPixels*(this: SKPixmap, dst: SKPixmap): bool =
  readPixels(this, dst.info, dst.pixels, dst.info.rowBytes, 0, 0, Respect)