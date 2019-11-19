when defined(Linux):
  const dynlibsk_colorspace = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_colorspace_new_srgb*(): ptr sk_colorspace_t {.cdecl,
    importc: "sk_colorspace_new_srgb", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_ref*(a1: ptr sk_colorspace_t) {.cdecl,
    importc: "sk_colorspace_ref", dynlib: dynlibsk_colorspace.}
proc sk_colorspace_unref*(a1: ptr sk_colorspace_t) {.cdecl,
    importc: "sk_colorspace_unref", dynlib: dynlibsk_colorspace.}