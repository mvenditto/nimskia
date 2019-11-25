when defined(Linux):
  const dynlibsk_general = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_refcnt_unique*(refcnt: ptr sk_refcnt_t): bool {.cdecl,
    importc: "sk_refcnt_unique", dynlib: dynlibsk_general.}
proc sk_refcnt_get_ref_count*(refcnt: ptr sk_refcnt_t): cint {.cdecl,
    importc: "sk_refcnt_get_ref_count", dynlib: dynlibsk_general.}
proc sk_refcnt_safe_ref*(refcnt: ptr sk_refcnt_t) {.cdecl,
    importc: "sk_refcnt_safe_ref", dynlib: dynlibsk_general.}
proc sk_refcnt_safe_unref*(refcnt: ptr sk_refcnt_t) {.cdecl,
    importc: "sk_refcnt_safe_unref", dynlib: dynlibsk_general.}
proc sk_nvrefcnt_unique*(refcnt: ptr sk_nvrefcnt_t): bool {.cdecl,
    importc: "sk_nvrefcnt_unique", dynlib: dynlibsk_general.}
proc sk_nvrefcnt_get_ref_count*(refcnt: ptr sk_nvrefcnt_t): cint {.cdecl,
    importc: "sk_nvrefcnt_get_ref_count", dynlib: dynlibsk_general.}
proc sk_nvrefcnt_safe_ref*(refcnt: ptr sk_nvrefcnt_t) {.cdecl,
    importc: "sk_nvrefcnt_safe_ref", dynlib: dynlibsk_general.}
proc sk_nvrefcnt_safe_unref*(refcnt: ptr sk_nvrefcnt_t) {.cdecl,
    importc: "sk_nvrefcnt_safe_unref", dynlib: dynlibsk_general.}
proc sk_colortype_get_default_8888*(): sk_colortype_t {.cdecl,
    importc: "sk_colortype_get_default_8888", dynlib: dynlibsk_general.}