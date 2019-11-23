when defined(Linux):
  const dynlibsk_matrix = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_matrix_try_invert*(matrix: ptr sk_matrix_t; result: ptr sk_matrix_t): bool {.
    cdecl, importc: "sk_matrix_try_invert", dynlib: dynlibsk_matrix.}
proc sk_matrix_concat*(result: ptr sk_matrix_t; first: ptr sk_matrix_t;
                      second: ptr sk_matrix_t) {.cdecl, importc: "sk_matrix_concat",
    dynlib: dynlibsk_matrix.}
proc sk_matrix_pre_concat*(result: ptr sk_matrix_t; matrix: ptr sk_matrix_t) {.cdecl,
    importc: "sk_matrix_pre_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix_post_concat*(result: ptr sk_matrix_t; matrix: ptr sk_matrix_t) {.cdecl,
    importc: "sk_matrix_post_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix_map_rect*(matrix: ptr sk_matrix_t; dest: ptr sk_rect_t;
                        source: ptr sk_rect_t) {.cdecl,
    importc: "sk_matrix_map_rect", dynlib: dynlibsk_matrix.}
proc sk_matrix_map_points*(matrix: ptr sk_matrix_t; dst: ptr sk_point_t;
                          src: ptr sk_point_t; count: cint) {.cdecl,
    importc: "sk_matrix_map_points", dynlib: dynlibsk_matrix.}
proc sk_matrix_map_vectors*(matrix: ptr sk_matrix_t; dst: ptr sk_point_t;
                           src: ptr sk_point_t; count: cint) {.cdecl,
    importc: "sk_matrix_map_vectors", dynlib: dynlibsk_matrix.}
proc sk_matrix_map_xy*(matrix: ptr sk_matrix_t; x: cfloat; y: cfloat;
                      result: ptr sk_point_t) {.cdecl, importc: "sk_matrix_map_xy",
    dynlib: dynlibsk_matrix.}
proc sk_matrix_map_vector*(matrix: ptr sk_matrix_t; x: cfloat; y: cfloat;
                          result: ptr sk_point_t) {.cdecl,
    importc: "sk_matrix_map_vector", dynlib: dynlibsk_matrix.}
proc sk_matrix_map_radius*(matrix: ptr sk_matrix_t; radius: cfloat): cfloat {.cdecl,
    importc: "sk_matrix_map_radius", dynlib: dynlibsk_matrix.}
proc sk_3dview_new*(): ptr sk_3dview_t {.cdecl, importc: "sk_3dview_new",
                                     dynlib: dynlibsk_matrix.}
proc sk_3dview_destroy*(cview: ptr sk_3dview_t) {.cdecl,
    importc: "sk_3dview_destroy", dynlib: dynlibsk_matrix.}
proc sk_3dview_save*(cview: ptr sk_3dview_t) {.cdecl, importc: "sk_3dview_save",
    dynlib: dynlibsk_matrix.}
proc sk_3dview_restore*(cview: ptr sk_3dview_t) {.cdecl,
    importc: "sk_3dview_restore", dynlib: dynlibsk_matrix.}
