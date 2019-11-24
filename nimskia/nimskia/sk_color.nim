import ../wrapper/sk_types

type
  SKColor* = uint32

template r*(color: SKColor): byte = sk_color_get_r(color)
template g*(color: SKColor): byte = sk_color_get_g(color)
template b*(color: SKColor): byte = sk_color_get_b(color)
template a*(color: SKColor): byte = sk_color_get_a(color)

template newColorARGB*(a, r, g, b: int): SKColor = 
  ((a shl 24) or (r shl 16) or (g shl 8) or b).uint32

converter tupleToColorARGB*(t: (int,int,int,int)): SKColor =
  let(a,r,g,b) = t
  newColorARGB(a,r,g,b)
