import ../wrapper/sk_types

import sk_size
import sk_point

import strformat
# generify + ref
type
  SkRect* = ref object
    native*: sk_rect_t
  
  SkRectI* = ref object
    native*: sk_irect_t

template left*(rect: untyped): auto = rect.native.left
template top*(rect: untyped): auto = rect.native.top
template right*(rect: untyped): auto = rect.native.right
template bottom*(rect: untyped): auto = rect.native.bottom
template width*(rect: untyped): auto = rect.native.right - rect.native.left
template height*(rect: untyped): auto = rect.native.bottom - rect.native.top
template midX*(rect: untyped): auto = rect.native.left  + (rect.width / 2)
template midY*(rect: untyped): auto = rect.native.top  + (rect.height / 2)

proc `left=`*(rect: SkRect, value: float) = rect.native.left = value
proc `right=`*(rect: SkRect, value: float) = rect.native.right = value
proc `top=`*(rect: SkRect, value: float) = rect.native.top = value
proc `bottom=`*(rect: SkRect, value: float) = rect.native.bottom = value

proc `$`*(f: SkRect): string = 
  &"(top={f.top} left={f.left} width={f.width} height={f.height})"

proc newSkRect*(): SkRect =
  var r = new(sk_rect_t)
  SkRect(native: r[])

proc newSkRect*(rect: SkRect): SkRect = 
  var r = new(sk_rect_t)
  r.left = rect.left
  r.top = rect.top
  r.left = rect.left
  r.right = rect.right
  SkRect(native: r[])
  
proc newSkRect*(left, top, right, bottom: float): SkRect =
  var rect: sk_rect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SkRect(native: rect)

proc newSkRectF*(left, top, right, bottom: int): SkRect =
  var rect: sk_rect_t
  rect.left = left.float
  rect.top = top.float
  rect.right = right.float
  rect.bottom = bottom.float
  SkRect(native: rect)

proc newSkRect*(topLeft: (float, float), bottomRight: (float, float)): SkRect =
  newSkRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newSkRect*(topLeft: (float, float), width, height: float): SkRect =
  newSkRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + height)

proc newSkRectLTWH*(left, top, width, height: float): SkRect =
  newSkRect(left, top, left + width, top + height)
### SkRectI

proc newSkRect*(left, top, right, bottom: int32): SkRectI =
  var rect: sk_irect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SkRectI(native: rect)

proc `==`*(a: SkRect, b: SkRect): bool =
  a.left == b.left and a.top == b.top and a.right == b.right and a.bottom == b.bottom

proc newSkRect*(topLeft: (int32, int32), bottomRight: (int32, int32)): SkRectI =
  newSkRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newSkRect*(topLeft: (int32, int32), width, height: int32): SkRectI =
  newSkRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + height)

proc size*(this: SkRect): SkSize =
  result = newSkSize(this.width, this.height)

proc `size=`*(this: SkRect, size: SkSize) =
  this.right = size.width + this.left
  this.bottom = size.height + this.top

template location*(this: SkRect): SkPoint =
  newSkPoint(this.top, this.left)

proc `location=`*(this: SkRect, location: SkPoint) =
  let w = this.width
  let h = this.height
  this.left = location.x
  this.top = location.y
  this.right = location.x + w
  this.bottom = location.y + h

proc offset*(this: SkRect, x, y: float) =
  this.left += x
  this.top += y
  this.right += x
  this.bottom += y

proc inflate*(this: SkRect, x, y: float) =
  this.left -= x
  this.top -= y
  this.right += x
  this.bottom += y

proc inflated*(this: SkRect, x, y: float): SkRect =
  result = newSkRect(this)
  result.inflate(x, y)

proc standardized*(r: SkRect): SkRect =
  if r.left > r.right:
    if r.top > r.bottom:
      return newSkRect(r.right, r.bottom, r.left, r.top)
    else:
      return newSkRect(r.right, r.top, r.left, r.bottom)
  else:
    if r.top > r.bottom:
      return newSkRect(r.left, r.bottom, r.right, r.top)
    else:
      return newSkRect(r.left, r.top, r.right, r.bottom)

converter tupleToRectF*(rect: (float,float,float,float)): SkRect =
  let(left,top,right,bottom) = rect
  result = newSkRect(left, top, right, bottom)

converter tupleToRectI*(rect: (int,int,int,int)): SkRectI =
  let(left,top,right,bottom) = rect
  result = newSkRect(left.int32, top.int32, right.int32, bottom.int32)