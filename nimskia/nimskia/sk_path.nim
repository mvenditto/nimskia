import ../wrapper/sk_path
import ../wrapper/sk_types
import sk_enums
import sk_rect
import sk_matrix

type 
  SkPath* = ref object
    native*: ptr sk_path_t

proc newSkPath*(): SkPath =
  SkPath(native: sk_path_new())

proc dispose*(this: SkPath) =
  sk_path_delete(this.native)

proc parseSvgPathData*(svgString: cstring): SkPath =
  result = SkPath(native: sk_path_new())
  let success = sk_path_parse_svg_string(result.native, svgString)
  if not success:
    result.dispose()
    result = nil

proc moveTo*(this: SkPath, x, y: float): SkPath =
  sk_path_move_to(this.native, x, y)
  this

proc lineTo*(this: SkPath, x, y: float): SkPath =
  sk_path_line_to(this.native, x, y)
  this

proc quadTo*(this: SkPath, x0, y0, x1, y1: float): SkPath =
  sk_path_quad_to(this.native, x0, y0, x1, y1)
  this

proc conicTo*(this: SkPath, x0, y0, x1, y1, w: float): SkPath =
  sk_path_conic_to(this.native, x0, y0, x1, y1, w)
  this

proc cubicTo*(this: SkPath, x0, y0, x1, y1, x2, y2: float): SkPath =
  sk_path_cubic_to(this.native, x0, y0, x1, y1, x2, y2)
  this

proc rlineTo*(this: SkPath, x, y: float): SkPath =
  sk_path_rline_to(this.native, x, y)
  this

proc rquadTo*(this: SkPath, x0, y0, x1, y1: float): SkPath =
  sk_path_rquad_to(this.native, x0, y0, x1, y1)
  this

proc rconicTo*(this: SkPath, x0, y0, x1, y1, w: float): SkPath =
  sk_path_rconic_to(this.native, x0, y0, x1, y1, w)
  this

proc rcubicTo*(this: SkPath, x0, y0, x1, y1, x2, y2: float): SkPath =
  sk_path_rcubic_to(this.native, x0, y0, x1, y1, x2, y2)
  this

proc arcTo*(this: SkPath, 
  rx: float, ry: float, 
  xAxisRotate: float, 
  arcSize: SkPathArcSize, 
  sweep: SkPathDirection, x, y: float): SkPath = 
    sk_path_arc_to(
      this.native, rx, ry, xAxisRotate, arcSize.sk_path_arc_size_t, sweep.sk_path_direction_t, x, y
    )
    result = this

proc addOval*(this: SkPath, bounds: SkRect, direction: SkPathDirection): SkPath =
  sk_path_add_oval(this.native, bounds.native.addr, direction.sk_path_direction_t)
  this

proc close*(this: SkPath) =
  sk_path_close(this.native)

proc reset*(this: SkPath) =
  sk_path_reset(this.native)

proc rewind*(this: SkPath) =
  sk_path_rewind(this.native)

proc `fillType=`*(this: SkPath, fillType: SkPathFillType) =
  sk_path_set_filltype(this.native, fillType.sk_path_filltype_t)

proc bounds*(this: SkPath): SkRect =
  result = newSkRect()
  sk_path_get_bounds(this.native, result.native.addr)

proc tightBounds*(this: SkPath): SkRect =
  result = newSkRect()
  if not sk_pathop_tight_bounds(this.native, result.native.addr):
    result = nil

proc computeTightBounds*(this: SkPath): SkRect =
  result = newSkRect()
  sk_path_compute_tight_bounds(this.native, result.native.addr)

proc transform*(this: SkPath, mat: SkMatrix) =
  sk_path_transform(this.native, mat.native)






