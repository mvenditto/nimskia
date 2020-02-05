when defined(Linux):
  const dynlibsk_surface = "libskia.so"
when defined(Windows):
  const dynlibsk_surface = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_surface_new_null*(width: cint; height: cint): ptr sk_surface_t {.cdecl,
    importc: "sk_surface_new_null", dynlib: dynlibsk_surface.}
proc sk_surface_new_raster*(a1: ptr sk_imageinfo_t; rowBytes: csize;
                           a3: ptr sk_surfaceprops_t): ptr sk_surface_t {.cdecl,
    importc: "sk_surface_new_raster", dynlib: dynlibsk_surface.}
proc sk_surface_new_raster_direct*(a1: ptr sk_imageinfo_t; pixels: pointer;
                                  rowBytes: csize;
                                  releaseProc: sk_surface_raster_release_proc;
                                  context: pointer; props: ptr sk_surfaceprops_t): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_raster_direct", dynlib: dynlibsk_surface.}
proc sk_surface_new_backend_texture*(context: ptr gr_context_t;
                                    texture: ptr gr_backendtexture_t;
                                    origin: gr_surfaceorigin_t; samples: cint;
                                    colorType: sk_colortype_t;
                                    colorspace: ptr sk_colorspace_t;
                                    props: ptr sk_surfaceprops_t): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_backend_texture", dynlib: dynlibsk_surface.}
proc sk_surface_new_backend_render_target*(context: ptr gr_context_t;
    target: ptr gr_backendrendertarget_t; origin: gr_surfaceorigin_t;
    colorType: sk_colortype_t; colorspace: ptr sk_colorspace_t;
    props: ptr sk_surfaceprops_t): ptr sk_surface_t {.cdecl,
    importc: "sk_surface_new_backend_render_target", dynlib: dynlibsk_surface.}
proc sk_surface_new_backend_texture_as_render_target*(context: ptr gr_context_t;
    texture: ptr gr_backendtexture_t; origin: gr_surfaceorigin_t; samples: cint;
    colorType: sk_colortype_t; colorspace: ptr sk_colorspace_t;
    props: ptr sk_surfaceprops_t): ptr sk_surface_t {.cdecl,
    importc: "sk_surface_new_backend_texture_as_render_target",
    dynlib: dynlibsk_surface.}
proc sk_surface_new_render_target*(context: ptr gr_context_t; budgeted: bool;
                                  cinfo: ptr sk_imageinfo_t; sampleCount: cint;
                                  origin: gr_surfaceorigin_t;
                                  props: ptr sk_surfaceprops_t;
                                  shouldCreateWithMips: bool): ptr sk_surface_t {.
    cdecl, importc: "sk_surface_new_render_target", dynlib: dynlibsk_surface.}
proc sk_surface_unref*(a1: ptr sk_surface_t) {.cdecl, importc: "sk_surface_unref",
    dynlib: dynlibsk_surface.}
proc sk_surface_get_canvas*(a1: ptr sk_surface_t): ptr sk_canvas_t {.cdecl,
    importc: "sk_surface_get_canvas", dynlib: dynlibsk_surface.}
proc sk_surface_new_image_snapshot*(a1: ptr sk_surface_t): ptr sk_image_t {.cdecl,
    importc: "sk_surface_new_image_snapshot", dynlib: dynlibsk_surface.}
proc sk_surface_draw*(surface: ptr sk_surface_t; canvas: ptr sk_canvas_t; x: cfloat;
                     y: cfloat; paint: ptr sk_paint_t) {.cdecl,
    importc: "sk_surface_draw", dynlib: dynlibsk_surface.}
proc sk_surface_peek_pixels*(surface: ptr sk_surface_t; pixmap: ptr sk_pixmap_t): bool {.
    cdecl, importc: "sk_surface_peek_pixels", dynlib: dynlibsk_surface.}
proc sk_surface_read_pixels*(surface: ptr sk_surface_t; dstInfo: ptr sk_imageinfo_t;
                            dstPixels: pointer; dstRowBytes: csize; srcX: cint;
                            srcY: cint): bool {.cdecl,
    importc: "sk_surface_read_pixels", dynlib: dynlibsk_surface.}
proc sk_surface_get_props*(surface: ptr sk_surface_t): ptr sk_surfaceprops_t {.cdecl,
    importc: "sk_surface_get_props", dynlib: dynlibsk_surface.}
proc sk_surfaceprops_new*(flags: uint32; geometry: sk_pixelgeometry_t): ptr sk_surfaceprops_t {.
    cdecl, importc: "sk_surfaceprops_new", dynlib: dynlibsk_surface.}
proc sk_surfaceprops_delete*(props: ptr sk_surfaceprops_t) {.cdecl,
    importc: "sk_surfaceprops_delete", dynlib: dynlibsk_surface.}
proc sk_surfaceprops_get_flags*(props: ptr sk_surfaceprops_t): uint32 {.cdecl,
    importc: "sk_surfaceprops_get_flags", dynlib: dynlibsk_surface.}
proc sk_surfaceprops_get_pixel_geometry*(props: ptr sk_surfaceprops_t): sk_pixelgeometry_t {.
    cdecl, importc: "sk_surfaceprops_get_pixel_geometry", dynlib: dynlibsk_surface.}