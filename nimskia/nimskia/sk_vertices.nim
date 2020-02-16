import ../wrapper/[
  sk_types,
  sk_vertices
]
import sk_point, sk_color, sk_enums
import internals/native

import sequtils
import sugar

type
  SKVertices* = ref object of SKObject[sk_vertices_t]

proc refNative*(this: SKVertices) = 
  sk_vertices_ref(this.native)

proc unrefNative*(this: SKVertices) = 
  sk_vertices_ref(this.native)

proc copy*(
  vmode: SKVertexMode, 
  positions: seq[SKPoint],
  texs: seq[SKPoint],
  colors: seq[SKColor],
  indices: seq[uint16]): SKVertices =

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
  
  SKVertices(
    native: sk_vertices_make_copy(
        vmode.sk_vertices_vertex_mode_t,
        vertextCount.cint,
        p[0].unsafeAddr,
        t[0].unsafeAddr,
        c[0].unsafeAddr,
        indexCount.cint,
        indices[0].unsafeAddr
      )
  )

proc copy*(
  vmode: SKVertexMode, 
  positions: seq[SKPoint],
  texs: seq[SKPoint],
  colors: seq[SKColor]): SKVertices =
  copy(vmode, positions, texs, colors, newSeq[uint16]())

proc copy*(
  vmode: SKVertexMode, 
  positions: seq[SKPoint],
  colors: seq[SKColor]): SKVertices =
  copy(vmode, positions, newSeq[SKPoint](), colors, newSeq[uint16]())
