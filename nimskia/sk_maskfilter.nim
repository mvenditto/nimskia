when defined(Linux):
  const dynlibsk_maskfilter = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
type
  sk_blurstyle_t* {.size: sizeof(cint).} = enum
    NORMAL_SK_BLUR_STYLE, SOLID_SK_BLUR_STYLE, OUTER_SK_BLUR_STYLE,
    INNER_SK_BLUR_STYLE


proc sk_maskfilter_ref*(a1: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_maskfilter_ref", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_unref*(a1: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_maskfilter_unref", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_blur*(a1: sk_blurstyle_t; sigma: cfloat): ptr sk_maskfilter_t {.
    cdecl, importc: "sk_maskfilter_new_blur", dynlib: dynlibsk_maskfilter.}