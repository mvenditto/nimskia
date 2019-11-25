when defined(Linux):
  const dynlibsk_rrect = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_rrect_new*(): ptr sk_rrect_t {.cdecl, importc: "sk_rrect_new",
                                   dynlib: dynlibsk_rrect.}
proc sk_rrect_new_copy*(rrect: ptr sk_rrect_t): ptr sk_rrect_t {.cdecl,
    importc: "sk_rrect_new_copy", dynlib: dynlibsk_rrect.}
proc sk_rrect_delete*(rrect: ptr sk_rrect_t) {.cdecl, importc: "sk_rrect_delete",
    dynlib: dynlibsk_rrect.}
proc sk_rrect_get_type*(rrect: ptr sk_rrect_t): sk_rrect_type_t {.cdecl,
    importc: "sk_rrect_get_type", dynlib: dynlibsk_rrect.}
proc sk_rrect_get_rect*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t) {.cdecl,
    importc: "sk_rrect_get_rect", dynlib: dynlibsk_rrect.}
proc sk_rrect_get_radii*(rrect: ptr sk_rrect_t; corner: sk_rrect_corner_t;
                        radii: ptr sk_vector_t) {.cdecl,
    importc: "sk_rrect_get_radii", dynlib: dynlibsk_rrect.}
proc sk_rrect_get_width*(rrect: ptr sk_rrect_t): cfloat {.cdecl,
    importc: "sk_rrect_get_width", dynlib: dynlibsk_rrect.}
proc sk_rrect_get_height*(rrect: ptr sk_rrect_t): cfloat {.cdecl,
    importc: "sk_rrect_get_height", dynlib: dynlibsk_rrect.}
proc sk_rrect_set_empty*(rrect: ptr sk_rrect_t) {.cdecl,
    importc: "sk_rrect_set_empty", dynlib: dynlibsk_rrect.}
proc sk_rrect_set_rect*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t) {.cdecl,
    importc: "sk_rrect_set_rect", dynlib: dynlibsk_rrect.}
proc sk_rrect_set_oval*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t) {.cdecl,
    importc: "sk_rrect_set_oval", dynlib: dynlibsk_rrect.}
proc sk_rrect_set_rect_xy*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t; xRad: cfloat;
                          yRad: cfloat) {.cdecl, importc: "sk_rrect_set_rect_xy",
                                        dynlib: dynlibsk_rrect.}
proc sk_rrect_set_nine_patch*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t;
                             leftRad: cfloat; topRad: cfloat; rightRad: cfloat;
                             bottomRad: cfloat) {.cdecl,
    importc: "sk_rrect_set_nine_patch", dynlib: dynlibsk_rrect.}
proc sk_rrect_set_rect_radii*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t;
                             radii: ptr sk_vector_t) {.cdecl,
    importc: "sk_rrect_set_rect_radii", dynlib: dynlibsk_rrect.}
proc sk_rrect_inset*(rrect: ptr sk_rrect_t; dx: cfloat; dy: cfloat) {.cdecl,
    importc: "sk_rrect_inset", dynlib: dynlibsk_rrect.}
proc sk_rrect_outset*(rrect: ptr sk_rrect_t; dx: cfloat; dy: cfloat) {.cdecl,
    importc: "sk_rrect_outset", dynlib: dynlibsk_rrect.}
proc sk_rrect_offset*(rrect: ptr sk_rrect_t; dx: cfloat; dy: cfloat) {.cdecl,
    importc: "sk_rrect_offset", dynlib: dynlibsk_rrect.}
proc sk_rrect_contains*(rrect: ptr sk_rrect_t; rect: ptr sk_rect_t): bool {.cdecl,
    importc: "sk_rrect_contains", dynlib: dynlibsk_rrect.}
proc sk_rrect_is_valid*(rrect: ptr sk_rrect_t): bool {.cdecl,
    importc: "sk_rrect_is_valid", dynlib: dynlibsk_rrect.}
proc sk_rrect_transform*(rrect: ptr sk_rrect_t; matrix: ptr sk_matrix_t;
                        dest: ptr sk_rrect_t): bool {.cdecl,
    importc: "sk_rrect_transform", dynlib: dynlibsk_rrect.}