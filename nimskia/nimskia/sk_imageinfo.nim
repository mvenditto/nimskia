import ../wrapper/sk_types

import sk_enums
import sk_colorspace

type
  SKImageInfo* = ref object
      native*: sk_imageinfo_t

template width*(this: SKImageInfo): int32 = this.native.width

template heigth*(this: SKImageInfo): int32 = this.native.height

template colorType*(this: SKImageInfo): SKColorType = this.native.colorType.SKColorType

template alphaType*(this: SKImageInfo): SKAlphaType = this.native.alphaType.SKAlphaType

proc `alphaType=`*(this: SKImageInfo, alphaType: SKAlphaType) =

  this.native.alphaType = alphaType.sk_alphatype_t

proc `colorType=`*(this: SKImageInfo, colorType: SKColorType) =
  this.native.colorType = colorType.sk_colortype_t

proc `colorspace=`*(this: SKImageInfo, colorSpace: SKColorSpace) =
  this.native.colorspace = colorSpace.native

proc bytesPerPixel*(this: SKImageInfo): int =
  let colorType = this.colorType
  case colorType:
    of UnknownColorType:
      return 0
    of Alpha8, Gray8:
      return 1
    of Rgb565, Argb4444:
      return 2
    of SKColorType.Bgra8888,
      SKColorType.Rgba8888,
      SKColorType.Rgb888x,
      SKColorType.Rgba1010102,
      SKColorType.Rgb101010x:
      return 4;
    of SKColorType.RgbaF16:
      return 8;
  assert(false, "out of range: " & $colorType)

proc rowBytes*(this: SKImageInfo): int =
  this.bytesPerPixel() * this.width

proc newImageInfo*(width: int, heigth: int, colorType: SKColorType , alphaType: SKAlphaType, colorspace: SKColorSpace): SKImageInfo =
  var imageInfo: sk_imageinfo_t
  imageInfo.colorspace = if not isNil colorspace: colorspace.native else: nil
  imageInfo.width = width.cint
  imageInfo.height = heigth.cint
  imageInfo.colorType = colorType.sk_colortype_t
  imageInfo.alphaType = alphaType.sk_alphatype_t
  SKImageInfo(native: imageInfo)

proc withColorType*(this: SKImageInfo, colorType: SKColorType): SKImageInfo =
  result = deepCopy this
  result.colorType = colorType