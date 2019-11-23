when defined(Linux):
  const dynlibsk_picture = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_picture_recorder_new*(): ptr sk_picture_recorder_t {.cdecl,
    importc: "sk_picture_recorder_new", dynlib: dynlibsk_picture.}
proc sk_picture_recorder_delete*(a1: ptr sk_picture_recorder_t) {.cdecl,
    importc: "sk_picture_recorder_delete", dynlib: dynlibsk_picture.}
proc sk_picture_recorder_begin_recording*(a1: ptr sk_picture_recorder_t;
    a2: ptr sk_rect_t): ptr sk_canvas_t {.cdecl, importc: "sk_picture_recorder_begin_recording",
                                     dynlib: dynlibsk_picture.}
proc sk_picture_recorder_end_recording*(a1: ptr sk_picture_recorder_t): ptr sk_picture_t {.
    cdecl, importc: "sk_picture_recorder_end_recording", dynlib: dynlibsk_picture.}
proc sk_picture_recorder_end_recording_as_drawable*(a1: ptr sk_picture_recorder_t): ptr sk_drawable_t {.
    cdecl, importc: "sk_picture_recorder_end_recording_as_drawable",
    dynlib: dynlibsk_picture.}
proc sk_picture_get_recording_canvas*(crec: ptr sk_picture_recorder_t): ptr sk_canvas_t {.
    cdecl, importc: "sk_picture_get_recording_canvas", dynlib: dynlibsk_picture.}
proc sk_picture_ref*(a1: ptr sk_picture_t) {.cdecl, importc: "sk_picture_ref",
    dynlib: dynlibsk_picture.}
proc sk_picture_unref*(a1: ptr sk_picture_t) {.cdecl, importc: "sk_picture_unref",
    dynlib: dynlibsk_picture.}
proc sk_picture_get_unique_id*(a1: ptr sk_picture_t): uint32 {.cdecl,
    importc: "sk_picture_get_unique_id", dynlib: dynlibsk_picture.}
proc sk_picture_get_cull_rect*(a1: ptr sk_picture_t; a2: ptr sk_rect_t) {.cdecl,
    importc: "sk_picture_get_cull_rect", dynlib: dynlibsk_picture.}