
import internals/native
import ../wrapper/sk_types

type
  SKPoint* = ref sk_point_t
  SKPointI* = ref sk_ipoint_t

proc newPoint*(x,y: float): SKPoint =
  new(result)
  result.x = x
  result.y = y

converter tupleToSKPoint*(p: (float,float)): SKPoint =
  let(x,y) = p
  newPoint(x,y)

proc newPoint*(x,y: int): SKPointI =
  new(result)
  result.x = x.int32
  result.y = y.int32

proc `+`*(a: SKPoint, b: SKPoint): SKPoint =
  new(result)
  result.x = a.x + b.x
  result.y = a.y + b.y

proc `-`*(a: SKPoint, b: SKPoint): SKPoint =
  new(result)
  result.x = a.x - b.x
  result.y = a.y - b.y

converter tupleToSKPoint*(p: (int,int)): SKPointI =
  let(x,y) = p
  newPoint(x,y)
