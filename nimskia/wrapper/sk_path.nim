when defined(Linux):
  const dynlibsk_path = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_path_new*(): ptr sk_path_t {.cdecl, importc: "sk_path_new",
                                 dynlib: dynlibsk_path.}
proc sk_path_delete*(a1: ptr sk_path_t) {.cdecl, importc: "sk_path_delete",
                                      dynlib: dynlibsk_path.}
proc sk_path_move_to*(a1: ptr sk_path_t; x: cfloat; y: cfloat) {.cdecl,
    importc: "sk_path_move_to", dynlib: dynlibsk_path.}
proc sk_path_line_to*(a1: ptr sk_path_t; x: cfloat; y: cfloat) {.cdecl,
    importc: "sk_path_line_to", dynlib: dynlibsk_path.}
proc sk_path_quad_to*(a1: ptr sk_path_t; x0: cfloat; y0: cfloat; x1: cfloat; y1: cfloat) {.
    cdecl, importc: "sk_path_quad_to", dynlib: dynlibsk_path.}
proc sk_path_conic_to*(a1: ptr sk_path_t; x0: cfloat; y0: cfloat; x1: cfloat; y1: cfloat;
                      w: cfloat) {.cdecl, importc: "sk_path_conic_to",
                                 dynlib: dynlibsk_path.}
proc sk_path_cubic_to*(a1: ptr sk_path_t; x0: cfloat; y0: cfloat; x1: cfloat; y1: cfloat;
                      x2: cfloat; y2: cfloat) {.cdecl, importc: "sk_path_cubic_to",
    dynlib: dynlibsk_path.}
proc sk_path_arc_to*(a1: ptr sk_path_t; rx: cfloat; ry: cfloat; xAxisRotate: cfloat;
                    largeArc: sk_path_arc_size_t; sweep: sk_path_direction_t;
                    x: cfloat; y: cfloat) {.cdecl, importc: "sk_path_arc_to",
                                        dynlib: dynlibsk_path.}
proc sk_path_rarc_to*(a1: ptr sk_path_t; rx: cfloat; ry: cfloat; xAxisRotate: cfloat;
                     largeArc: sk_path_arc_size_t; sweep: sk_path_direction_t;
                     x: cfloat; y: cfloat) {.cdecl, importc: "sk_path_rarc_to",
    dynlib: dynlibsk_path.}
proc sk_path_arc_to_with_oval*(a1: ptr sk_path_t; oval: ptr sk_rect_t;
                              startAngle: cfloat; sweepAngle: cfloat;
                              forceMoveTo: bool) {.cdecl,
    importc: "sk_path_arc_to_with_oval", dynlib: dynlibsk_path.}
proc sk_path_arc_to_with_points*(a1: ptr sk_path_t; x1: cfloat; y1: cfloat; x2: cfloat;
                                y2: cfloat; radius: cfloat) {.cdecl,
    importc: "sk_path_arc_to_with_points", dynlib: dynlibsk_path.}
proc sk_path_close*(a1: ptr sk_path_t) {.cdecl, importc: "sk_path_close",
                                     dynlib: dynlibsk_path.}
proc sk_path_add_rect*(a1: ptr sk_path_t; a2: ptr sk_rect_t; a3: sk_path_direction_t) {.
    cdecl, importc: "sk_path_add_rect", dynlib: dynlibsk_path.}
proc sk_path_add_rrect*(a1: ptr sk_path_t; a2: ptr sk_rrect_t; a3: sk_path_direction_t) {.
    cdecl, importc: "sk_path_add_rrect", dynlib: dynlibsk_path.}
proc sk_path_add_rrect_start*(a1: ptr sk_path_t; a2: ptr sk_rrect_t;
                             a3: sk_path_direction_t; a4: uint32) {.cdecl,
    importc: "sk_path_add_rrect_start", dynlib: dynlibsk_path.}
proc sk_path_add_rounded_rect*(a1: ptr sk_path_t; a2: ptr sk_rect_t; a3: cfloat;
                              a4: cfloat; a5: sk_path_direction_t) {.cdecl,
    importc: "sk_path_add_rounded_rect", dynlib: dynlibsk_path.}
proc sk_path_add_oval*(a1: ptr sk_path_t; a2: ptr sk_rect_t; a3: sk_path_direction_t) {.
    cdecl, importc: "sk_path_add_oval", dynlib: dynlibsk_path.}
proc sk_path_add_circle*(a1: ptr sk_path_t; x: cfloat; y: cfloat; radius: cfloat;
                        dir: sk_path_direction_t) {.cdecl,
    importc: "sk_path_add_circle", dynlib: dynlibsk_path.}
proc sk_path_get_bounds*(a1: ptr sk_path_t; a2: ptr sk_rect_t) {.cdecl,
    importc: "sk_path_get_bounds", dynlib: dynlibsk_path.}
