import ../wrapper/sk_types
import ../wrapper/sk_colorspace

type
  SKColorSpace* = ref object
    native*: ptr sk_colorspace_t

proc dispose*(this: SKColorSpace) = sk_colorspace_unref(this.native)

proc newSrgbColorSpace*(): SKColorSpace = SKColorSpace(native: sk_colorspace_new_srgb())