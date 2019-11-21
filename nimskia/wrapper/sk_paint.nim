when defined(Linux):
  const dynlibsk_paint = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_paint_new*(): ptr sk_paint_t {.cdecl, importc: "sk_paint_new",
                                   dynlib: dynlibsk_paint.}
proc sk_paint_delete*(a1: ptr sk_paint_t) {.cdecl, importc: "sk_paint_delete",
                                        dynlib: dynlibsk_paint.}
proc sk_paint_is_antialias*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_antialias", dynlib: dynlibsk_paint.}
proc sk_paint_set_antialias*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_antialias", dynlib: dynlibsk_paint.}
proc sk_paint_get_color*(a1: ptr sk_paint_t): sk_color_t {.cdecl,
    importc: "sk_paint_get_color", dynlib: dynlibsk_paint.}
proc sk_paint_set_color*(a1: ptr sk_paint_t; a2: sk_color_t) {.cdecl,
    importc: "sk_paint_set_color", dynlib: dynlibsk_paint.}
proc sk_paint_is_stroke*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_stroke", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_stroke", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_width*(a1: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_stroke_width", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_width*(a1: ptr sk_paint_t; width: cfloat) {.cdecl,
    importc: "sk_paint_set_stroke_width", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_miter*(a1: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_stroke_miter", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_miter*(a1: ptr sk_paint_t; miter: cfloat) {.cdecl,
    importc: "sk_paint_set_stroke_miter", dynlib: dynlibsk_paint.}
type
  sk_stroke_cap_t* {.size: sizeof(cint).} = enum
    BUTT_SK_STROKE_CAP, ROUND_SK_STROKE_CAP, SQUARE_SK_STROKE_CAP


proc sk_paint_get_stroke_cap*(a1: ptr sk_paint_t): sk_stroke_cap_t {.cdecl,
    importc: "sk_paint_get_stroke_cap", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_cap*(a1: ptr sk_paint_t; a2: sk_stroke_cap_t) {.cdecl,
    importc: "sk_paint_set_stroke_cap", dynlib: dynlibsk_paint.}
type
  sk_stroke_join_t* {.size: sizeof(cint).} = enum
    MITER_SK_STROKE_JOIN, ROUND_SK_STROKE_JOIN, BEVEL_SK_STROKE_JOIN


proc sk_paint_get_stroke_join*(a1: ptr sk_paint_t): sk_stroke_join_t {.cdecl,
    importc: "sk_paint_get_stroke_join", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_join*(a1: ptr sk_paint_t; a2: sk_stroke_join_t) {.cdecl,
    importc: "sk_paint_set_stroke_join", dynlib: dynlibsk_paint.}
proc sk_paint_set_shader*(a1: ptr sk_paint_t; a2: ptr sk_shader_t) {.cdecl,
    importc: "sk_paint_set_shader", dynlib: dynlibsk_paint.}
proc sk_paint_set_maskfilter*(a1: ptr sk_paint_t; a2: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_paint_set_maskfilter", dynlib: dynlibsk_paint.}
proc sk_paint_set_xfermode_mode*(a1: ptr sk_paint_t; a2: sk_xfermode_mode_t) {.cdecl,
    importc: "sk_paint_set_xfermode_mode", dynlib: dynlibsk_paint.}