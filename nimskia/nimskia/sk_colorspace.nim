import ../wrapper/sk_types
import ../wrapper/sk_colorspace

import internals/native

type
  SKColorSpace* = ref object of SKObject[sk_colorspace_t]

proc dispose*(this: SKColorSpace) = sk_colorspace_unref(this.native)

proc newSrgbColorSpace*(): SKColorSpace = SKColorSpace(native: sk_colorspace_new_srgb())

proc newSrgbLinearColorSpace*(): SKColorSpace = SKColorSpace(native: sk_colorspace_new_srgb_linear())