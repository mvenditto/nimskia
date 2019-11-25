when defined(Linux):
  const dynlibsk_image = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_image_new_raster_copy*(a1: ptr sk_imageinfo_t; pixels: pointer;
                              rowBytes: csize): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_raster_copy", dynlib: dynlibsk_image.}
proc sk_image_new_raster_copy_with_pixmap*(pixmap: ptr sk_pixmap_t): ptr sk_image_t {.
    cdecl, importc: "sk_image_new_raster_copy_with_pixmap", dynlib: dynlibsk_image.}
proc sk_image_new_raster_data*(cinfo: ptr sk_imageinfo_t; pixels: ptr sk_data_t;
                              rowBytes: csize): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_raster_data", dynlib: dynlibsk_image.}
proc sk_image_new_raster*(pixmap: ptr sk_pixmap_t;
                         releaseProc: sk_image_raster_release_proc;
                         context: pointer): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_raster", dynlib: dynlibsk_image.}
proc sk_image_new_from_bitmap*(cbitmap: ptr sk_bitmap_t): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_from_bitmap", dynlib: dynlibsk_image.}
proc sk_image_new_from_encoded*(encoded: ptr sk_data_t; subset: ptr sk_irect_t): ptr sk_image_t {.
    cdecl, importc: "sk_image_new_from_encoded", dynlib: dynlibsk_image.}
proc sk_image_new_from_texture*(context: ptr gr_context_t;
                               texture: ptr gr_backendtexture_t;
                               origin: gr_surfaceorigin_t;
                               colorType: sk_colortype_t; alpha: sk_alphatype_t;
                               colorSpace: ptr sk_colorspace_t;
                               releaseProc: sk_image_texture_release_proc;
                               releaseContext: pointer): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_from_texture", dynlib: dynlibsk_image.}
proc sk_image_new_from_adopted_texture*(context: ptr gr_context_t;
                                       texture: ptr gr_backendtexture_t;
                                       origin: gr_surfaceorigin_t;
                                       colorType: sk_colortype_t;
                                       alpha: sk_alphatype_t;
                                       colorSpace: ptr sk_colorspace_t): ptr sk_image_t {.
    cdecl, importc: "sk_image_new_from_adopted_texture", dynlib: dynlibsk_image.}
proc sk_image_new_from_picture*(picture: ptr sk_picture_t;
                               dimensions: ptr sk_isize_t; matrix: ptr sk_matrix_t;
                               paint: ptr sk_paint_t): ptr sk_image_t {.cdecl,
    importc: "sk_image_new_from_picture", dynlib: dynlibsk_image.}
proc sk_image_make_subset*(cimage: ptr sk_image_t; subset: ptr sk_irect_t): ptr sk_image_t {.
    cdecl, importc: "sk_image_make_subset", dynlib: dynlibsk_image.}
proc sk_image_make_non_texture_image*(cimage: ptr sk_image_t): ptr sk_image_t {.cdecl,
    importc: "sk_image_make_non_texture_image", dynlib: dynlibsk_image.}
proc sk_image_make_with_filter*(cimage: ptr sk_image_t;
                               filter: ptr sk_imagefilter_t;
                               subset: ptr sk_irect_t; clipBounds: ptr sk_irect_t;
                               outSubset: ptr sk_irect_t;
                               outOffset: ptr sk_ipoint_t): ptr sk_image_t {.cdecl,
    importc: "sk_image_make_with_filter", dynlib: dynlibsk_image.}
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
proc sk_image_get_alpha_type*(a1: ptr sk_image_t): sk_alphatype_t {.cdecl,
    importc: "sk_image_get_alpha_type", dynlib: dynlibsk_image.}
proc sk_image_get_color_type*(a1: ptr sk_image_t): sk_colortype_t {.cdecl,
    importc: "sk_image_get_color_type", dynlib: dynlibsk_image.}
proc sk_image_get_colorspace*(a1: ptr sk_image_t): ptr sk_colorspace_t {.cdecl,
    importc: "sk_image_get_colorspace", dynlib: dynlibsk_image.}
proc sk_image_is_alpha_only*(a1: ptr sk_image_t): bool {.cdecl,
    importc: "sk_image_is_alpha_only", dynlib: dynlibsk_image.}
proc sk_image_make_shader*(a1: ptr sk_image_t; tileX: sk_shader_tilemode_t;
                          tileY: sk_shader_tilemode_t;
                          localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.cdecl,
    importc: "sk_image_make_shader", dynlib: dynlibsk_image.}
proc sk_image_peek_pixels*(image: ptr sk_image_t; pixmap: ptr sk_pixmap_t): bool {.
    cdecl, importc: "sk_image_peek_pixels", dynlib: dynlibsk_image.}
proc sk_image_is_texture_backed*(image: ptr sk_image_t): bool {.cdecl,
    importc: "sk_image_is_texture_backed", dynlib: dynlibsk_image.}
proc sk_image_is_lazy_generated*(image: ptr sk_image_t): bool {.cdecl,
    importc: "sk_image_is_lazy_generated", dynlib: dynlibsk_image.}
proc sk_image_read_pixels*(image: ptr sk_image_t; dstInfo: ptr sk_imageinfo_t;
                          dstPixels: pointer; dstRowBytes: csize; srcX: cint;
                          srcY: cint; cachingHint: sk_image_caching_hint_t): bool {.
    cdecl, importc: "sk_image_read_pixels", dynlib: dynlibsk_image.}
proc sk_image_read_pixels_into_pixmap*(image: ptr sk_image_t; dst: ptr sk_pixmap_t;
                                      srcX: cint; srcY: cint;
                                      cachingHint: sk_image_caching_hint_t): bool {.
    cdecl, importc: "sk_image_read_pixels_into_pixmap", dynlib: dynlibsk_image.}
proc sk_image_scale_pixels*(image: ptr sk_image_t; dst: ptr sk_pixmap_t;
                           quality: sk_filter_quality_t;
                           cachingHint: sk_image_caching_hint_t): bool {.cdecl,
    importc: "sk_image_scale_pixels", dynlib: dynlibsk_image.}
proc sk_image_ref_encoded*(a1: ptr sk_image_t): ptr sk_data_t {.cdecl,
    importc: "sk_image_ref_encoded", dynlib: dynlibsk_image.}
proc sk_image_encode*(a1: ptr sk_image_t): ptr sk_data_t {.cdecl,
    importc: "sk_image_encode", dynlib: dynlibsk_image.}
proc sk_image_encode_specific*(cimage: ptr sk_image_t;
                              encoder: sk_encoded_image_format_t; quality: cint): ptr sk_data_t {.
    cdecl, importc: "sk_image_encode_specific", dynlib: dynlibsk_image.}