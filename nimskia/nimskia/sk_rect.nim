import ../wrapper/sk_types

import sk_size
import sk_point

import strformat
# generify + ref
type
  SKRect* = ref object
    native*: sk_rect_t
  
  SKRectI* = ref object
    native*: sk_irect_t

template left*(rect: untyped): auto = rect.native.left
template top*(rect: untyped): auto = rect.native.top
template right*(rect: untyped): auto = rect.native.right
template bottom*(rect: untyped): auto = rect.native.bottom
template width*(rect: untyped): auto = rect.native.right - rect.native.left
template height*(rect: untyped): auto = rect.native.bottom - rect.native.top
template midX*(rect: untyped): auto = rect.native.left  + (rect.width / 2)
template midY*(rect: untyped): auto = rect.native.top  + (rect.height / 2)

proc `left=`*(rect: SKRect, value: float) = rect.native.left = value
proc `right=`*(rect: SKRect, value: float) = rect.native.right = value
proc `top=`*(rect: SKRect, value: float) = rect.native.top = value
proc `bottom=`*(rect: SKRect, value: float) = rect.native.bottom = value

proc `$`*(f: SKRect): string = 
  &"top={f.top} left={f.left} width={f.width} height={f.height})"

proc newRect*(): SKRect =
  var r = new(sk_rect_t)
  SKRect(native: r[])

proc newRect*(rect: SKRect): SKRect = 
  var r = new(sk_rect_t)
  r.left = rect.left
  r.top = rect.top
  r.left = rect.left
  r.right = rect.right
  SKRect(native: r[])
  
proc newRect*(left, top, right, bottom: float): SKRect =
  var rect: sk_rect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRect(native: rect)

proc newRectF*(left, top, right, bottom: int): SKRect =
  var rect: sk_rect_t
  rect.left = left.float
  rect.top = top.float
  rect.right = right.float
  rect.bottom = bottom.float
  SKRect(native: rect)

proc newRect*(topLeft: (float, float), bottomRight: (float, float)): SKRect =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (float, float), width, height: float): SKRect =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + height)

### SKRectI

proc newRect*(left, top, right, bottom: int32): SKRectI =
  var rect: sk_irect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRectI(native: rect)

proc `==`*(a: SKRect, b: SKRect): bool =
  a.left == b.left and a.top == b.top and a.right == b.right and a.bottom == b.bottom

proc newRect*(topLeft: (int32, int32), bottomRight: (int32, int32)): SKRectI =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (int32, int32), width, height: int32): SKRectI =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + height)

proc size*(this: SKRect): SKSize =
  result = newSize(this.width, this.height)

proc `size=`*(this: SKRect, size: SKSize) =
  this.right = size.width + this.left
  this.bottom = size.height + this.top

template location*(this: SKRect): SKPoint =
  newPoint(this.top, this.left)

proc `location=`*(this: SKRect, location: SKPoint) =
  let w = this.width
  let h = this.height
  this.left = location.x
  this.top = location.y
  this.right = location.x + w
  this.bottom = location.y + h

proc offset*(this: SKRect, x, y: float) =
  this.left += x
  this.top += y
  this.right += x
  this.bottom += y

proc inflate*(this: SKRect, x, y: float) =
  this.left -= x
  this.top -= y
  this.right += x
  this.bottom += y

proc inflated*(this: SKRect, x, y: float): SKRect =
  result = newRect(this)
  result.inflate(x, y)

proc standardized*(r: SKRect): SKRect =
  if r.left > r.right:
    if r.top > r.bottom:
      return newRect(r.right, r.bottom, r.left, r.top)
    else:
      return newRect(r.right, r.top, r.left, r.bottom)
  else:
    if r.top > r.bottom:
      return newRect(r.left, r.bottom, r.right, r.top)
    else:
      return newRect(r.left, r.top, r.right, r.bottom)

converter tupleToRectF*(rect: (float,float,float,float)): SKRect =
  let(left,top,right,bottom) = rect
  result = newRect(left, top, right, bottom)