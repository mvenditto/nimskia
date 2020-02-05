when defined(Linux):
  const dynlibsk_colorfilter = "libskia.so"
when defined(Windows):
  const dynlibsk_colorfilter = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_colorfilter_unref*(filter: ptr sk_colorfilter_t) {.cdecl,
    importc: "sk_colorfilter_unref", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_mode*(c: sk_color_t; mode: sk_blendmode_t): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_mode", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_lighting*(mul: sk_color_t; add: sk_color_t): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_lighting", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_compose*(outer: ptr sk_colorfilter_t;
                                inner: ptr sk_colorfilter_t): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_compose", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_color_matrix*(array: array[20, cfloat]): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_color_matrix", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_luma_color*(): ptr sk_colorfilter_t {.cdecl,
    importc: "sk_colorfilter_new_luma_color", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_high_contrast*(config: ptr sk_highcontrastconfig_t): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_high_contrast",
    dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_table*(table: array[256, uint8]): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_table", dynlib: dynlibsk_colorfilter.}
proc sk_colorfilter_new_table_argb*(tableA: array[256, uint8];
                                   tableR: array[256, uint8];
                                   tableG: array[256, uint8];
                                   tableB: array[256, uint8]): ptr sk_colorfilter_t {.
    cdecl, importc: "sk_colorfilter_new_table_argb", dynlib: dynlibsk_colorfilter.}