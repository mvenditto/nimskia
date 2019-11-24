import ../wrapper/sk_types

import sk_color

type
  SKRect* = ref object
    native*: sk_rect_t
  
  SKRectI* = ref object
    native*: sk_irect_t

template left*(rect: untyped): untyped = rect.left
template top*(rect: untyped): untyped = rect.top
template right*(rect: untyped): untyped = rect.right
template bottom*(rect: untyped): untyped = rect.bottom

proc newRect*(left, top, right, bottom: float): SKRect =
  var rect: sk_rect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRect(native: rect)

proc newRect*(topLeft: (float, float), bottomRight: (float, float)): SKRect =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (float, float), width, heigth: float): SKRect =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + heigth)

### SKRectI

proc newRect*(left, top, right, bottom: int32): SKRectI =
  var rect: sk_irect_t
  rect.left = left
  rect.top = top
  rect.right = right
  rect.bottom = bottom
  SKRectI(native: rect)

proc newRect*(topLeft: (int32, int32), bottomRight: (int32, int32)): SKRectI =
  newRect(topLeft[0], topLeft[1], bottomRight[0], bottomRight[1])

proc newRect*(topLeft: (int32, int32), width, heigth: int32): SKRectI =
  newRect(topLeft[0], topLeft[1], topLeft[0] + width, topLeft[1] + heigth)

converter tupleToRectF*(rect: (float,float,float,float)): SKRect =
  let(left,top,right,bottom) = rect
  result = newRect(left, top, right, bottom)