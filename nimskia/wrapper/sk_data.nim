when defined(Linux):
  const dynlibsk_data = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_data_new_empty*(): ptr sk_data_t {.cdecl, importc: "sk_data_new_empty",
                                       dynlib: dynlibsk_data.}
proc sk_data_new_with_copy*(src: pointer; length: csize): ptr sk_data_t {.cdecl,
    importc: "sk_data_new_with_copy", dynlib: dynlibsk_data.}
proc sk_data_new_subset*(src: ptr sk_data_t; offset: csize; length: csize): ptr sk_data_t {.
    cdecl, importc: "sk_data_new_subset", dynlib: dynlibsk_data.}
proc sk_data_ref*(a1: ptr sk_data_t) {.cdecl, importc: "sk_data_ref",
                                   dynlib: dynlibsk_data.}
proc sk_data_unref*(a1: ptr sk_data_t) {.cdecl, importc: "sk_data_unref",
                                     dynlib: dynlibsk_data.}
proc sk_data_get_size*(a1: ptr sk_data_t): csize {.cdecl, importc: "sk_data_get_size",
    dynlib: dynlibsk_data.}
proc sk_data_get_data*(a1: ptr sk_data_t): pointer {.cdecl,
    importc: "sk_data_get_data", dynlib: dynlibsk_data.}
proc sk_data_new_from_file*(path: cstring): ptr sk_data_t {.cdecl,
    importc: "sk_data_new_from_file", dynlib: dynlibsk_data.}
proc sk_data_new_from_stream*(stream: ptr sk_stream_t; length: csize): ptr sk_data_t {.
    cdecl, importc: "sk_data_new_from_stream", dynlib: dynlibsk_data.}
proc sk_data_get_bytes*(a1: ptr sk_data_t): ptr uint8 {.cdecl,
    importc: "sk_data_get_bytes", dynlib: dynlibsk_data.}
proc sk_data_new_with_proc*(`ptr`: pointer; length: csize;
                           `proc`: sk_data_release_proc; ctx: pointer): ptr sk_data_t {.
    cdecl, importc: "sk_data_new_with_proc", dynlib: dynlibsk_data.}
proc sk_data_new_uninitialized*(size: csize): ptr sk_data_t {.cdecl,
    importc: "sk_data_new_uninitialized", dynlib: dynlibsk_data.}