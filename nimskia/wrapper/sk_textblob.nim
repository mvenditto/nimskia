when defined(Linux):
  const dynlibsk_textblob = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_textblob_ref*(blob: ptr sk_textblob_t) {.cdecl, importc: "sk_textblob_ref",
    dynlib: dynlibsk_textblob.}
proc sk_textblob_unref*(blob: ptr sk_textblob_t) {.cdecl,
    importc: "sk_textblob_unref", dynlib: dynlibsk_textblob.}
proc sk_textblob_get_unique_id*(blob: ptr sk_textblob_t): uint32 {.cdecl,
    importc: "sk_textblob_get_unique_id", dynlib: dynlibsk_textblob.}
proc sk_textblob_get_bounds*(blob: ptr sk_textblob_t; bounds: ptr sk_rect_t) {.cdecl,
    importc: "sk_textblob_get_bounds", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_new*(): ptr sk_textblob_builder_t {.cdecl,
    importc: "sk_textblob_builder_new", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_delete*(builder: ptr sk_textblob_builder_t) {.cdecl,
    importc: "sk_textblob_builder_delete", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_make*(builder: ptr sk_textblob_builder_t): ptr sk_textblob_t {.
    cdecl, importc: "sk_textblob_builder_make", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_alloc_run_text*(builder: ptr sk_textblob_builder_t;
                                        font: ptr sk_paint_t; count: cint; x: cfloat;
                                        y: cfloat; textByteCount: cint;
                                        lang: ptr sk_string_t;
                                        bounds: ptr sk_rect_t; runbuffer: ptr sk_textblob_builder_runbuffer_t) {.
    cdecl, importc: "sk_textblob_builder_alloc_run_text", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_alloc_run_text_pos_h*(
    builder: ptr sk_textblob_builder_t; font: ptr sk_paint_t; count: cint; y: cfloat;
    textByteCount: cint; lang: ptr sk_string_t; bounds: ptr sk_rect_t;
    runbuffer: ptr sk_textblob_builder_runbuffer_t) {.cdecl,
    importc: "sk_textblob_builder_alloc_run_text_pos_h", dynlib: dynlibsk_textblob.}
proc sk_textblob_builder_alloc_run_text_pos*(builder: ptr sk_textblob_builder_t;
    font: ptr sk_paint_t; count: cint; textByteCount: cint; lang: ptr sk_string_t;
    bounds: ptr sk_rect_t; runbuffer: ptr sk_textblob_builder_runbuffer_t) {.cdecl,
    importc: "sk_textblob_builder_alloc_run_text_pos", dynlib: dynlibsk_textblob.}