proc sk_path_compute_tight_bounds*(a1: ptr sk_path_t; a2: ptr sk_rect_t) {.cdecl,
    importc: "sk_path_compute_tight_bounds", dynlib: dynlibsk_path.}
proc sk_path_rmove_to*(a1: ptr sk_path_t; dx: cfloat; dy: cfloat) {.cdecl,
    importc: "sk_path_rmove_to", dynlib: dynlibsk_path.}
proc sk_path_rline_to*(a1: ptr sk_path_t; dx: cfloat; yd: cfloat) {.cdecl,
    importc: "sk_path_rline_to", dynlib: dynlibsk_path.}
proc sk_path_rquad_to*(a1: ptr sk_path_t; dx0: cfloat; dy0: cfloat; dx1: cfloat;
                      dy1: cfloat) {.cdecl, importc: "sk_path_rquad_to",
                                   dynlib: dynlibsk_path.}
proc sk_path_rconic_to*(a1: ptr sk_path_t; dx0: cfloat; dy0: cfloat; dx1: cfloat;
                       dy1: cfloat; w: cfloat) {.cdecl, importc: "sk_path_rconic_to",
    dynlib: dynlibsk_path.}
proc sk_path_rcubic_to*(a1: ptr sk_path_t; dx0: cfloat; dy0: cfloat; dx1: cfloat;
                       dy1: cfloat; dx2: cfloat; dy2: cfloat) {.cdecl,
    importc: "sk_path_rcubic_to", dynlib: dynlibsk_path.}
proc sk_path_add_rect_start*(cpath: ptr sk_path_t; crect: ptr sk_rect_t;
                            cdir: sk_path_direction_t; startIndex: uint32) {.
    cdecl, importc: "sk_path_add_rect_start", dynlib: dynlibsk_path.}
proc sk_path_add_arc*(cpath: ptr sk_path_t; crect: ptr sk_rect_t; startAngle: cfloat;
                     sweepAngle: cfloat) {.cdecl, importc: "sk_path_add_arc",
    dynlib: dynlibsk_path.}
proc sk_path_get_filltype*(a1: ptr sk_path_t): sk_path_filltype_t {.cdecl,
    importc: "sk_path_get_filltype", dynlib: dynlibsk_path.}
proc sk_path_set_filltype*(a1: ptr sk_path_t; a2: sk_path_filltype_t) {.cdecl,
    importc: "sk_path_set_filltype", dynlib: dynlibsk_path.}
proc sk_path_transform*(cpath: ptr sk_path_t; cmatrix: ptr sk_matrix_t) {.cdecl,
    importc: "sk_path_transform", dynlib: dynlibsk_path.}
proc sk_path_clone*(cpath: ptr sk_path_t): ptr sk_path_t {.cdecl,
    importc: "sk_path_clone", dynlib: dynlibsk_path.}
proc sk_path_add_path_offset*(cpath: ptr sk_path_t; other: ptr sk_path_t; dx: cfloat;
                             dy: cfloat; add_mode: sk_path_add_mode_t) {.cdecl,
    importc: "sk_path_add_path_offset", dynlib: dynlibsk_path.}
proc sk_path_add_path_matrix*(cpath: ptr sk_path_t; other: ptr sk_path_t;
                             matrix: ptr sk_matrix_t; add_mode: sk_path_add_mode_t) {.
    cdecl, importc: "sk_path_add_path_matrix", dynlib: dynlibsk_path.}
proc sk_path_add_path*(cpath: ptr sk_path_t; other: ptr sk_path_t;
                      add_mode: sk_path_add_mode_t) {.cdecl,
    importc: "sk_path_add_path", dynlib: dynlibsk_path.}
proc sk_path_add_path_reverse*(cpath: ptr sk_path_t; other: ptr sk_path_t) {.cdecl,
    importc: "sk_path_add_path_reverse", dynlib: dynlibsk_path.}
proc sk_path_reset*(cpath: ptr sk_path_t) {.cdecl, importc: "sk_path_reset",
                                        dynlib: dynlibsk_path.}
proc sk_path_rewind*(cpath: ptr sk_path_t) {.cdecl, importc: "sk_path_rewind",
    dynlib: dynlibsk_path.}
proc sk_path_count_points*(cpath: ptr sk_path_t): cint {.cdecl,
    importc: "sk_path_count_points", dynlib: dynlibsk_path.}
proc sk_path_count_verbs*(cpath: ptr sk_path_t): cint {.cdecl,
    importc: "sk_path_count_verbs", dynlib: dynlibsk_path.}
proc sk_path_get_point*(cpath: ptr sk_path_t; index: cint; point: ptr sk_point_t) {.
    cdecl, importc: "sk_path_get_point", dynlib: dynlibsk_path.}
