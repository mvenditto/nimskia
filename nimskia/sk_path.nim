when defined(Linux):
  const dynlibsk_path = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
type
  sk_path_direction_t* {.size: sizeof(cint).} = enum
    CW_SK_PATH_DIRECTION, CCW_SK_PATH_DIRECTION


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
proc sk_path_close*(a1: ptr sk_path_t) {.cdecl, importc: "sk_path_close",
                                     dynlib: dynlibsk_path.}
proc sk_path_add_rect*(a1: ptr sk_path_t; a2: ptr sk_rect_t; a3: sk_path_direction_t) {.
    cdecl, importc: "sk_path_add_rect", dynlib: dynlibsk_path.}
proc sk_path_add_oval*(a1: ptr sk_path_t; a2: ptr sk_rect_t; a3: sk_path_direction_t) {.
    cdecl, importc: "sk_path_add_oval", dynlib: dynlibsk_path.}
proc sk_path_get_bounds*(a1: ptr sk_path_t; a2: ptr sk_rect_t): bool {.cdecl,
    importc: "sk_path_get_bounds", dynlib: dynlibsk_path.}