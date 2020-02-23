import ../wrapper/sk_matrix
import ../wrapper/sk_types

import internals/native

import math

type
  SkMatrix* = ref object of SkObject[sk_matrix_t]

template scaleX*(m: SkMatrix): float = 
  m.native[].scaleX.float

template scaleY*(m: SkMatrix): float = 
  m.native[].scaleY.float

template skewX*(m: SkMatrix): float = 
  m.native[].skewX.float

template skewY*(m: SkMatrix): float = 
  m.native[].skewY.float

template transX*(m: SkMatrix): float = 
  m.native[].transX.float

template transY*(m: SkMatrix): float = 
  m.native[].transY.float

template persp0*(m: SkMatrix): float = 
  m.native[].persp0.float

template persp1*(m: SkMatrix): float = 
  m.native[].persp1.float

template persp2*(m: SkMatrix): float = 
  m.native[].persp2.float

proc `scaleX=`(m: SkMatrix, value: float) =
  m.native[].scaleX = value

proc `scaleY=`(m: SkMatrix, value: float) =
  m.native[].scaleY = value

proc `skewX=`(m: SkMatrix, value: float) =
  m.native[].skewX = value

proc `skewY=`(m: SkMatrix, value: float) =
  m.native[].skewY = value

proc `transX=`(m: SkMatrix, value: float) =
  m.native[].transX = value

proc `transY=`(m: SkMatrix, value: float) =
  m.native[].transY = value

proc `persp0=`(m: SkMatrix, value: float) =
  m.native[].persp0 = value

proc `persp1=`(m: SkMatrix, value: float) =
  m.native[].persp1 = value

proc `persp2=`(m: SkMatrix, value: float) =
  m.native[].persp2 = value

proc setSinCos(matrix: var SkMatrix, sin, cos: float) =
  matrix.scaleX = cos
  matrix.skewX = -sin
  matrix.transX = 0
  matrix.skewY = sin
  matrix.scaleY = cos
  matrix.transY = 0
  matrix.persp0 = 0
  matrix.persp1 = 0
  matrix.persp2 = 1

proc newSkMatrix*(
    scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2: float): SkMatrix = 
  
  var matrix: sk_matrix_t
  # X
  matrix.scaleX = scaleX
  matrix.skewX = skewX
  matrix.transX = transX
  # Y
  matrix.scaleY = scaleY
  matrix.skewY = skewY
  matrix.transY= transY
  # Persp
  matrix.persp0 = persp0
  matrix.persp1 = persp1
  matrix.persp2 = persp2

  SkMatrix(native: matrix.addr)

proc newSkMatrix*(): SkMatrix = 
  newSkMatrix(
    0, 0, 0,
    0, 0, 0,
    0, 0, 0
  )

proc getIdentityMatrix*(): SkMatrix =
  newSkMatrix(
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  )

proc newSkRotationMatrix*(radians: float): SkMatrix =
  result = newSkMatrix()
  setSinCos(
    result, 
    sin(radians), 
    cos(radians)
  )

proc newSkewMatrix*(sx, sy: float): SkMatrix =
  result = newSkMatrix()
  result.scaleX = 1
  result.skewX = sx
  result.transX = 0
  result.skewY = sy
  result.scaleY = 1
  result.transY = 0
  result.persp0 = 0
  result.persp1 = 0
  result.persp2 = 1

converter tupleToMatrix*(
  t: (float,float,float,
      float,float,float,
      float,float,float,)
  ): SkMatrix = 
  let(scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2) = t
  result = newSkMatrix(
    scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2)

converter tupleToMatrix*(
  t: (int,int,int,
      int,int,int,
      int,int,int,)
  ): SkMatrix = 
  let(scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2) = t
  result = newSkMatrix(
    scaleX.float, skewX.float, transX.float,
    skewY.float, scaleY.float, transY.float,
    persp0.float, persp1.float, persp2.float)

