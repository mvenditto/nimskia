import ../wrapper/[
  sk_types,
  sk_vertices
]
import sk_point, sk_color, sk_enums
import internals/native

import sequtils
import sugar

const
  NoColors = newSeq[SkColor]()
  NoIndices = newSeq[uint16]()
let 
  NoTextures = newSeq[SkPoint]()

type
  SkVertices* = ref object of SkObject[sk_vertices_t]

proc refNative*(this: SkVertices) = 
  sk_vertices_ref(this.native)

proc unrefNative*(this: SkVertices) = 
  sk_vertices_ref(this.native)

proc copy*(
  vmode: SkVertexMode, 
  positions: openArray[SkPoint],
  texs: openArray[SkPoint],
  colors: openArray[SkColor],
  indices: openArray[uint16]): SkVertices =

  if len(positions) <= 0:
    raise newException(ValueError, "num vertices must be > 0")
  if len(texs) != 0 and (len(texs) != len(positions)):
    raise newException(ValueError, "textures number must match vertices number")
  if len(colors) != 0 and (len(colors) != len(positions)):
    raise newException(ValueError, "colors number must match vertices number")

  let vertextCount = len(positions)
  let indexCount = len(indices)

  let p: seq[sk_point_t] = positions.map(x => cast[sk_point_t](x[]))
  let t: seq[sk_point_t] = texs.map(x => cast[sk_point_t](x[]))
  let c: seq[sk_color_t] = colors.map(x => x.sk_color_t)
  
  SkVertices(
    native: sk_vertices_make_copy(
        vmode.sk_vertices_vertex_mode_t,
        vertextCount.cint,
        if len(p) == 0: nil else: p[0].unsafeAddr,
        if len(t) == 0: nil else: t[0].unsafeAddr,
        if len(c) == 0: nil else: c[0].unsafeAddr,
        indexCount.cint,
        if len(indices) == 0: nil else: indices[0].unsafeAddr
      )
  )

template copy*(
  vmode: SkVertexMode, 
  positions: openArray[SkPoint],
  texs: openArray[SkPoint],
  colors: openArray[SkColor]
): SkVertices =
  copy(vmode, positions, texs, colors, NoIndices)

template copy*(
  vmode: SkVertexMode, 
  positions: openArray[SkPoint],
  colors: openArray[SkColor]
): SkVertices =
  copy(vmode, positions, newSeq[SkPoint](), colors, NoIndices)

template copy*(
  vmode: SkVertexMode, 
  positions: openArray[SkPoint],
  texs: openArray[SkPoint]
): SkVertices =
  copy(vmode, positions, texs, NoColors, NoIndices)

template copy*(
  vmode: SkVertexMode, 
  positions: openArray[SkPoint],
  colors: openArray[SkColor],
  indices: openArray[uint16]
): SkVertices =
  copy(vmode, positions, NoTextures, colors, indices)