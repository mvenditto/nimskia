when defined(Linux):
  const dynlibsk_region = "libskia.so"
when defined(Windows):
  const dynlibsk_region = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_region_new*(): ptr sk_region_t {.cdecl, importc: "sk_region_new",
                                     dynlib: dynlibsk_region.}
proc sk_region_new2*(region: ptr sk_region_t): ptr sk_region_t {.cdecl,
    importc: "sk_region_new2", dynlib: dynlibsk_region.}
proc sk_region_delete*(cpath: ptr sk_region_t) {.cdecl, importc: "sk_region_delete",
    dynlib: dynlibsk_region.}
proc sk_region_contains*(r: ptr sk_region_t; region: ptr sk_region_t): bool {.cdecl,
    importc: "sk_region_contains", dynlib: dynlibsk_region.}
proc sk_region_contains2*(r: ptr sk_region_t; x: cint; y: cint): bool {.cdecl,
    importc: "sk_region_contains2", dynlib: dynlibsk_region.}
proc sk_region_intersects_rect*(r: ptr sk_region_t; rect: ptr sk_irect_t): bool {.cdecl,
    importc: "sk_region_intersects_rect", dynlib: dynlibsk_region.}
proc sk_region_intersects*(r: ptr sk_region_t; src: ptr sk_region_t): bool {.cdecl,
    importc: "sk_region_intersects", dynlib: dynlibsk_region.}
proc sk_region_set_path*(dst: ptr sk_region_t; t: ptr sk_path_t; clip: ptr sk_region_t): bool {.
    cdecl, importc: "sk_region_set_path", dynlib: dynlibsk_region.}
proc sk_region_set_rect*(dst: ptr sk_region_t; rect: ptr sk_irect_t): bool {.cdecl,
    importc: "sk_region_set_rect", dynlib: dynlibsk_region.}
proc sk_region_set_region*(r: ptr sk_region_t; region: ptr sk_region_t): bool {.cdecl,
    importc: "sk_region_set_region", dynlib: dynlibsk_region.}
proc sk_region_op*(dst: ptr sk_region_t; left: cint; top: cint; right: cint; bottom: cint;
                  op: sk_region_op_t): bool {.cdecl, importc: "sk_region_op",
    dynlib: dynlibsk_region.}
proc sk_region_op2*(dst: ptr sk_region_t; src: ptr sk_region_t; op: sk_region_op_t): bool {.
    cdecl, importc: "sk_region_op2", dynlib: dynlibsk_region.}
proc sk_region_get_bounds*(r: ptr sk_region_t; rect: ptr sk_irect_t) {.cdecl,
    importc: "sk_region_get_bounds", dynlib: dynlibsk_region.}