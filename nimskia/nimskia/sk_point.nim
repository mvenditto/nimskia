
import internals/native
import ../wrapper/sk_types

type
  SKPoint* = ref sk_point_t

proc newPoint*(x,y: float): SKPoint =
  new(result)
  result.x = x
  result.y = y

converter tupleToSKPoint*(p: (float,float)): SKPoint =
  let(x,y) = p
  newPoint(x,y)

converter tupleToSKPoint*(p: (int, int)): SKPoint =
  let(x,y) = p
  newPoint(x.float,y.float)