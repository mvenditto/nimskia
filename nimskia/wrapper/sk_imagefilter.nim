when defined(Linux):
  const dynlibsk_imagefilter = "libskia.so"
when defined(Windows):
  const dynlibsk_imagefilter = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_imagefilter_croprect_new*(): ptr sk_imagefilter_croprect_t {.cdecl,
    importc: "sk_imagefilter_croprect_new", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_croprect_new_with_rect*(rect: ptr sk_rect_t; flags: uint32): ptr sk_imagefilter_croprect_t {.
    cdecl, importc: "sk_imagefilter_croprect_new_with_rect",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_croprect_destructor*(cropRect: ptr sk_imagefilter_croprect_t) {.
    cdecl, importc: "sk_imagefilter_croprect_destructor",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_croprect_get_rect*(cropRect: ptr sk_imagefilter_croprect_t;
                                      rect: ptr sk_rect_t) {.cdecl,
    importc: "sk_imagefilter_croprect_get_rect", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_croprect_get_flags*(cropRect: ptr sk_imagefilter_croprect_t): uint32 {.
    cdecl, importc: "sk_imagefilter_croprect_get_flags",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_unref*(a1: ptr sk_imagefilter_t) {.cdecl,
    importc: "sk_imagefilter_unref", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_matrix*(matrix: ptr sk_matrix_t;
                               quality: sk_filter_quality_t;
                               input: ptr sk_imagefilter_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_matrix", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_alpha_threshold*(region: ptr sk_region_t;
                                        innerThreshold: cfloat;
                                        outerThreshold: cfloat;
                                        input: ptr sk_imagefilter_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_alpha_threshold",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_blur*(sigmaX: cfloat; sigmaY: cfloat;
                             input: ptr sk_imagefilter_t;
                             cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_blur", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_color_filter*(cf: ptr sk_colorfilter_t;
                                     input: ptr sk_imagefilter_t;
                                     cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_color_filter", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_compose*(outer: ptr sk_imagefilter_t;
                                inner: ptr sk_imagefilter_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_compose", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_displacement_map_effect*(
    xChannelSelector: sk_displacement_map_effect_channel_selector_type_t;
    yChannelSelector: sk_displacement_map_effect_channel_selector_type_t;
    scale: cfloat; displacement: ptr sk_imagefilter_t; color: ptr sk_imagefilter_t;
    cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.cdecl,
    importc: "sk_imagefilter_new_displacement_map_effect",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_drop_shadow*(dx: cfloat; dy: cfloat; sigmaX: cfloat;
                                    sigmaY: cfloat; color: sk_color_t; shadowMode: sk_drop_shadow_image_filter_shadow_mode_t;
                                    input: ptr sk_imagefilter_t;
                                    cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_drop_shadow", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_distant_lit_diffuse*(direction: ptr sk_point3_t;
    lightColor: sk_color_t; surfaceScale: cfloat; kd: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_distant_lit_diffuse",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_point_lit_diffuse*(location: ptr sk_point3_t;
    lightColor: sk_color_t; surfaceScale: cfloat; kd: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_point_lit_diffuse",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_spot_lit_diffuse*(location: ptr sk_point3_t;
    target: ptr sk_point3_t; specularExponent: cfloat; cutoffAngle: cfloat;
    lightColor: sk_color_t; surfaceScale: cfloat; kd: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_spot_lit_diffuse",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_distant_lit_specular*(direction: ptr sk_point3_t;
    lightColor: sk_color_t; surfaceScale: cfloat; ks: cfloat; shininess: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_distant_lit_specular",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_point_lit_specular*(location: ptr sk_point3_t;
    lightColor: sk_color_t; surfaceScale: cfloat; ks: cfloat; shininess: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_point_lit_specular",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_spot_lit_specular*(location: ptr sk_point3_t;
    target: ptr sk_point3_t; specularExponent: cfloat; cutoffAngle: cfloat;
    lightColor: sk_color_t; surfaceScale: cfloat; ks: cfloat; shininess: cfloat;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_spot_lit_specular",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_magnifier*(src: ptr sk_rect_t; inset: cfloat;
                                  input: ptr sk_imagefilter_t;
                                  cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_magnifier", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_matrix_convolution*(kernelSize: ptr sk_isize_t;
    kernel: ptr cfloat; gain: cfloat; bias: cfloat; kernelOffset: ptr sk_ipoint_t;
    tileMode: sk_matrix_convolution_tilemode_t; convolveAlpha: bool;
    input: ptr sk_imagefilter_t; cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_matrix_convolution",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_merge*(filters: ptr ptr sk_imagefilter_t; count: cint;
                              cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_merge", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_dilate*(radiusX: cint; radiusY: cint;
                               input: ptr sk_imagefilter_t;
                               cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_dilate", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_erode*(radiusX: cint; radiusY: cint;
                              input: ptr sk_imagefilter_t;
                              cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_erode", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_offset*(dx: cfloat; dy: cfloat; input: ptr sk_imagefilter_t;
                               cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_offset", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_picture*(picture: ptr sk_picture_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_picture", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_picture_with_croprect*(picture: ptr sk_picture_t;
    cropRect: ptr sk_rect_t): ptr sk_imagefilter_t {.cdecl,
    importc: "sk_imagefilter_new_picture_with_croprect",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_tile*(src: ptr sk_rect_t; dst: ptr sk_rect_t;
                             input: ptr sk_imagefilter_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_tile", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_xfermode*(mode: sk_blendmode_t;
                                 background: ptr sk_imagefilter_t;
                                 foreground: ptr sk_imagefilter_t;
                                 cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_xfermode", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_arithmetic*(k1: cfloat; k2: cfloat; k3: cfloat; k4: cfloat;
                                   enforcePMColor: bool;
                                   background: ptr sk_imagefilter_t;
                                   foreground: ptr sk_imagefilter_t;
                                   cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_arithmetic", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_image_source*(image: ptr sk_image_t; srcRect: ptr sk_rect_t;
                                     dstRect: ptr sk_rect_t;
                                     filterQuality: sk_filter_quality_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_image_source", dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_image_source_default*(image: ptr sk_image_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_image_source_default",
    dynlib: dynlibsk_imagefilter.}
proc sk_imagefilter_new_paint*(paint: ptr sk_paint_t;
                              cropRect: ptr sk_imagefilter_croprect_t): ptr sk_imagefilter_t {.
    cdecl, importc: "sk_imagefilter_new_paint", dynlib: dynlibsk_imagefilter.}