when defined(Linux):
  const dynlibsk_types = "libskia.so"

import strutils
template sk_color_set_argb*(a, r, g, b: untyped): untyped =
  (((a) shl 24) or ((r) shl 16) or ((g) shl 8) or (b))

template sk_color_get_a*(c: untyped): untyped =
  (((c) shr 24) and 0x000000FF)

template sk_color_get_r*(c: untyped): untyped =
  (((c) shr 16) and 0x000000FF)

template sk_color_get_g*(c: untyped): untyped =
  (((c) shr 8) and 0x000000FF)

template sk_color_get_b*(c: untyped): untyped =
  (((c) shr 0) and 0x000000FF)\n
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
type
  sk_color_t* = uint32
  sk_cliptype_t* {.size: sizeof(cint).} = enum
    INTERSECT_SK_CLIPTYPE, DIFFERENCE_SK_CLIPTYPE
  sk_pixelgeometry_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_PIXELGEOMETRY, RGB_H_SK_PIXELGEOMETRY, BGR_H_SK_PIXELGEOMETRY,
    RGB_V_SK_PIXELGEOMETRY, BGR_V_SK_PIXELGEOMETRY
  sk_surfaceprops_t* {.bycopy.} = object
    pixelGeometry*: sk_pixelgeometry_t

  sk_point_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat

  sk_irect_t* {.bycopy.} = object
    left*: int32
    top*: int32
    right*: int32
    bottom*: int32

  sk_rect_t* {.bycopy.} = object
    left*: cfloat
    top*: cfloat
    right*: cfloat
    bottom*: cfloat

  sk_matrix_t* {.bycopy.} = object
    mat*: array[9, cfloat]




type
  sk_canvas_t* {.bycopy.} = object

  sk_data_t* {.bycopy.} = object

  sk_image_t* {.bycopy.} = object

  sk_colorspace_t* {.bycopy.} = object

  sk_imageinfo_t* {.bycopy.} = object

  sk_maskfilter_t* {.bycopy.} = object

  sk_paint_t* {.bycopy.} = object

  sk_path_t* {.bycopy.} = object

  sk_picture_t* {.bycopy.} = object

  sk_picture_recorder_t* {.bycopy.} = object

  sk_shader_t* {.bycopy.} = object

  sk_surface_t* {.bycopy.} = object

  sk_xfermode_mode_t* {.size: sizeof(cint).} = enum
    CLEAR_SK_XFERMODE_MODE, SRC_SK_XFERMODE_MODE, DST_SK_XFERMODE_MODE,
    SRCOVER_SK_XFERMODE_MODE, DSTOVER_SK_XFERMODE_MODE, SRCIN_SK_XFERMODE_MODE,
    DSTIN_SK_XFERMODE_MODE, SRCOUT_SK_XFERMODE_MODE, DSTOUT_SK_XFERMODE_MODE,
    SRCATOP_SK_XFERMODE_MODE, DSTATOP_SK_XFERMODE_MODE, XOR_SK_XFERMODE_MODE,
    PLUS_SK_XFERMODE_MODE, MODULATE_SK_XFERMODE_MODE, SCREEN_SK_XFERMODE_MODE,
    OVERLAY_SK_XFERMODE_MODE, DARKEN_SK_XFERMODE_MODE, LIGHTEN_SK_XFERMODE_MODE,
    COLORDODGE_SK_XFERMODE_MODE, COLORBURN_SK_XFERMODE_MODE,
    HARDLIGHT_SK_XFERMODE_MODE, SOFTLIGHT_SK_XFERMODE_MODE,
    DIFFERENCE_SK_XFERMODE_MODE, EXCLUSION_SK_XFERMODE_MODE,
    MULTIPLY_SK_XFERMODE_MODE, HUE_SK_XFERMODE_MODE, SATURATION_SK_XFERMODE_MODE,
    COLOR_SK_XFERMODE_MODE, LUMINOSITY_SK_XFERMODE_MODE

