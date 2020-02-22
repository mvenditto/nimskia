import ../wrapper/sk_types
import ../wrapper/sk_colorspace

import internals/native

type
  SkColorSpace* = ref object of SkObject[sk_colorspace_t]

proc dispose*(this: SkColorSpace) = sk_colorspace_unref(this.native)

proc newSkSrgbColorSpace*(): SkColorSpace = SkColorSpace(native: sk_colorspace_new_srgb())

proc newSkSrgbLinearColorSpace*(): SkColorSpace = SkColorSpace(native: sk_colorspace_new_srgb_linear())