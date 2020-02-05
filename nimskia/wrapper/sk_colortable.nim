when defined(Linux):
  const dynlibsk_colortable = "libskia.so"
when defined(Windows):
  const dynlibsk_colortable = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_colortable_unref*(ctable: ptr sk_colortable_t) {.cdecl,
    importc: "sk_colortable_unref", dynlib: dynlibsk_colortable.}
proc sk_colortable_new*(colors: ptr sk_pmcolor_t; count: cint): ptr sk_colortable_t {.
    cdecl, importc: "sk_colortable_new", dynlib: dynlibsk_colortable.}
proc sk_colortable_count*(ctable: ptr sk_colortable_t): cint {.cdecl,
    importc: "sk_colortable_count", dynlib: dynlibsk_colortable.}
proc sk_colortable_read_colors*(ctable: ptr sk_colortable_t;
                               colors: ptr ptr sk_pmcolor_t) {.cdecl,
    importc: "sk_colortable_read_colors", dynlib: dynlibsk_colortable.}