when defined(Linux):
  const dynlibsk_bitmap = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_bitmap_destructor*(cbitmap: ptr sk_bitmap_t) {.cdecl,
    importc: "sk_bitmap_destructor", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_new*(): ptr sk_bitmap_t {.cdecl, importc: "sk_bitmap_new",
                                     dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_info*(cbitmap: ptr sk_bitmap_t; info: ptr sk_imageinfo_t) {.cdecl,
    importc: "sk_bitmap_get_info", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_pixels*(cbitmap: ptr sk_bitmap_t; length: ptr csize): pointer {.
    cdecl, importc: "sk_bitmap_get_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_row_bytes*(cbitmap: ptr sk_bitmap_t): csize {.cdecl,
    importc: "sk_bitmap_get_row_bytes", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_byte_count*(cbitmap: ptr sk_bitmap_t): csize {.cdecl,
    importc: "sk_bitmap_get_byte_count", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_reset*(cbitmap: ptr sk_bitmap_t) {.cdecl, importc: "sk_bitmap_reset",
    dynlib: dynlibsk_bitmap.}
proc sk_bitmap_is_null*(cbitmap: ptr sk_bitmap_t): bool {.cdecl,
    importc: "sk_bitmap_is_null", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_is_immutable*(cbitmap: ptr sk_bitmap_t): bool {.cdecl,
    importc: "sk_bitmap_is_immutable", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_set_immutable*(cbitmap: ptr sk_bitmap_t) {.cdecl,
    importc: "sk_bitmap_set_immutable", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_is_volatile*(cbitmap: ptr sk_bitmap_t): bool {.cdecl,
    importc: "sk_bitmap_is_volatile", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_set_volatile*(cbitmap: ptr sk_bitmap_t; value: bool) {.cdecl,
    importc: "sk_bitmap_set_volatile", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_erase*(cbitmap: ptr sk_bitmap_t; color: sk_color_t) {.cdecl,
    importc: "sk_bitmap_erase", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_erase_rect*(cbitmap: ptr sk_bitmap_t; color: sk_color_t;
                          rect: ptr sk_irect_t) {.cdecl,
    importc: "sk_bitmap_erase_rect", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_addr_8*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint): uint8 {.cdecl,
    importc: "sk_bitmap_get_addr_8", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_addr_16*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint): uint16 {.
    cdecl, importc: "sk_bitmap_get_addr_16", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_addr_32*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint): uint32 {.
    cdecl, importc: "sk_bitmap_get_addr_32", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_addr*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint): pointer {.cdecl,
    importc: "sk_bitmap_get_addr", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_pixel_color*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint): sk_color_t {.
    cdecl, importc: "sk_bitmap_get_pixel_color", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_set_pixel_color*(cbitmap: ptr sk_bitmap_t; x: cint; y: cint;
                               color: sk_color_t) {.cdecl,
    importc: "sk_bitmap_set_pixel_color", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_ready_to_draw*(cbitmap: ptr sk_bitmap_t): bool {.cdecl,
    importc: "sk_bitmap_ready_to_draw", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_get_pixel_colors*(cbitmap: ptr sk_bitmap_t; colors: ptr sk_color_t) {.
    cdecl, importc: "sk_bitmap_get_pixel_colors", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_set_pixel_colors*(cbitmap: ptr sk_bitmap_t; colors: ptr sk_color_t) {.
    cdecl, importc: "sk_bitmap_set_pixel_colors", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_install_pixels*(cbitmap: ptr sk_bitmap_t; cinfo: ptr sk_imageinfo_t;
                              pixels: pointer; rowBytes: csize;
                              releaseProc: sk_bitmap_release_proc;
                              context: pointer): bool {.cdecl,
    importc: "sk_bitmap_install_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_install_pixels_with_pixmap*(cbitmap: ptr sk_bitmap_t;
    cpixmap: ptr sk_pixmap_t): bool {.cdecl, importc: "sk_bitmap_install_pixels_with_pixmap",
                                  dynlib: dynlibsk_bitmap.}
proc sk_bitmap_install_mask_pixels*(cbitmap: ptr sk_bitmap_t; cmask: ptr sk_mask_t): bool {.
    cdecl, importc: "sk_bitmap_install_mask_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_try_alloc_pixels*(cbitmap: ptr sk_bitmap_t;
                                requestedInfo: ptr sk_imageinfo_t; rowBytes: csize): bool {.
    cdecl, importc: "sk_bitmap_try_alloc_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_try_alloc_pixels_with_flags*(cbitmap: ptr sk_bitmap_t;
    requestedInfo: ptr sk_imageinfo_t; flags: uint32): bool {.cdecl,
    importc: "sk_bitmap_try_alloc_pixels_with_flags", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_set_pixels*(cbitmap: ptr sk_bitmap_t; pixels: pointer) {.cdecl,
    importc: "sk_bitmap_set_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_peek_pixels*(cbitmap: ptr sk_bitmap_t; cpixmap: ptr sk_pixmap_t): bool {.
    cdecl, importc: "sk_bitmap_peek_pixels", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_extract_subset*(cbitmap: ptr sk_bitmap_t; dst: ptr sk_bitmap_t;
                              subset: ptr sk_irect_t): bool {.cdecl,
    importc: "sk_bitmap_extract_subset", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_extract_alpha*(cbitmap: ptr sk_bitmap_t; dst: ptr sk_bitmap_t;
                             paint: ptr sk_paint_t; offset: ptr sk_ipoint_t): bool {.
    cdecl, importc: "sk_bitmap_extract_alpha", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_notify_pixels_changed*(cbitmap: ptr sk_bitmap_t) {.cdecl,
    importc: "sk_bitmap_notify_pixels_changed", dynlib: dynlibsk_bitmap.}
proc sk_bitmap_swap*(cbitmap: ptr sk_bitmap_t; cother: ptr sk_bitmap_t) {.cdecl,
    importc: "sk_bitmap_swap", dynlib: dynlibsk_bitmap.}