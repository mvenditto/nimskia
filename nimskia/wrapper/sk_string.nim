when defined(Linux):
  const dynlibsk_string = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_string_new_empty*(): ptr sk_string_t {.cdecl, importc: "sk_string_new_empty",
    dynlib: dynlibsk_string.}
proc sk_string_new_with_copy*(src: cstring; length: csize): ptr sk_string_t {.cdecl,
    importc: "sk_string_new_with_copy", dynlib: dynlibsk_string.}
proc sk_string_destructor*(a1: ptr sk_string_t) {.cdecl,
    importc: "sk_string_destructor", dynlib: dynlibsk_string.}
proc sk_string_get_size*(a1: ptr sk_string_t): csize {.cdecl,
    importc: "sk_string_get_size", dynlib: dynlibsk_string.}
proc sk_string_get_c_str*(a1: ptr sk_string_t): cstring {.cdecl,
    importc: "sk_string_get_c_str", dynlib: dynlibsk_string.}