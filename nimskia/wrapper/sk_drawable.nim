when defined(Linux):
  const dynlibsk_drawable = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}


proc sk_drawable_unref*(a1: ptr sk_drawable_t) {.cdecl, importc: "sk_drawable_unref",
    dynlib: dynlibsk_drawable.}
proc sk_drawable_get_generation_id*(a1: ptr sk_drawable_t): uint32 {.cdecl,
    importc: "sk_drawable_get_generation_id", dynlib: dynlibsk_drawable.}
proc sk_drawable_get_bounds*(a1: ptr sk_drawable_t; a2: ptr sk_rect_t) {.cdecl,
    importc: "sk_drawable_get_bounds", dynlib: dynlibsk_drawable.}
proc sk_drawable_draw*(a1: ptr sk_drawable_t; a2: ptr sk_canvas_t; a3: ptr sk_matrix_t) {.
    cdecl, importc: "sk_drawable_draw", dynlib: dynlibsk_drawable.}
proc sk_drawable_new_picture_snapshot*(a1: ptr sk_drawable_t): ptr sk_picture_t {.
    cdecl, importc: "sk_drawable_new_picture_snapshot", dynlib: dynlibsk_drawable.}
proc sk_drawable_notify_drawing_changed*(a1: ptr sk_drawable_t) {.cdecl,
    importc: "sk_drawable_notify_drawing_changed", dynlib: dynlibsk_drawable.}