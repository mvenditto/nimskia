import ../wrapper/sk_matrix
import ../wrapper/sk_types

import math

type
  SKMatrix* = ref object
    native*: ptr sk_matrix_t

template scaleX*(m: SKMatrix): float = 
  m.native[].scaleX.float

template scaleY*(m: SKMatrix): float = 
  m.native[].scaleY.float

template skewX*(m: SKMatrix): float = 
  m.native[].skewX.float

template skewY*(m: SKMatrix): float = 
  m.native[].skewY.float

template transX*(m: SKMatrix): float = 
  m.native[].transX.float

template transY*(m: SKMatrix): float = 
  m.native[].transY.float

template persp0*(m: SKMatrix): float = 
  m.native[].persp0.float

template persp1*(m: SKMatrix): float = 
  m.native[].persp1.float

template persp2*(m: SKMatrix): float = 
  m.native[].persp2.float

proc `scaleX=`(m: SKMatrix, value: float) =
  m.native[].scaleX = value

proc `scaleY=`(m: SKMatrix, value: float) =
  m.native[].scaleY = value

proc `skewX=`(m: SKMatrix, value: float) =
  m.native[].skewX = value

proc `skewY=`(m: SKMatrix, value: float) =
  m.native[].skewY = value

proc `transX=`(m: SKMatrix, value: float) =
  m.native[].transX = value

proc `transY=`(m: SKMatrix, value: float) =
  m.native[].transY = value

proc `persp0=`(m: SKMatrix, value: float) =
  m.native[].persp0 = value

proc `persp1=`(m: SKMatrix, value: float) =
  m.native[].persp1 = value

proc `persp2=`(m: SKMatrix, value: float) =
  m.native[].persp2 = value

proc setSinCos(matrix: var SKMatrix, sin, cos: float) =
  matrix.scaleX = cos
  matrix.skewX = -sin
  matrix.transX = 0
  matrix.skewY = sin
  matrix.scaleY = cos
  matrix.transY = 0
  matrix.persp0 = 0
  matrix.persp1 = 0
  matrix.persp2 = 1

proc newMatrix*(
    scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2: float): SKMatrix = 
  
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

  SKMatrix(native: matrix.addr)

proc newMatrix*(): SKMatrix = 
  newMatrix(
    0, 0, 0,
    0, 0, 0,
    0, 0, 0
  )

proc getIdentityMatrix*(): SKMatrix =
  newMatrix(
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
  )

proc newRotationMatrix*(radians: float): SKMatrix =
  result = newMatrix()
  setSinCos(
    result, 
    sin(radians), 
    cos(radians)
  )

proc newSkewMatrix*(sx, sy: float): SKMatrix =
  result = newMatrix()
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
  ): SKMatrix = 
  let(scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2) = t
  result = newMatrix(
    scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2)

converter tupleToMatrix*(
  t: (int,int,int,
      int,int,int,
      int,int,int,)
  ): SKMatrix = 
  let(scaleX, skewX, transX,
    skewY, scaleY, transY,
    persp0, persp1, persp2) = t
  result = newMatrix(
    scaleX.float, skewX.float, transX.float,
    skewY.float, scaleY.float, transY.float,
    persp0.float, persp1.float, persp2.float)

