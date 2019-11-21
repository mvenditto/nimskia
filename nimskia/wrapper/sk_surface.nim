when defined(Linux):
  const dynlibsk_surface = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_surface_new_raster*(a1: ptr sk_imageinfo_t; a2: ptr sk_surfaceprops_t): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_raster", dynlib: dynlibsk_surface.}
proc sk_surface_new_raster_direct*(a1: ptr sk_imageinfo_t; pixels: pointer;
                                  rowBytes: csize; props: ptr sk_surfaceprops_t): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_raster_direct", dynlib: dynlibsk_surface.}
proc sk_surface_unref*(a1: ptr sk_surface_t) {.cdecl, importc: "sk_surface_unref",
    dynlib: dynlibsk_surface.}
proc sk_surface_get_canvas*(a1: ptr sk_surface_t): ptr sk_canvas_t {.cdecl,
    importc: "sk_surface_get_canvas", dynlib: dynlibsk_surface.}
proc sk_surface_new_image_snapshot*(a1: ptr sk_surface_t): ptr sk_image_t {.cdecl,
    importc: "sk_surface_new_image_snapshot", dynlib: dynlibsk_surface.}