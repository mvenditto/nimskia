import ../wrapper/sk_types

type
  SkPoint* = ref sk_point_t
  SkPointI* = ref sk_ipoint_t

let SkEmptyPoint* = SkPoint()

proc newSkPoint*(x,y: float): SkPoint =
  new(result)
  result.x = x
  result.y = y

converter tupleToSkPoint*(p: (float,float)): SkPoint =
  let(x,y) = p
  newSkPoint(x,y)

proc newSkPoint*(x,y: int): SkPointI =
  new(result)
  result.x = x.int32
  result.y = y.int32

proc `+`*(a: SkPoint, b: SkPoint): SkPoint =
  new(result)
  result.x = a.x + b.x
  result.y = a.y + b.y

proc `-`*(a: SkPoint, b: SkPoint): SkPoint =
  new(result)
  result.x = a.x - b.x
  result.y = a.y - b.y

converter tupleToSkPoint*(p: (int,int)): SkPointI =
  let(x,y) = p
  newSkPoint(x,y)
