import ../wrapper/sk_types
import ../wrapper/sk_general

import sk_enums
import sk_colorspace
import internals/native

type
  SkImageInfo* = ref object
      native*: sk_imageinfo_t

template width*(this: SkImageInfo): int32 = this.native.width

template height*(this: SkImageInfo): int32 = this.native.height

template colorType*(this: SkImageInfo): SkColorType = this.native.colorType.SkColorType

template alphaType*(this: SkImageInfo): SkAlphaType = this.native.alphaType.SkAlphaType

template colorspace*(this: SkImageInfo): SkColorSpace = 
  SkColorSpace(native: this.native.colorspace)

template platformColorType*: SkColorType =
  sk_colortype_get_default_8888().SkColorType

proc `alphaType=`*(this: SkImageInfo, alphaType: SkAlphaType) =

  this.native.alphaType = alphaType.sk_alphatype_t

proc `colorType=`*(this: SkImageInfo, colorType: SkColorType) =
  this.native.colorType = colorType.sk_colortype_t

proc `colorspace=`*(this: SkImageInfo, colorSpace: SkColorSpace) =
  this.native.colorspace = colorSpace.nativeSafe

proc bytesPerPixel*(this: SkImageInfo): int =
  let colorType = this.colorType
  case colorType:
    of UnknownColorType:
      return 0
    of Alpha8, Gray8:
      return 1
    of Rgb565, Argb4444:
      return 2
    of SkColorType.Bgra8888,
      SkColorType.Rgba8888,
      SkColorType.Rgb888x,
      SkColorType.Rgba1010102,
      SkColorType.Rgb101010x:
      return 4;
    of SkColorType.RgbaF16:
      return 8;
  assert(false, "out of range: " & $colorType)

proc rowBytes*(this: SkImageInfo): int =
  this.bytesPerPixel() * this.width

proc newSkImageInfo*(width: int, height: int, colorType: SkColorType , alphaType: SkAlphaType, colorspace: SkColorSpace): SkImageInfo =
  var imageInfo: sk_imageinfo_t
  imageInfo.colorspace = if not isNil colorspace: colorspace.native else: nil
  imageInfo.width = width.cint
  imageInfo.height = height.cint
  imageInfo.colorType = colorType.sk_colortype_t
  imageInfo.alphaType = alphaType.sk_alphatype_t
  SkImageInfo(native: imageInfo)

proc newSkImageInfo*(width: int, height: int): SkImageInfo =
  newSkImageInfo(width, height, platformColorType, Premul, nil)

proc withColorType*(this: SkImageInfo, colorType: SkColorType): SkImageInfo =
  result = deepCopy this
  result.colorType = colorType

proc withAlphaType*(this: SkImageInfo, alphaType: SkAlphaType): SkImageInfo =
  result = deepCopy this
  result.alphaType = alphaType

proc withColorSpace*(this: SkImageInfo, colorspace: SkColorSpace): SkImageInfo =
  result = deepCopy this
  result.colorspace = colorspace