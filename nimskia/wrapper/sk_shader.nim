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
type
  sk_shader_tilemode_t* {.size: sizeof(cint).} = enum
    CLAMP_SK_SHADER_TILEMODE, REPEAT_SK_SHADER_TILEMODE, MIRROR_SK_SHADER_TILEMODE


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
                                  localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_sweep_gradient", dynlib: dynlibsk_shader.}
proc sk_shader_new_two_point_conical_gradient*(start: ptr sk_point_t;
    startRadius: cfloat; `end`: ptr sk_point_t; endRadius: cfloat;
    colors: ptr sk_color_t; colorPos: ptr cfloat; colorCount: cint;
    tileMode: sk_shader_tilemode_t; localMatrix: ptr sk_matrix_t): ptr sk_shader_t {.
    cdecl, importc: "sk_shader_new_two_point_conical_gradient",
    dynlib: dynlibsk_shader.}