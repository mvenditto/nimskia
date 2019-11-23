import ../wrapper/sk_types
import ../wrapper/sk_image
import sk_data

type
  SKImage* = ref object 
    native*: ptr sk_image_t

proc dispose*(this: SKImage) = sk_image_unref(this.native)

template width*(this: SKImage): int32 = sk_image_get_width(this.native)

template heigth*(this: SKImage): int32 = sk_image_get_heigth(this.native)

template uniqueID*(this: SKImage): uint32 = sk_image_get_unique_id(this.native)

proc encode*(this: SKImage): SKData = 
  SKData(native: sk_image_encode(this.native))