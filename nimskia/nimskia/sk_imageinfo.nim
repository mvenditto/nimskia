import ../wrapper/sk_types

import sk_enums
import sk_colorspace

type
  SKImageInfo* = ref object
      native*: sk_imageinfo_t
      colorspace*: SKColorSpace

template width*(this: SKImageInfo): int32 = sk_imageinfo_get_width(this.native)

template heigth*(this: SKImageInfo): int32 = sk_imageinfo_get_heigth(this.native)

template colorType*(this: SKImageInfo): SKColorType = sk_imageinfo_get_colortype.SKColorType

template alphaType*(this: SKImageInfo): SKAlphaType = sk_imageinfo_get_alphatype.SKAlphaType

proc newImageInfo*(width: int, heigth: int, colorType: SKColorType , alphaType: SKAlphaType, colorspace: SKColorSpace): SKImageInfo =
  var imageInfo: sk_imageinfo_t
  imageInfo.colorspace = colorspace.native
  imageInfo.width = width.cint
  imageInfo.height = heigth.cint
  imageInfo.colorType = colorType.sk_colortype_t
  imageInfo.alphaType = alphaType.sk_alphatype_t
  SKImageInfo(native: imageInfo, colorspace: colorspace)

