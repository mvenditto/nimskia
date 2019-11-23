when defined(Linux):
  const dynlibsk_mask = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_mask_alloc_image*(bytes: csize): ptr uint8 {.cdecl,
    importc: "sk_mask_alloc_image", dynlib: dynlibsk_mask.}
proc sk_mask_free_image*(image: pointer) {.cdecl, importc: "sk_mask_free_image",
                                        dynlib: dynlibsk_mask.}
proc sk_mask_is_empty*(cmask: ptr sk_mask_t): bool {.cdecl,
    importc: "sk_mask_is_empty", dynlib: dynlibsk_mask.}
proc sk_mask_compute_image_size*(cmask: ptr sk_mask_t): csize {.cdecl,
    importc: "sk_mask_compute_image_size", dynlib: dynlibsk_mask.}
proc sk_mask_compute_total_image_size*(cmask: ptr sk_mask_t): csize {.cdecl,
    importc: "sk_mask_compute_total_image_size", dynlib: dynlibsk_mask.}
proc sk_mask_get_addr_1*(cmask: ptr sk_mask_t; x: cint; y: cint): uint8 {.cdecl,
    importc: "sk_mask_get_addr_1", dynlib: dynlibsk_mask.}
proc sk_mask_get_addr_8*(cmask: ptr sk_mask_t; x: cint; y: cint): uint8 {.cdecl,
    importc: "sk_mask_get_addr_8", dynlib: dynlibsk_mask.}
proc sk_mask_get_addr_lcd_16*(cmask: ptr sk_mask_t; x: cint; y: cint): uint16 {.cdecl,
    importc: "sk_mask_get_addr_lcd_16", dynlib: dynlibsk_mask.}
proc sk_mask_get_addr_32*(cmask: ptr sk_mask_t; x: cint; y: cint): uint32 {.cdecl,
    importc: "sk_mask_get_addr_32", dynlib: dynlibsk_mask.}
proc sk_mask_get_addr*(cmask: ptr sk_mask_t; x: cint; y: cint): pointer {.cdecl,
    importc: "sk_mask_get_addr", dynlib: dynlibsk_mask.}