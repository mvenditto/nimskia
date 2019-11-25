when defined(Linux):
  const dynlibsk_canvas = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_canvas_destroy*(a1: ptr sk_canvas_t) {.cdecl, importc: "sk_canvas_destroy",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_save*(a1: ptr sk_canvas_t): cint {.cdecl, importc: "sk_canvas_save",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_save_layer*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; a3: ptr sk_paint_t): cint {.
    cdecl, importc: "sk_canvas_save_layer", dynlib: dynlibsk_canvas.}
proc sk_canvas_restore*(a1: ptr sk_canvas_t) {.cdecl, importc: "sk_canvas_restore",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_translate*(a1: ptr sk_canvas_t; dx: cfloat; dy: cfloat) {.cdecl,
    importc: "sk_canvas_translate", dynlib: dynlibsk_canvas.}
proc sk_canvas_scale*(a1: ptr sk_canvas_t; sx: cfloat; sy: cfloat) {.cdecl,
    importc: "sk_canvas_scale", dynlib: dynlibsk_canvas.}
proc sk_canvas_rotate_degrees*(a1: ptr sk_canvas_t; degrees: cfloat) {.cdecl,
    importc: "sk_canvas_rotate_degrees", dynlib: dynlibsk_canvas.}
proc sk_canvas_rotate_radians*(a1: ptr sk_canvas_t; radians: cfloat) {.cdecl,
    importc: "sk_canvas_rotate_radians", dynlib: dynlibsk_canvas.}
proc sk_canvas_skew*(a1: ptr sk_canvas_t; sx: cfloat; sy: cfloat) {.cdecl,
    importc: "sk_canvas_skew", dynlib: dynlibsk_canvas.}
proc sk_canvas_concat*(a1: ptr sk_canvas_t; a2: ptr sk_matrix_t) {.cdecl,
    importc: "sk_canvas_concat", dynlib: dynlibsk_canvas.}
proc sk_canvas_quick_reject*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t): bool {.cdecl,
    importc: "sk_canvas_quick_reject", dynlib: dynlibsk_canvas.}
proc sk_canvas_clip_region*(canvas: ptr sk_canvas_t; region: ptr sk_region_t;
                           op: sk_clipop_t) {.cdecl,
    importc: "sk_canvas_clip_region", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_paint*(a1: ptr sk_canvas_t; a2: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_paint", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_rect*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; a3: ptr sk_paint_t) {.
    cdecl, importc: "sk_canvas_draw_rect", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_rrect*(a1: ptr sk_canvas_t; a2: ptr sk_rrect_t; a3: ptr sk_paint_t) {.
    cdecl, importc: "sk_canvas_draw_rrect", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_region*(a1: ptr sk_canvas_t; a2: ptr sk_region_t;
                           a3: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_region", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_circle*(a1: ptr sk_canvas_t; cx: cfloat; cy: cfloat; rad: cfloat;
                           a5: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_circle", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_oval*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; a3: ptr sk_paint_t) {.
    cdecl, importc: "sk_canvas_draw_oval", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_path*(a1: ptr sk_canvas_t; a2: ptr sk_path_t; a3: ptr sk_paint_t) {.
    cdecl, importc: "sk_canvas_draw_path", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_image*(a1: ptr sk_canvas_t; a2: ptr sk_image_t; x: cfloat; y: cfloat;
                          a5: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_image", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_image_rect*(a1: ptr sk_canvas_t; a2: ptr sk_image_t;
                               src: ptr sk_rect_t; dst: ptr sk_rect_t;
                               a5: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_image_rect", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_picture*(a1: ptr sk_canvas_t; a2: ptr sk_picture_t;
                            a3: ptr sk_matrix_t; a4: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_picture", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_drawable*(a1: ptr sk_canvas_t; a2: ptr sk_drawable_t;
                             a3: ptr sk_matrix_t) {.cdecl,
    importc: "sk_canvas_draw_drawable", dynlib: dynlibsk_canvas.}
proc sk_canvas_clear*(a1: ptr sk_canvas_t; a2: sk_color_t) {.cdecl,
    importc: "sk_canvas_clear", dynlib: dynlibsk_canvas.}
proc sk_canvas_discard*(a1: ptr sk_canvas_t) {.cdecl, importc: "sk_canvas_discard",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_get_save_count*(a1: ptr sk_canvas_t): cint {.cdecl,
    importc: "sk_canvas_get_save_count", dynlib: dynlibsk_canvas.}
proc sk_canvas_restore_to_count*(a1: ptr sk_canvas_t; saveCount: cint) {.cdecl,
    importc: "sk_canvas_restore_to_count", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_color*(ccanvas: ptr sk_canvas_t; color: sk_color_t;
                          mode: sk_blendmode_t) {.cdecl,
    importc: "sk_canvas_draw_color", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_points*(a1: ptr sk_canvas_t; a2: sk_point_mode_t; a3: csize;
                           a4: ptr sk_point_t; a5: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_points", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_point*(a1: ptr sk_canvas_t; a2: cfloat; a3: cfloat;
                          a4: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_point", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_line*(ccanvas: ptr sk_canvas_t; x0: cfloat; y0: cfloat; x1: cfloat;
                         y1: cfloat; cpaint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_line", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_text*(a1: ptr sk_canvas_t; text: cstring; byteLength: csize;
                         x: cfloat; y: cfloat; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_text", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_pos_text*(a1: ptr sk_canvas_t; text: cstring; byteLength: csize;
                             a4: ptr sk_point_t; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_pos_text", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_text_on_path*(a1: ptr sk_canvas_t; text: cstring;
                                 byteLength: csize; path: ptr sk_path_t;
                                 hOffset: cfloat; vOffset: cfloat;
                                 paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_text_on_path", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_text_blob*(a1: ptr sk_canvas_t; text: ptr sk_textblob_t; x: cfloat;
                              y: cfloat; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_text_blob", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_bitmap*(ccanvas: ptr sk_canvas_t; bitmap: ptr sk_bitmap_t;
                           left: cfloat; top: cfloat; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_bitmap", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_bitmap_rect*(ccanvas: ptr sk_canvas_t; bitmap: ptr sk_bitmap_t;
                                src: ptr sk_rect_t; dst: ptr sk_rect_t;
                                paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_bitmap_rect", dynlib: dynlibsk_canvas.}
proc sk_canvas_reset_matrix*(ccanvas: ptr sk_canvas_t) {.cdecl,
    importc: "sk_canvas_reset_matrix", dynlib: dynlibsk_canvas.}
proc sk_canvas_set_matrix*(ccanvas: ptr sk_canvas_t; matrix: ptr sk_matrix_t) {.cdecl,
    importc: "sk_canvas_set_matrix", dynlib: dynlibsk_canvas.}
proc sk_canvas_get_total_matrix*(ccanvas: ptr sk_canvas_t; matrix: ptr sk_matrix_t) {.
    cdecl, importc: "sk_canvas_get_total_matrix", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_round_rect*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; rx: cfloat;
                               ry: cfloat; a5: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_round_rect", dynlib: dynlibsk_canvas.}
proc sk_canvas_clip_rect_with_operation*(t: ptr sk_canvas_t; crect: ptr sk_rect_t;
                                        op: sk_clipop_t; doAA: bool) {.cdecl,
    importc: "sk_canvas_clip_rect_with_operation", dynlib: dynlibsk_canvas.}
proc sk_canvas_clip_path_with_operation*(t: ptr sk_canvas_t; crect: ptr sk_path_t;
                                        op: sk_clipop_t; doAA: bool) {.cdecl,
    importc: "sk_canvas_clip_path_with_operation", dynlib: dynlibsk_canvas.}
proc sk_canvas_clip_rrect_with_operation*(t: ptr sk_canvas_t; crect: ptr sk_rrect_t;
    op: sk_clipop_t; doAA: bool) {.cdecl,
                               importc: "sk_canvas_clip_rrect_with_operation",
                               dynlib: dynlibsk_canvas.}
proc sk_canvas_get_local_clip_bounds*(t: ptr sk_canvas_t; cbounds: ptr sk_rect_t): bool {.
    cdecl, importc: "sk_canvas_get_local_clip_bounds", dynlib: dynlibsk_canvas.}
proc sk_canvas_get_device_clip_bounds*(t: ptr sk_canvas_t; cbounds: ptr sk_irect_t): bool {.
    cdecl, importc: "sk_canvas_get_device_clip_bounds", dynlib: dynlibsk_canvas.}
proc sk_canvas_flush*(ccanvas: ptr sk_canvas_t) {.cdecl, importc: "sk_canvas_flush",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_new_from_bitmap*(bitmap: ptr sk_bitmap_t): ptr sk_canvas_t {.cdecl,
    importc: "sk_canvas_new_from_bitmap", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_annotation*(t: ptr sk_canvas_t; rect: ptr sk_rect_t; key: cstring;
                               value: ptr sk_data_t) {.cdecl,
    importc: "sk_canvas_draw_annotation", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_url_annotation*(t: ptr sk_canvas_t; rect: ptr sk_rect_t;
                                   value: ptr sk_data_t) {.cdecl,
    importc: "sk_canvas_draw_url_annotation", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_named_destination_annotation*(t: ptr sk_canvas_t;
    point: ptr sk_point_t; value: ptr sk_data_t) {.cdecl,
    importc: "sk_canvas_draw_named_destination_annotation",
    dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_link_destination_annotation*(t: ptr sk_canvas_t;
    rect: ptr sk_rect_t; value: ptr sk_data_t) {.cdecl,
    importc: "sk_canvas_draw_link_destination_annotation", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_bitmap_lattice*(t: ptr sk_canvas_t; bitmap: ptr sk_bitmap_t;
                                   lattice: ptr sk_lattice_t; dst: ptr sk_rect_t;
                                   paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_bitmap_lattice", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_image_lattice*(t: ptr sk_canvas_t; image: ptr sk_image_t;
                                  lattice: ptr sk_lattice_t; dst: ptr sk_rect_t;
                                  paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_image_lattice", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_bitmap_nine*(t: ptr sk_canvas_t; bitmap: ptr sk_bitmap_t;
                                center: ptr sk_irect_t; dst: ptr sk_rect_t;
                                paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_bitmap_nine", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_image_nine*(t: ptr sk_canvas_t; image: ptr sk_image_t;
                               center: ptr sk_irect_t; dst: ptr sk_rect_t;
                               paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_image_nine", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_vertices*(ccanvas: ptr sk_canvas_t; vertices: ptr sk_vertices_t;
                             mode: sk_blendmode_t; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_vertices", dynlib: dynlibsk_canvas.}
proc sk_nodraw_canvas_new*(width: cint; height: cint): ptr sk_nodraw_canvas_t {.cdecl,
    importc: "sk_nodraw_canvas_new", dynlib: dynlibsk_canvas.}
proc sk_nodraw_canvas_destroy*(a1: ptr sk_nodraw_canvas_t) {.cdecl,
    importc: "sk_nodraw_canvas_destroy", dynlib: dynlibsk_canvas.}
proc sk_nway_canvas_new*(width: cint; height: cint): ptr sk_nway_canvas_t {.cdecl,
    importc: "sk_nway_canvas_new", dynlib: dynlibsk_canvas.}
proc sk_nway_canvas_destroy*(a1: ptr sk_nway_canvas_t) {.cdecl,
    importc: "sk_nway_canvas_destroy", dynlib: dynlibsk_canvas.}
proc sk_nway_canvas_add_canvas*(a1: ptr sk_nway_canvas_t; canvas: ptr sk_canvas_t) {.
    cdecl, importc: "sk_nway_canvas_add_canvas", dynlib: dynlibsk_canvas.}
proc sk_nway_canvas_remove_canvas*(a1: ptr sk_nway_canvas_t; canvas: ptr sk_canvas_t) {.
    cdecl, importc: "sk_nway_canvas_remove_canvas", dynlib: dynlibsk_canvas.}
proc sk_nway_canvas_remove_all*(a1: ptr sk_nway_canvas_t) {.cdecl,
    importc: "sk_nway_canvas_remove_all", dynlib: dynlibsk_canvas.}
proc sk_overdraw_canvas_new*(canvas: ptr sk_canvas_t): ptr sk_overdraw_canvas_t {.
    cdecl, importc: "sk_overdraw_canvas_new", dynlib: dynlibsk_canvas.}
proc sk_overdraw_canvas_destroy*(canvas: ptr sk_overdraw_canvas_t) {.cdecl,
    importc: "sk_overdraw_canvas_destroy", dynlib: dynlibsk_canvas.}