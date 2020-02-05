when defined(Linux):
  const dynlibsk_maskfilter = "libskia.so"
when defined(Windows):
  const dynlibsk_maskfilter = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_maskfilter_ref*(a1: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_maskfilter_ref", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_unref*(a1: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_maskfilter_unref", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_blur*(a1: sk_blurstyle_t; sigma: cfloat): ptr sk_maskfilter_t {.
    cdecl, importc: "sk_maskfilter_new_blur", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_blur_with_flags*(a1: sk_blurstyle_t; sigma: cfloat;
                                       occluder: ptr sk_rect_t; respectCTM: bool): ptr sk_maskfilter_t {.
    cdecl, importc: "sk_maskfilter_new_blur_with_flags",
    dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_table*(table: array[256, uint8]): ptr sk_maskfilter_t {.
    cdecl, importc: "sk_maskfilter_new_table", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_gamma*(gamma: cfloat): ptr sk_maskfilter_t {.cdecl,
    importc: "sk_maskfilter_new_gamma", dynlib: dynlibsk_maskfilter.}
proc sk_maskfilter_new_clip*(min: uint8; max: uint8): ptr sk_maskfilter_t {.cdecl,
    importc: "sk_maskfilter_new_clip", dynlib: dynlibsk_maskfilter.}