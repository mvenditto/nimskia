when defined(Linux):
  const dynlibsk_svg = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_svgcanvas_create*(bounds: ptr sk_rect_t; writer: ptr sk_xmlwriter_t): ptr sk_canvas_t {.
    cdecl, importc: "sk_svgcanvas_create", dynlib: dynlibsk_svg.}