proc sk_path_get_points*(cpath: ptr sk_path_t; points: ptr sk_point_t; max: cint): cint {.
    cdecl, importc: "sk_path_get_points", dynlib: dynlibsk_path.}
proc sk_path_contains*(cpath: ptr sk_path_t; x: cfloat; y: cfloat): bool {.cdecl,
    importc: "sk_path_contains", dynlib: dynlibsk_path.}
proc sk_path_get_convexity*(cpath: ptr sk_path_t): sk_path_convexity_t {.cdecl,
    importc: "sk_path_get_convexity", dynlib: dynlibsk_path.}
proc sk_path_set_convexity*(cpath: ptr sk_path_t; convexity: sk_path_convexity_t) {.
    cdecl, importc: "sk_path_set_convexity", dynlib: dynlibsk_path.}
proc sk_path_parse_svg_string*(cpath: ptr sk_path_t; str: cstring): bool {.cdecl,
    importc: "sk_path_parse_svg_string", dynlib: dynlibsk_path.}
proc sk_path_to_svg_string*(cpath: ptr sk_path_t; str: ptr sk_string_t) {.cdecl,
    importc: "sk_path_to_svg_string", dynlib: dynlibsk_path.}
proc sk_path_get_last_point*(cpath: ptr sk_path_t; point: ptr sk_point_t): bool {.cdecl,
    importc: "sk_path_get_last_point", dynlib: dynlibsk_path.}
proc sk_path_convert_conic_to_quads*(p0: ptr sk_point_t; p1: ptr sk_point_t;
                                    p2: ptr sk_point_t; w: cfloat;
                                    pts: ptr sk_point_t; pow2: cint): cint {.cdecl,
    importc: "sk_path_convert_conic_to_quads", dynlib: dynlibsk_path.}
proc sk_path_add_poly*(cpath: ptr sk_path_t; points: ptr sk_point_t; count: cint;
                      close: bool) {.cdecl, importc: "sk_path_add_poly",
                                   dynlib: dynlibsk_path.}
proc sk_path_get_segment_masks*(cpath: ptr sk_path_t): uint32 {.cdecl,
    importc: "sk_path_get_segment_masks", dynlib: dynlibsk_path.}
proc sk_path_is_oval*(cpath: ptr sk_path_t; bounds: ptr sk_rect_t): bool {.cdecl,
    importc: "sk_path_is_oval", dynlib: dynlibsk_path.}
proc sk_path_is_rrect*(cpath: ptr sk_path_t; bounds: ptr sk_rrect_t): bool {.cdecl,
    importc: "sk_path_is_rrect", dynlib: dynlibsk_path.}
proc sk_path_is_line*(cpath: ptr sk_path_t; line: array[2, sk_point_t]): bool {.cdecl,
    importc: "sk_path_is_line", dynlib: dynlibsk_path.}
proc sk_path_is_rect*(cpath: ptr sk_path_t; rect: ptr sk_rect_t; isClosed: ptr bool;
                     direction: ptr sk_path_direction_t): bool {.cdecl,
    importc: "sk_path_is_rect", dynlib: dynlibsk_path.}
proc sk_path_create_iter*(cpath: ptr sk_path_t; forceClose: cint): ptr sk_path_iterator_t {.
    cdecl, importc: "sk_path_create_iter", dynlib: dynlibsk_path.}
proc sk_path_iter_next*(`iterator`: ptr sk_path_iterator_t;
                       points: array[4, sk_point_t]; doConsumeDegenerates: cint;
                       exact: cint): sk_path_verb_t {.cdecl,
    importc: "sk_path_iter_next", dynlib: dynlibsk_path.}
proc sk_path_iter_conic_weight*(`iterator`: ptr sk_path_iterator_t): cfloat {.cdecl,
    importc: "sk_path_iter_conic_weight", dynlib: dynlibsk_path.}
proc sk_path_iter_is_close_line*(`iterator`: ptr sk_path_iterator_t): cint {.cdecl,
    importc: "sk_path_iter_is_close_line", dynlib: dynlibsk_path.}
proc sk_path_iter_is_closed_contour*(`iterator`: ptr sk_path_iterator_t): cint {.
    cdecl, importc: "sk_path_iter_is_closed_contour", dynlib: dynlibsk_path.}
proc sk_path_iter_destroy*(`iterator`: ptr sk_path_iterator_t) {.cdecl,
    importc: "sk_path_iter_destroy", dynlib: dynlibsk_path.}
proc sk_path_create_rawiter*(cpath: ptr sk_path_t): ptr sk_path_rawiterator_t {.cdecl,
    importc: "sk_path_create_rawiter", dynlib: dynlibsk_path.}
proc sk_path_rawiter_peek*(`iterator`: ptr sk_path_rawiterator_t): sk_path_verb_t {.
    cdecl, importc: "sk_path_rawiter_peek", dynlib: dynlibsk_path.}
