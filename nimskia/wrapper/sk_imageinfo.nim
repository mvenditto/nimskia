when defined(Linux):
  const dynlibsk_imageinfo = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
type
  sk_colortype_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_COLORTYPE, RGBA_8888_SK_COLORTYPE, BGRA_8888_SK_COLORTYPE,
    ALPHA_8_SK_COLORTYPE, GRAY_8_SK_COLORTYPE, RGBA_F16_SK_COLORTYPE,
    RGBA_F32_SK_COLORTYPE
  sk_alphatype_t* {.size: sizeof(cint).} = enum
    OPAQUE_SK_ALPHATYPE, PREMUL_SK_ALPHATYPE, UNPREMUL_SK_ALPHATYPE



proc sk_imageinfo_new*(width: cint; height: cint; ct: sk_colortype_t;
                      at: sk_alphatype_t; cs: ptr sk_colorspace_t): ptr sk_imageinfo_t {.
    cdecl, importc: "sk_imageinfo_new", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_delete*(a1: ptr sk_imageinfo_t) {.cdecl,
    importc: "sk_imageinfo_delete", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_get_width*(a1: ptr sk_imageinfo_t): int32 {.cdecl,
    importc: "sk_imageinfo_get_width", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_get_height*(a1: ptr sk_imageinfo_t): int32 {.cdecl,
    importc: "sk_imageinfo_get_height", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_get_colortype*(a1: ptr sk_imageinfo_t): sk_colortype_t {.cdecl,
    importc: "sk_imageinfo_get_colortype", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_get_alphatype*(a1: ptr sk_imageinfo_t): sk_alphatype_t {.cdecl,
    importc: "sk_imageinfo_get_alphatype", dynlib: dynlibsk_imageinfo.}
proc sk_imageinfo_get_colorspace*(a1: ptr sk_imageinfo_t): ptr sk_colorspace_t {.
    cdecl, importc: "sk_imageinfo_get_colorspace", dynlib: dynlibsk_imageinfo.}