proc sk_3dview_translate*(cview: ptr sk_3dview_t; x: cfloat; y: cfloat; z: cfloat) {.
    cdecl, importc: "sk_3dview_translate", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_x_degrees*(cview: ptr sk_3dview_t; degrees: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_x_degrees", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_y_degrees*(cview: ptr sk_3dview_t; degrees: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_y_degrees", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_z_degrees*(cview: ptr sk_3dview_t; degrees: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_z_degrees", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_x_radians*(cview: ptr sk_3dview_t; radians: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_x_radians", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_y_radians*(cview: ptr sk_3dview_t; radians: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_y_radians", dynlib: dynlibsk_matrix.}
proc sk_3dview_rotate_z_radians*(cview: ptr sk_3dview_t; radians: cfloat) {.cdecl,
    importc: "sk_3dview_rotate_z_radians", dynlib: dynlibsk_matrix.}
proc sk_3dview_get_matrix*(cview: ptr sk_3dview_t; cmatrix: ptr sk_matrix_t) {.cdecl,
    importc: "sk_3dview_get_matrix", dynlib: dynlibsk_matrix.}
proc sk_3dview_apply_to_canvas*(cview: ptr sk_3dview_t; ccanvas: ptr sk_canvas_t) {.
    cdecl, importc: "sk_3dview_apply_to_canvas", dynlib: dynlibsk_matrix.}
proc sk_3dview_dot_with_normal*(cview: ptr sk_3dview_t; dx: cfloat; dy: cfloat;
                               dz: cfloat): cfloat {.cdecl,
    importc: "sk_3dview_dot_with_normal", dynlib: dynlibsk_matrix.}
proc sk_matrix44_destroy*(matrix: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_destroy", dynlib: dynlibsk_matrix.}
proc sk_matrix44_new*(): ptr sk_matrix44_t {.cdecl, importc: "sk_matrix44_new",
    dynlib: dynlibsk_matrix.}
proc sk_matrix44_new_identity*(): ptr sk_matrix44_t {.cdecl,
    importc: "sk_matrix44_new_identity", dynlib: dynlibsk_matrix.}
proc sk_matrix44_new_copy*(src: ptr sk_matrix44_t): ptr sk_matrix44_t {.cdecl,
    importc: "sk_matrix44_new_copy", dynlib: dynlibsk_matrix.}
proc sk_matrix44_new_concat*(a: ptr sk_matrix44_t; b: ptr sk_matrix44_t): ptr sk_matrix44_t {.
    cdecl, importc: "sk_matrix44_new_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix44_new_matrix*(src: ptr sk_matrix_t): ptr sk_matrix44_t {.cdecl,
    importc: "sk_matrix44_new_matrix", dynlib: dynlibsk_matrix.}
proc sk_matrix44_equals*(matrix: ptr sk_matrix44_t; other: ptr sk_matrix44_t): bool {.
    cdecl, importc: "sk_matrix44_equals", dynlib: dynlibsk_matrix.}
proc sk_matrix44_to_matrix*(matrix: ptr sk_matrix44_t; dst: ptr sk_matrix_t) {.cdecl,
    importc: "sk_matrix44_to_matrix", dynlib: dynlibsk_matrix.}
proc sk_matrix44_get_type*(matrix: ptr sk_matrix44_t): sk_matrix44_type_mask_t {.
    cdecl, importc: "sk_matrix44_get_type", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_identity*(matrix: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_set_identity", dynlib: dynlibsk_matrix.}
proc sk_matrix44_get*(matrix: ptr sk_matrix44_t; row: cint; col: cint): cfloat {.cdecl,
    importc: "sk_matrix44_get", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set*(matrix: ptr sk_matrix44_t; row: cint; col: cint; value: cfloat) {.
    cdecl, importc: "sk_matrix44_set", dynlib: dynlibsk_matrix.}
proc sk_matrix44_as_col_major*(matrix: ptr sk_matrix44_t; dst: ptr cfloat) {.cdecl,
    importc: "sk_matrix44_as_col_major", dynlib: dynlibsk_matrix.}
proc sk_matrix44_as_row_major*(matrix: ptr sk_matrix44_t; dst: ptr cfloat) {.cdecl,
    importc: "sk_matrix44_as_row_major", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_col_major*(matrix: ptr sk_matrix44_t; dst: ptr cfloat) {.cdecl,
    importc: "sk_matrix44_set_col_major", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_row_major*(matrix: ptr sk_matrix44_t; dst: ptr cfloat) {.cdecl,
    importc: "sk_matrix44_set_row_major", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_translate*(matrix: ptr sk_matrix44_t; dx: cfloat; dy: cfloat;
                               dz: cfloat) {.cdecl,
    importc: "sk_matrix44_set_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix44_pre_translate*(matrix: ptr sk_matrix44_t; dx: cfloat; dy: cfloat;
                               dz: cfloat) {.cdecl,
    importc: "sk_matrix44_pre_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix44_post_translate*(matrix: ptr sk_matrix44_t; dx: cfloat; dy: cfloat;
                                dz: cfloat) {.cdecl,
    importc: "sk_matrix44_post_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_scale*(matrix: ptr sk_matrix44_t; sx: cfloat; sy: cfloat;
                           sz: cfloat) {.cdecl, importc: "sk_matrix44_set_scale",
                                       dynlib: dynlibsk_matrix.}
proc sk_matrix44_pre_scale*(matrix: ptr sk_matrix44_t; sx: cfloat; sy: cfloat;
                           sz: cfloat) {.cdecl, importc: "sk_matrix44_pre_scale",
                                       dynlib: dynlibsk_matrix.}
proc sk_matrix44_post_scale*(matrix: ptr sk_matrix44_t; sx: cfloat; sy: cfloat;
                            sz: cfloat) {.cdecl, importc: "sk_matrix44_post_scale",
                                        dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_rotate_about_degrees*(matrix: ptr sk_matrix44_t; x: cfloat;
    y: cfloat; z: cfloat; degrees: cfloat) {.cdecl, importc: "sk_matrix44_set_rotate_about_degrees",
                                       dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_rotate_about_radians*(matrix: ptr sk_matrix44_t; x: cfloat;
    y: cfloat; z: cfloat; radians: cfloat) {.cdecl, importc: "sk_matrix44_set_rotate_about_radians",
                                       dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_rotate_about_radians_unit*(matrix: ptr sk_matrix44_t;
    x: cfloat; y: cfloat; z: cfloat; radians: cfloat) {.cdecl,
    importc: "sk_matrix44_set_rotate_about_radians_unit", dynlib: dynlibsk_matrix.}
proc sk_matrix44_set_concat*(matrix: ptr sk_matrix44_t; a: ptr sk_matrix44_t;
                            b: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_set_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix44_pre_concat*(matrix: ptr sk_matrix44_t; m: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_pre_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix44_post_concat*(matrix: ptr sk_matrix44_t; m: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_post_concat", dynlib: dynlibsk_matrix.}
proc sk_matrix44_invert*(matrix: ptr sk_matrix44_t; inverse: ptr sk_matrix44_t): bool {.
    cdecl, importc: "sk_matrix44_invert", dynlib: dynlibsk_matrix.}
proc sk_matrix44_transpose*(matrix: ptr sk_matrix44_t) {.cdecl,
    importc: "sk_matrix44_transpose", dynlib: dynlibsk_matrix.}
proc sk_matrix44_map_scalars*(matrix: ptr sk_matrix44_t; src: ptr cfloat;
                             dst: ptr cfloat) {.cdecl,
    importc: "sk_matrix44_map_scalars", dynlib: dynlibsk_matrix.}
proc sk_matrix44_map2*(matrix: ptr sk_matrix44_t; src2: ptr cfloat; count: cint;
                      dst4: ptr cfloat) {.cdecl, importc: "sk_matrix44_map2",
                                       dynlib: dynlibsk_matrix.}
proc sk_matrix44_preserves_2d_axis_alignment*(matrix: ptr sk_matrix44_t;
    epsilon: cfloat): bool {.cdecl,
                          importc: "sk_matrix44_preserves_2d_axis_alignment",
                          dynlib: dynlibsk_matrix.}
proc sk_matrix44_determinant*(matrix: ptr sk_matrix44_t): cdouble {.cdecl,
    importc: "sk_matrix44_determinant", dynlib: dynlibsk_matrix.}