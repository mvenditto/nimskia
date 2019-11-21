when defined(Linux):
  const dynlibsk_matrix = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_matrix_set_identity*(a1: ptr sk_matrix_t) {.cdecl,
    importc: "sk_matrix_set_identity", dynlib: dynlibsk_matrix.}
proc sk_matrix_set_translate*(a1: ptr sk_matrix_t; tx: cfloat; ty: cfloat) {.cdecl,
    importc: "sk_matrix_set_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix_pre_translate*(a1: ptr sk_matrix_t; tx: cfloat; ty: cfloat) {.cdecl,
    importc: "sk_matrix_pre_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix_post_translate*(a1: ptr sk_matrix_t; tx: cfloat; ty: cfloat) {.cdecl,
    importc: "sk_matrix_post_translate", dynlib: dynlibsk_matrix.}
proc sk_matrix_set_scale*(a1: ptr sk_matrix_t; sx: cfloat; sy: cfloat) {.cdecl,
    importc: "sk_matrix_set_scale", dynlib: dynlibsk_matrix.}
proc sk_matrix_pre_scale*(a1: ptr sk_matrix_t; sx: cfloat; sy: cfloat) {.cdecl,
    importc: "sk_matrix_pre_scale", dynlib: dynlibsk_matrix.}
proc sk_matrix_post_scale*(a1: ptr sk_matrix_t; sx: cfloat; sy: cfloat) {.cdecl,
    importc: "sk_matrix_post_scale", dynlib: dynlibsk_matrix.}