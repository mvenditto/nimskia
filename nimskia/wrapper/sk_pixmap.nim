when defined(Linux):
  const dynlibsk_pixmap = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_pixmap_destructor*(cpixmap: ptr sk_pixmap_t) {.cdecl,
    importc: "sk_pixmap_destructor", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_new*(): ptr sk_pixmap_t {.cdecl, importc: "sk_pixmap_new",
                                     dynlib: dynlibsk_pixmap.}
proc sk_pixmap_new_with_params*(cinfo: ptr sk_imageinfo_t; `addr`: pointer;
                               rowBytes: csize): ptr sk_pixmap_t {.cdecl,
    importc: "sk_pixmap_new_with_params", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_reset*(cpixmap: ptr sk_pixmap_t) {.cdecl, importc: "sk_pixmap_reset",
    dynlib: dynlibsk_pixmap.}
proc sk_pixmap_reset_with_params*(cpixmap: ptr sk_pixmap_t;
                                 cinfo: ptr sk_imageinfo_t; `addr`: pointer;
                                 rowBytes: csize) {.cdecl,
    importc: "sk_pixmap_reset_with_params", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_get_info*(cpixmap: ptr sk_pixmap_t; cinfo: ptr sk_imageinfo_t) {.cdecl,
    importc: "sk_pixmap_get_info", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_get_row_bytes*(cpixmap: ptr sk_pixmap_t): csize {.cdecl,
    importc: "sk_pixmap_get_row_bytes", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_get_pixels*(cpixmap: ptr sk_pixmap_t): pointer {.cdecl,
    importc: "sk_pixmap_get_pixels", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_get_pixels_with_xy*(cpixmap: ptr sk_pixmap_t; x: cint; y: cint): pointer {.
    cdecl, importc: "sk_pixmap_get_pixels_with_xy", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_get_pixel_color*(cpixmap: ptr sk_pixmap_t; x: cint; y: cint): sk_color_t {.
    cdecl, importc: "sk_pixmap_get_pixel_color", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_encode_image*(dst: ptr sk_wstream_t; src: ptr sk_pixmap_t;
                            encoder: sk_encoded_image_format_t; quality: cint): bool {.
    cdecl, importc: "sk_pixmap_encode_image", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_read_pixels*(cpixmap: ptr sk_pixmap_t; dstInfo: ptr sk_imageinfo_t;
                           dstPixels: pointer; dstRowBytes: csize; srcX: cint;
                           srcY: cint; behavior: sk_transfer_function_behavior_t): bool {.
    cdecl, importc: "sk_pixmap_read_pixels", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_scale_pixels*(cpixmap: ptr sk_pixmap_t; dst: ptr sk_pixmap_t;
                            quality: sk_filter_quality_t): bool {.cdecl,
    importc: "sk_pixmap_scale_pixels", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_extract_subset*(cpixmap: ptr sk_pixmap_t; result: ptr sk_pixmap_t;
                              subset: ptr sk_irect_t): bool {.cdecl,
    importc: "sk_pixmap_extract_subset", dynlib: dynlibsk_pixmap.}
proc sk_pixmap_erase_color*(cpixmap: ptr sk_pixmap_t; color: sk_color_t;
                           subset: ptr sk_irect_t): bool {.cdecl,
    importc: "sk_pixmap_erase_color", dynlib: dynlibsk_pixmap.}
proc sk_color_unpremultiply*(pmcolor: sk_pmcolor_t): sk_color_t {.cdecl,
    importc: "sk_color_unpremultiply", dynlib: dynlibsk_pixmap.}
proc sk_color_premultiply*(color: sk_color_t): sk_pmcolor_t {.cdecl,
    importc: "sk_color_premultiply", dynlib: dynlibsk_pixmap.}
proc sk_color_unpremultiply_array*(pmcolors: ptr sk_pmcolor_t; size: cint;
                                  colors: ptr sk_color_t) {.cdecl,
    importc: "sk_color_unpremultiply_array", dynlib: dynlibsk_pixmap.}
proc sk_color_premultiply_array*(colors: ptr sk_color_t; size: cint;
                                pmcolors: ptr sk_pmcolor_t) {.cdecl,
    importc: "sk_color_premultiply_array", dynlib: dynlibsk_pixmap.}
proc sk_color_get_bit_shift*(a: ptr cint; r: ptr cint; g: ptr cint; b: ptr cint) {.cdecl,
    importc: "sk_color_get_bit_shift", dynlib: dynlibsk_pixmap.}
proc sk_swizzle_swap_rb*(dest: ptr uint32; src: ptr uint32; count: cint) {.cdecl,
    importc: "sk_swizzle_swap_rb", dynlib: dynlibsk_pixmap.}
proc sk_webpencoder_encode*(dst: ptr sk_wstream_t; src: ptr sk_pixmap_t;
                           options: sk_webpencoder_options_t): bool {.cdecl,
    importc: "sk_webpencoder_encode", dynlib: dynlibsk_pixmap.}
proc sk_jpegencoder_encode*(dst: ptr sk_wstream_t; src: ptr sk_pixmap_t;
                           options: sk_jpegencoder_options_t): bool {.cdecl,
    importc: "sk_jpegencoder_encode", dynlib: dynlibsk_pixmap.}
proc sk_pngencoder_encode*(dst: ptr sk_wstream_t; src: ptr sk_pixmap_t;
                          options: sk_pngencoder_options_t): bool {.cdecl,
    importc: "sk_pngencoder_encode", dynlib: dynlibsk_pixmap.}