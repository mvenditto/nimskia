import ../wrapper/sk_types

type
  SKColor* = uint32

template r*(color: SKColor): byte = sk_color_get_r(color)
template g*(color: SKColor): byte = sk_color_get_g(color)
template b*(color: SKColor): byte = sk_color_get_b(color)
template a*(color: SKColor): byte = sk_color_get_a(color)

template newColorARGB*(a, r, g, b: byte): SKColor = 
  sk_color_set_argb(a, r, g, b).SKColor
