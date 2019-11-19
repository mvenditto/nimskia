when defined(Linux):
  const dynlibsk_image = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_image_new_raster_copy*(a1: ptr sk_imageinfo_t; pixels: pointer;
                              rowBytes: csize): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_raster_copy", dynlib: dynlibsk_image.}
proc sk_image_new_from_encoded*(encoded: ptr sk_data_t; subset: ptr sk_irect_t): ptr sk_image_t {.
    cdecl, importc: "sk_image_new_from_encoded", dynlib: dynlibsk_image.}
proc sk_image_encode*(a1: ptr sk_image_t): ptr sk_data_t {.cdecl,
    importc: "sk_image_encode", dynlib: dynlibsk_image.}
proc sk_image_ref*(a1: ptr sk_image_t) {.cdecl, importc: "sk_image_ref",
                                     dynlib: dynlibsk_image.}
proc sk_image_unref*(a1: ptr sk_image_t) {.cdecl, importc: "sk_image_unref",
                                       dynlib: dynlibsk_image.}
proc sk_image_get_width*(a1: ptr sk_image_t): cint {.cdecl,
    importc: "sk_image_get_width", dynlib: dynlibsk_image.}
proc sk_image_get_height*(a1: ptr sk_image_t): cint {.cdecl,
    importc: "sk_image_get_height", dynlib: dynlibsk_image.}
proc sk_image_get_unique_id*(a1: ptr sk_image_t): uint32 {.cdecl,
    importc: "sk_image_get_unique_id", dynlib: dynlibsk_image.}