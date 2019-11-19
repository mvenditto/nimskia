when defined(Linux):
  const dynlibsk_gpu = "libskia.so"

import strutils
import sk_types
import sk_imageinfo
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_surface_new_from_backend_render_target*(dw: cint; dh: cint): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_from_backend_render_target",
    dynlib: dynlibsk_gpu.}
proc flush_gr_context*() {.cdecl, importc: "flush_gr_context", dynlib: dynlibsk_gpu.}