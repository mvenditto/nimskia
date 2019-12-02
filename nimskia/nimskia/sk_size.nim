import ../wrapper/sk_types

type
  SKSize* = ref object 
    native*: sk_size_t

  SKSizeI* = ref object
    native*: sk_isize_t 

template width*(this: SKSize): float = this.native.w.float
template height*(this: SKSize): float = this.native.h.float

template width*(this: SKSizeI): int32 = this.native.w
template height*(this: SKSizeI): int32 = this.native.h

proc newSize*(width, height: float): SKSize =
  SKSize(native: sk_size_t(w: width, h: height))

proc newSizeF*(width, height: int32): SKSize =
  SKSize(native: sk_size_t(w: width.float, h: height.float))

proc newSize*(width, height: int32): SKSizeI =
  SKSizeI(native: sk_isize_t(w: width, h: height))

