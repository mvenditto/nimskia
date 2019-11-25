when defined(Linux):
  const dynlibsk_patheffect = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_path_effect_unref*(t: ptr sk_path_effect_t) {.cdecl,
    importc: "sk_path_effect_unref", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_compose*(outer: ptr sk_path_effect_t;
                                   inner: ptr sk_path_effect_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_compose", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_sum*(first: ptr sk_path_effect_t;
                               second: ptr sk_path_effect_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_sum", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_discrete*(segLength: cfloat; deviation: cfloat;
                                    seedAssist: uint32): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_discrete", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_corner*(radius: cfloat): ptr sk_path_effect_t {.cdecl,
    importc: "sk_path_effect_create_corner", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_1d_path*(path: ptr sk_path_t; advance: cfloat;
                                   phase: cfloat; style: sk_path_effect_1d_style_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_1d_path", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_2d_line*(width: cfloat; matrix: ptr sk_matrix_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_2d_line", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_2d_path*(matrix: ptr sk_matrix_t; path: ptr sk_path_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_2d_path", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_dash*(intervals: ptr cfloat; count: cint; phase: cfloat): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_dash", dynlib: dynlibsk_patheffect.}
proc sk_path_effect_create_trim*(start: cfloat; stop: cfloat;
                                mode: sk_path_effect_trim_mode_t): ptr sk_path_effect_t {.
    cdecl, importc: "sk_path_effect_create_trim", dynlib: dynlibsk_patheffect.}