import ../wrapper/sk_path
import ../wrapper/sk_types
import sk_enums
import sk_rect

type 
  SKPath* = ref object
    native*: ptr sk_path_t

proc newPath*(): SKPath =
  SKPath(native: sk_path_new())

proc dispose*(this: SKPath) =
  sk_path_delete(this.native)

proc moveTo*(this: SKPath, x, y: float): SKPath =
  sk_path_move_to(this.native, x, y)
  this

proc lineTo*(this: SKPath, x, y: float): SKPath =
  sk_path_line_to(this.native, x, y)
  this

proc quadTo*(this: SKPath, x0, y0, x1, y1: float): SKPath =
  sk_path_quad_to(this.native, x0, y0, x1, y1)
  this

proc conicTo*(this: SKPath, x0, y0, x1, y1, w: float): SKPath =
  sk_path_conic_to(this.native, x0, y0, x1, y1, w)
  this

proc cubicTo*(this: SKPath, x0, y0, x1, y1, x2, y2: float): SKPath =
  sk_path_cubic_to(this.native, x0, y0, x1, y1, x2, y2)
  this

proc rlineTo*(this: SKPath, x, y: float): SKPath =
  sk_path_rline_to(this.native, x, y)
  this

proc rquadTo*(this: SKPath, x0, y0, x1, y1: float): SKPath =
  sk_path_rquad_to(this.native, x0, y0, x1, y1)
  this

proc rconicTo*(this: SKPath, x0, y0, x1, y1, w: float): SKPath =
  sk_path_rconic_to(this.native, x0, y0, x1, y1, w)
  this

proc rcubicTo*(this: SKPath, x0, y0, x1, y1, x2, y2: float): SKPath =
  sk_path_rcubic_to(this.native, x0, y0, x1, y1, x2, y2)
  this

proc arcTo*(this: SKPath, 
  rx: float, ry: float, 
  xAxisRotate: float, 
  arcSize: SKPathArcSize, 
  sweep: SKPathDirection, x, y: float): SKPath = 
    sk_path_arc_to(
      this.native, rx, ry, xAxisRotate, arcSize.sk_path_arc_size_t, sweep.sk_path_direction_t, x, y
    )
    result = this

proc addOval*(this: SKPath, bounds: SKRect, direction: SKPathDirection): SKPath =
  sk_path_add_oval(this.native, bounds.native.addr, direction.sk_path_direction_t)
  this

proc close*(this: SKPath) =
  sk_path_close(this.native)

proc reset*(this: SKPath) =
  sk_path_reset(this.native)

proc rewind*(this: SKPath) =
  sk_path_rewind(this.native)

proc `fillType=`*(this: SKPath, fillType: SKPathFillType) =
  sk_path_set_filltype(this.native, fillType.sk_path_filltype_t)





