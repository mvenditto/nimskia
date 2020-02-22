import ../wrapper/sk_types

type
  SkSize* = ref object 
    native*: sk_size_t

  SkSizeI* = ref object
    native*: sk_isize_t 

template width*(this: SkSize): float = this.native.w.float
template height*(this: SkSize): float = this.native.h.float

template width*(this: SkSizeI): int32 = this.native.w
template height*(this: SkSizeI): int32 = this.native.h

proc newSkSize*(width, height: float): SkSize =
  SkSize(native: sk_size_t(w: width, h: height))

proc newSkSizeF*(width, height: int32): SkSize =
  SkSize(native: sk_size_t(w: width.float, h: height.float))

proc newSkSize*(width, height: int32): SkSizeI =
  SkSizeI(native: sk_isize_t(w: width, h: height))

