when defined(Linux):
  const dynlibsk_shader = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_shader_ref*(a1: ptr sk_shader_t) {.cdecl, importc: "sk_shader_ref",
                                       dynlib: dynlibsk_shader.}
proc sk_shader_unref*(a1: ptr sk_shader_t) {.cdecl, importc: "sk_shader_unref",
    dynlib: dynlibsk_shader.}
proc sk_shader_new_linear_gradient*(points: array[2, sk_point_t];
                                   colors: ptr sk_color_t; colorPos: ptr cfloat;
                                   colorCount: cint;
                                   tileMode: sk_shader_tilemode_t;
                                   localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_linear_gradient", dynlib: dynlibsk_shader.}
proc sk_shader_new_radial_gradient*(center: ptr sk_point_t; radius: cfloat;
                                   colors: ptr sk_color_t; colorPos: ptr cfloat;
                                   colorCount: cint;
                                   tileMode: sk_shader_tilemode_t;
                                   localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_radial_gradient", dynlib: dynlibsk_shader.}
proc sk_shader_new_sweep_gradient*(center: ptr sk_point_t; colors: ptr sk_color_t;
                                  colorPos: ptr cfloat; colorCount: cint;
                                  tileMode: sk_shader_tilemode_t;
                                  startAngle: cfloat; endAngle: cfloat;
                                  localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_sweep_gradient", dynlib: dynlibsk_shader.}
proc sk_shader_new_two_point_conical_gradient*(start: ptr sk_point_t;
    startRadius: cfloat; `end`: ptr sk_point_t; endRadius: cfloat;
    colors: ptr sk_color_t; colorPos: ptr cfloat; colorCount: cint;
    tileMode: sk_shader_tilemode_t; localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_two_point_conical_gradient",
    dynlib: dynlibsk_shader.}
proc sk_shader_new_empty*(): ptr sk_shader_t {.cdecl, importc: "sk_shader_new_empty",
    dynlib: dynlibsk_shader.}
proc sk_shader_new_color*(color: sk_color_t): ptr sk_shader_t {.cdecl,
    importc: "sk_shader_new_color", dynlib: dynlibsk_shader.}
proc sk_shader_new_bitmap*(src: ptr sk_bitmap_t; tmx: sk_shader_tilemode_t;
                          tmy: sk_shader_tilemode_t; localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_bitmap", dynlib: dynlibsk_shader.}
proc sk_shader_new_picture*(src: ptr sk_picture_t; tmx: sk_shader_tilemode_t;
                           tmy: sk_shader_tilemode_t;
                           localMatrix: ptr sk_matrix_t; tile: ptr sk_rect_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_picture", dynlib: dynlibsk_shader.}
proc sk_shader_new_local_matrix*(proxy: ptr sk_shader_t;
                                localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_local_matrix", dynlib: dynlibsk_shader.}
proc sk_shader_new_color_filter*(proxy: ptr sk_shader_t;
                                filter: ptr sk_colorfilter_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_color_filter", dynlib: dynlibsk_shader.}
proc sk_shader_new_perlin_noise_fractal_noise*(baseFrequencyX: cfloat;
    baseFrequencyY: cfloat; numOctaves: cint; seed: cfloat; tileSize: ptr sk_isize_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_perlin_noise_fractal_noise",
    dynlib: dynlibsk_shader.}
proc sk_shader_new_perlin_noise_turbulence*(baseFrequencyX: cfloat;
    baseFrequencyY: cfloat; numOctaves: cint; seed: cfloat; tileSize: ptr sk_isize_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_perlin_noise_turbulence",
    dynlib: dynlibsk_shader.}
proc sk_shader_new_compose*(shaderA: ptr sk_shader_t; shaderB: ptr sk_shader_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_compose", dynlib: dynlibsk_shader.}
proc sk_shader_new_compose_with_mode*(shaderA: ptr sk_shader_t;
                                     shaderB: ptr sk_shader_t; mode: sk_blendmode_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_compose_with_mode", dynlib: dynlibsk_shader.}