import ../wrapper/sk_matrix
import ../wrapper/sk_types

type
  SKMatrix* = ref object
    native*: ptr sk_matrix_t

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