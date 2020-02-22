import ../wrapper/sk_types
import strutils

type
  SkColor* = uint32

template r*(color: SkColor): byte = sk_color_get_r(color).byte
template g*(color: SkColor): byte = sk_color_get_g(color).byte
template b*(color: SkColor): byte = sk_color_get_b(color).byte
template a*(color: SkColor): byte = sk_color_get_a(color).byte

template newSkColorARGB*(a, r, g, b: int): SkColor = 
  ((a shl 24) or (r shl 16) or (g shl 8) or b).uint32

template withAlpha*(c: SkColor, a: byte): SkColor = 
  newSkColorARGB(a.int, c.r.int, c.g.int, c.b.int)
  
converter tupleToColorARGB*(t: (int,int,int,int)): SkColor =
  let(a,r,g,b) = t
  newSkColorARGB(a,r,g,b)

converter tupleToColorRGB*(t: (int,int,int)): SkColor =
  let(r,g,b) = t
  newSkColorARGB(255,r,g,b)

proc newSkColorARGB*(hex: string): SkColor =
  var tmp = hex.replace("#","")
  tmp = tmp.align(8, 'F')
  fromHex[int32](tmp).SkColor

