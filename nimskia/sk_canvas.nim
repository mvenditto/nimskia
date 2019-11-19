when defined(Linux):
  const dynlibsk_canvas = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_canvas_save*(a1: ptr sk_canvas_t) {.cdecl, importc: "sk_canvas_save",
                                        dynlib: dynlibsk_canvas.}
proc sk_canvas_save_layer*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; a3: ptr sk_paint_t) {.
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
proc sk_canvas_clip_rect*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t) {.cdecl,
    importc: "sk_canvas_clip_rect", dynlib: dynlibsk_canvas.}
proc sk_canvas_clip_path*(a1: ptr sk_canvas_t; a2: ptr sk_path_t) {.cdecl,
    importc: "sk_canvas_clip_path", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_paint*(a1: ptr sk_canvas_t; a2: ptr sk_paint_t) {.cdecl,
    importc: "sk_canvas_draw_paint", dynlib: dynlibsk_canvas.}
proc sk_canvas_draw_rect*(a1: ptr sk_canvas_t; a2: ptr sk_rect_t; a3: ptr sk_paint_t) {.
    cdecl, importc: "sk_canvas_draw_rect", dynlib: dynlibsk_canvas.}
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