proc sk_path_rawiter_next*(`iterator`: ptr sk_path_rawiterator_t;
                          points: array[4, sk_point_t]): sk_path_verb_t {.cdecl,
    importc: "sk_path_rawiter_next", dynlib: dynlibsk_path.}
proc sk_path_rawiter_conic_weight*(`iterator`: ptr sk_path_rawiterator_t): cfloat {.
    cdecl, importc: "sk_path_rawiter_conic_weight", dynlib: dynlibsk_path.}
proc sk_path_rawiter_destroy*(`iterator`: ptr sk_path_rawiterator_t) {.cdecl,
    importc: "sk_path_rawiter_destroy", dynlib: dynlibsk_path.}
proc sk_pathop_op*(one: ptr sk_path_t; two: ptr sk_path_t; op: sk_pathop_t;
                  result: ptr sk_path_t): bool {.cdecl, importc: "sk_pathop_op",
    dynlib: dynlibsk_path.}
proc sk_pathop_simplify*(path: ptr sk_path_t; result: ptr sk_path_t): bool {.cdecl,
    importc: "sk_pathop_simplify", dynlib: dynlibsk_path.}
proc sk_pathop_tight_bounds*(path: ptr sk_path_t; result: ptr sk_rect_t): bool {.cdecl,
    importc: "sk_pathop_tight_bounds", dynlib: dynlibsk_path.}
proc sk_opbuilder_new*(): ptr sk_opbuilder_t {.cdecl, importc: "sk_opbuilder_new",
    dynlib: dynlibsk_path.}
proc sk_opbuilder_destroy*(builder: ptr sk_opbuilder_t) {.cdecl,
    importc: "sk_opbuilder_destroy", dynlib: dynlibsk_path.}
proc sk_opbuilder_add*(builder: ptr sk_opbuilder_t; path: ptr sk_path_t;
                      op: sk_pathop_t) {.cdecl, importc: "sk_opbuilder_add",
                                       dynlib: dynlibsk_path.}
proc sk_opbuilder_resolve*(builder: ptr sk_opbuilder_t; result: ptr sk_path_t): bool {.
    cdecl, importc: "sk_opbuilder_resolve", dynlib: dynlibsk_path.}
proc sk_pathmeasure_new*(): ptr sk_pathmeasure_t {.cdecl,
    importc: "sk_pathmeasure_new", dynlib: dynlibsk_path.}
proc sk_pathmeasure_new_with_path*(path: ptr sk_path_t; forceClosed: bool;
                                  resScale: cfloat): ptr sk_pathmeasure_t {.cdecl,
    importc: "sk_pathmeasure_new_with_path", dynlib: dynlibsk_path.}
proc sk_pathmeasure_destroy*(pathMeasure: ptr sk_pathmeasure_t) {.cdecl,
    importc: "sk_pathmeasure_destroy", dynlib: dynlibsk_path.}
proc sk_pathmeasure_set_path*(pathMeasure: ptr sk_pathmeasure_t;
                             path: ptr sk_path_t; forceClosed: bool) {.cdecl,
    importc: "sk_pathmeasure_set_path", dynlib: dynlibsk_path.}
proc sk_pathmeasure_get_length*(pathMeasure: ptr sk_pathmeasure_t): cfloat {.cdecl,
    importc: "sk_pathmeasure_get_length", dynlib: dynlibsk_path.}
proc sk_pathmeasure_get_pos_tan*(pathMeasure: ptr sk_pathmeasure_t;
                                distance: cfloat; position: ptr sk_point_t;
                                tangent: ptr sk_vector_t): bool {.cdecl,
    importc: "sk_pathmeasure_get_pos_tan", dynlib: dynlibsk_path.}
proc sk_pathmeasure_get_matrix*(pathMeasure: ptr sk_pathmeasure_t; distance: cfloat;
                               matrix: ptr sk_matrix_t;
                               flags: sk_pathmeasure_matrixflags_t): bool {.cdecl,
    importc: "sk_pathmeasure_get_matrix", dynlib: dynlibsk_path.}
proc sk_pathmeasure_get_segment*(pathMeasure: ptr sk_pathmeasure_t; start: cfloat;
                                stop: cfloat; dst: ptr sk_path_t;
                                startWithMoveTo: bool): bool {.cdecl,
    importc: "sk_pathmeasure_get_segment", dynlib: dynlibsk_path.}
proc sk_pathmeasure_is_closed*(pathMeasure: ptr sk_pathmeasure_t): bool {.cdecl,
    importc: "sk_pathmeasure_is_closed", dynlib: dynlibsk_path.}
proc sk_pathmeasure_next_contour*(pathMeasure: ptr sk_pathmeasure_t): bool {.cdecl,
    importc: "sk_pathmeasure_next_contour", dynlib: dynlibsk_path.}