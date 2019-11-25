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
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
type
  sk_refcnt_t* {.bycopy.} = object

  sk_nvrefcnt_t* {.bycopy.} = object

  sk_color_t* = uint32
  sk_pmcolor_t* = uint32
  sk_colortype_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_COLORTYPE = 0, ALPHA_8_SK_COLORTYPE, RGB_565_SK_COLORTYPE,
    ARGB_4444_SK_COLORTYPE, RGBA_8888_SK_COLORTYPE, RGB_888X_SK_COLORTYPE,
    BGRA_8888_SK_COLORTYPE, RGBA_1010102_SK_COLORTYPE, RGB_101010X_SK_COLORTYPE,
    GRAY_8_SK_COLORTYPE, RGBA_F16_SK_COLORTYPE
  sk_alphatype_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_ALPHATYPE, OPAQUE_SK_ALPHATYPE, PREMUL_SK_ALPHATYPE,
    UNPREMUL_SK_ALPHATYPE
  sk_pixelgeometry_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_PIXELGEOMETRY, RGB_H_SK_PIXELGEOMETRY, BGR_H_SK_PIXELGEOMETRY,
    RGB_V_SK_PIXELGEOMETRY, BGR_V_SK_PIXELGEOMETRY
  sk_surfaceprops_flags_t* {.size: sizeof(cint).} = enum
    NONE_SK_SURFACE_PROPS_FLAGS = 0,
    USE_DEVICE_INDEPENDENT_FONTS_SK_SURFACE_PROPS_FLAGS = 1 shl 0





type
  sk_surfaceprops_t* {.bycopy.} = object

  sk_point_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat

  sk_vector_t* = sk_point_t
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
    scaleX*: cfloat
    skewX*: cfloat
    transX*: cfloat
    skewY*: cfloat
    scaleY*: cfloat
    transY*: cfloat
    persp0*: cfloat
    persp1*: cfloat
    persp2*: cfloat

  sk_matrix44_t* {.bycopy.} = object

  sk_matrix44_type_mask_t* {.size: sizeof(cint).} = enum
    IDENTITY_SK_MATRIX44_TYPE_MASK = 0,
    TRANSLATE_SK_MATRIX44_TYPE_MASK = 0x00000001,
    SCALE_SK_MATRIX44_TYPE_MASK = 0x00000002,
    AFFINE_SK_MATRIX44_TYPE_MASK = 0x00000004,
    PERSPECTIVE_SK_MATRIX44_TYPE_MASK = 0x00000008


type
  sk_canvas_t* {.bycopy.} = object

  sk_nodraw_canvas_t* {.bycopy.} = object

  sk_nway_canvas_t* {.bycopy.} = object

  sk_overdraw_canvas_t* {.bycopy.} = object

  sk_data_t* {.bycopy.} = object

  sk_drawable_t* {.bycopy.} = object

  sk_image_t* {.bycopy.} = object

  sk_maskfilter_t* {.bycopy.} = object

  sk_paint_t* {.bycopy.} = object

  sk_path_t* {.bycopy.} = object

  sk_picture_t* {.bycopy.} = object

  sk_picture_recorder_t* {.bycopy.} = object

  sk_shader_t* {.bycopy.} = object

  sk_surface_t* {.bycopy.} = object

  sk_region_t* {.bycopy.} = object

  sk_blendmode_t* {.size: sizeof(cint).} = enum
    CLEAR_SK_BLENDMODE, SRC_SK_BLENDMODE, DST_SK_BLENDMODE, SRCOVER_SK_BLENDMODE,
    DSTOVER_SK_BLENDMODE, SRCIN_SK_BLENDMODE, DSTIN_SK_BLENDMODE,
    SRCOUT_SK_BLENDMODE, DSTOUT_SK_BLENDMODE, SRCATOP_SK_BLENDMODE,
    DSTATOP_SK_BLENDMODE, XOR_SK_BLENDMODE, PLUS_SK_BLENDMODE,
    MODULATE_SK_BLENDMODE, SCREEN_SK_BLENDMODE, OVERLAY_SK_BLENDMODE,
    DARKEN_SK_BLENDMODE, LIGHTEN_SK_BLENDMODE, COLORDODGE_SK_BLENDMODE,
    COLORBURN_SK_BLENDMODE, HARDLIGHT_SK_BLENDMODE, SOFTLIGHT_SK_BLENDMODE,
    DIFFERENCE_SK_BLENDMODE, EXCLUSION_SK_BLENDMODE, MULTIPLY_SK_BLENDMODE,
    HUE_SK_BLENDMODE, SATURATION_SK_BLENDMODE, COLOR_SK_BLENDMODE,
    LUMINOSITY_SK_BLENDMODE
  sk_point3_t* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    z*: cfloat

  sk_ipoint_t* {.bycopy.} = object
    x*: int32
    y*: int32

  sk_size_t* {.bycopy.} = object
    w*: cfloat
    h*: cfloat

  sk_isize_t* {.bycopy.} = object
    w*: int32
    h*: int32

  sk_fontmetrics_t* {.bycopy.} = object
    fFlags*: uint32
    fTop*: cfloat
    fAscent*: cfloat
    fDescent*: cfloat
    fBottom*: cfloat
    fLeading*: cfloat
    fAvgCharWidth*: cfloat
    fMaxCharWidth*: cfloat
    fXMin*: cfloat
    fXMax*: cfloat
    fXHeight*: cfloat
    fCapHeight*: cfloat
    fUnderlineThickness*: cfloat
    fUnderlinePosition*: cfloat
    fStrikeoutThickness*: cfloat
    fStrikeoutPosition*: cfloat



type
  sk_string_t* {.bycopy.} = object

  sk_bitmap_t* {.bycopy.} = object

  sk_pixmap_t* {.bycopy.} = object

  sk_colorfilter_t* {.bycopy.} = object

  sk_imagefilter_t* {.bycopy.} = object

  sk_imagefilter_croprect_t* {.bycopy.} = object

  sk_typeface_t* {.bycopy.} = object

  sk_font_table_tag_t* = uint32
  sk_fontmgr_t* {.bycopy.} = object

  sk_fontstyle_t* {.bycopy.} = object

  sk_fontstyleset_t* {.bycopy.} = object

  sk_codec_t* {.bycopy.} = object

  sk_colorspace_t* {.bycopy.} = object

  sk_stream_t* {.bycopy.} = object

  sk_stream_filestream_t* {.bycopy.} = object

  sk_stream_asset_t* {.bycopy.} = object

  sk_stream_memorystream_t* {.bycopy.} = object

  sk_stream_streamrewindable_t* {.bycopy.} = object

  sk_wstream_t* {.bycopy.} = object

  sk_wstream_filestream_t* {.bycopy.} = object

  sk_wstream_dynamicmemorystream_t* {.bycopy.} = object

  sk_document_t* {.bycopy.} = object

  sk_encoding_t* {.size: sizeof(cint).} = enum
    UTF8_SK_ENCODING, UTF16_SK_ENCODING, UTF32_SK_ENCODING
  sk_point_mode_t* {.size: sizeof(cint).} = enum
    POINTS_SK_POINT_MODE, LINES_SK_POINT_MODE, POLYGON_SK_POINT_MODE
  sk_text_align_t* {.size: sizeof(cint).} = enum
    LEFT_SK_TEXT_ALIGN, CENTER_SK_TEXT_ALIGN, RIGHT_SK_TEXT_ALIGN
  sk_text_encoding_t* {.size: sizeof(cint).} = enum
    UTF8_SK_TEXT_ENCODING, UTF16_SK_TEXT_ENCODING, UTF32_SK_TEXT_ENCODING,
    GLYPH_ID_SK_TEXT_ENCODING
  sk_path_filltype_t* {.size: sizeof(cint).} = enum
    WINDING_SK_PATH_FILLTYPE, EVENODD_SK_PATH_FILLTYPE,
    INVERSE_WINDING_SK_PATH_FILLTYPE, INVERSE_EVENODD_SK_PATH_FILLTYPE
  sk_font_style_slant_t* {.size: sizeof(cint).} = enum
    UPRIGHT_SK_FONT_STYLE_SLANT = 0, ITALIC_SK_FONT_STYLE_SLANT = 1,
    OBLIQUE_SK_FONT_STYLE_SLANT = 2
  sk_filter_quality_t* {.size: sizeof(cint).} = enum
    NONE_SK_FILTER_QUALITY, LOW_SK_FILTER_QUALITY, MEDIUM_SK_FILTER_QUALITY,
    HIGH_SK_FILTER_QUALITY
  sk_crop_rect_flags_t* {.size: sizeof(cint).} = enum
    HAS_NONE_SK_CROP_RECT_FLAG = 0x00000000,
    HAS_LEFT_SK_CROP_RECT_FLAG = 0x00000001,
    HAS_TOP_SK_CROP_RECT_FLAG = 0x00000002,
    HAS_WIDTH_SK_CROP_RECT_FLAG = 0x00000004,
    HAS_HEIGHT_SK_CROP_RECT_FLAG = 0x00000008,
    HAS_ALL_SK_CROP_RECT_FLAG = 0x0000000F
  sk_drop_shadow_image_filter_shadow_mode_t* {.size: sizeof(cint).} = enum
    DRAW_SHADOW_AND_FOREGROUND_SK_DROP_SHADOW_IMAGE_FILTER_SHADOW_MODE,
    DRAW_SHADOW_ONLY_SK_DROP_SHADOW_IMAGE_FILTER_SHADOW_MODE
  sk_displacement_map_effect_channel_selector_type_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_DISPLACEMENT_MAP_EFFECT_CHANNEL_SELECTOR_TYPE,
    R_SK_DISPLACEMENT_MAP_EFFECT_CHANNEL_SELECTOR_TYPE,
    G_SK_DISPLACEMENT_MAP_EFFECT_CHANNEL_SELECTOR_TYPE,
    B_SK_DISPLACEMENT_MAP_EFFECT_CHANNEL_SELECTOR_TYPE,
    A_SK_DISPLACEMENT_MAP_EFFECT_CHANNEL_SELECTOR_TYPE
  sk_matrix_convolution_tilemode_t* {.size: sizeof(cint).} = enum
    CLAMP_SK_MATRIX_CONVOLUTION_TILEMODE, REPEAT_SK_MATRIX_CONVOLUTION_TILEMODE,
    CLAMP_TO_BLACK_SK_MATRIX_CONVOLUTION_TILEMODE
  sk_region_op_t* {.size: sizeof(cint).} = enum
    DIFFERENCE_SK_REGION_OP, INTERSECT_SK_REGION_OP, UNION_SK_REGION_OP,
    XOR_SK_REGION_OP, REVERSE_DIFFERENCE_SK_REGION_OP, REPLACE_SK_REGION_OP
  sk_clipop_t* {.size: sizeof(cint).} = enum
    DIFFERENCE_SK_CLIPOP, INTERSECT_SK_CLIPOP
  sk_encoded_image_format_t* {.size: sizeof(cint).} = enum
    BMP_SK_ENCODED_FORMAT, GIF_SK_ENCODED_FORMAT, ICO_SK_ENCODED_FORMAT,
    JPEG_SK_ENCODED_FORMAT, PNG_SK_ENCODED_FORMAT, WBMP_SK_ENCODED_FORMAT,
    WEBP_SK_ENCODED_FORMAT, PKM_SK_ENCODED_FORMAT, KTX_SK_ENCODED_FORMAT,
    ASTC_SK_ENCODED_FORMAT, DNG_SK_ENCODED_FORMAT, HEIF_SK_ENCODED_FORMAT
  sk_encodedorigin_t* {.size: sizeof(cint).} = enum
    TOP_LEFT_SK_ENCODED_ORIGIN = 1, TOP_RIGHT_SK_ENCODED_ORIGIN = 2,
    BOTTOM_RIGHT_SK_ENCODED_ORIGIN = 3, BOTTOM_LEFT_SK_ENCODED_ORIGIN = 4,
    LEFT_TOP_SK_ENCODED_ORIGIN = 5, RIGHT_TOP_SK_ENCODED_ORIGIN = 6,
    RIGHT_BOTTOM_SK_ENCODED_ORIGIN = 7, LEFT_BOTTOM_SK_ENCODED_ORIGIN = 8
  sk_codec_result_t* {.size: sizeof(cint).} = enum
    SUCCESS_SK_CODEC_RESULT, INCOMPLETE_INPUT_SK_CODEC_RESULT,
    ERROR_IN_INPUT_SK_CODEC_RESULT, INVALID_CONVERSION_SK_CODEC_RESULT,
    INVALID_SCALE_SK_CODEC_RESULT, INVALID_PARAMETERS_SK_CODEC_RESULT,
    INVALID_INPUT_SK_CODEC_RESULT, COULD_NOT_REWIND_SK_CODEC_RESULT,
    INTERNAL_ERROR_SK_CODEC_RESULT, UNIMPLEMENTED_SK_CODEC_RESULT
  sk_codec_zero_initialized_t* {.size: sizeof(cint).} = enum
    YES_SK_CODEC_ZERO_INITIALIZED, NO_SK_CODEC_ZERO_INITIALIZED
  sk_transfer_function_behavior_t* {.size: sizeof(cint).} = enum
    RESPECT_SK_TRANSFER_FUNCTION_BEHAVIOR, IGNORE_SK_TRANSFER_FUNCTION_BEHAVIOR
  sk_codec_options_t* {.bycopy.} = object
    fZeroInitialized*: sk_codec_zero_initialized_t
    fSubset*: ptr sk_irect_t
    fFrameIndex*: cint
    fPriorFrame*: cint
    fPremulBehavior*: sk_transfer_function_behavior_t

  sk_codec_scanline_order_t* {.size: sizeof(cint).} = enum
    TOP_DOWN_SK_CODEC_SCANLINE_ORDER, BOTTOM_UP_SK_CODEC_SCANLINE_ORDER
  sk_path_verb_t* {.size: sizeof(cint).} = enum
    MOVE_SK_PATH_VERB, LINE_SK_PATH_VERB, QUAD_SK_PATH_VERB, CONIC_SK_PATH_VERB,
    CUBIC_SK_PATH_VERB, CLOSE_SK_PATH_VERB, DONE_SK_PATH_VERB















const
  DEFAULT_SK_ENCODED_ORIGIN = TOP_LEFT_SK_ENCODED_ORIGIN






type
  sk_path_iterator_t* {.bycopy.} = object

  sk_path_rawiterator_t* {.bycopy.} = object

  sk_path_add_mode_t* {.size: sizeof(cint).} = enum
    APPEND_SK_PATH_ADD_MODE, EXTEND_SK_PATH_ADD_MODE
  sk_path_segment_mask_t* {.size: sizeof(cint).} = enum
    LINE_SK_PATH_SEGMENT_MASK = 1 shl 0, QUAD_SK_PATH_SEGMENT_MASK = 1 shl 1,
    CONIC_SK_PATH_SEGMENT_MASK = 1 shl 2, CUBIC_SK_PATH_SEGMENT_MASK = 1 shl 3
  sk_path_effect_1d_style_t* {.size: sizeof(cint).} = enum
    TRANSLATE_SK_PATH_EFFECT_1D_STYLE, ROTATE_SK_PATH_EFFECT_1D_STYLE,
    MORPH_SK_PATH_EFFECT_1D_STYLE
  sk_path_effect_trim_mode_t* {.size: sizeof(cint).} = enum
    NORMAL_SK_PATH_EFFECT_TRIM_MODE, INVERTED_SK_PATH_EFFECT_TRIM_MODE





type
  sk_path_effect_t* {.bycopy.} = object

  sk_stroke_cap_t* {.size: sizeof(cint).} = enum
    BUTT_SK_STROKE_CAP, ROUND_SK_STROKE_CAP, SQUARE_SK_STROKE_CAP
  sk_stroke_join_t* {.size: sizeof(cint).} = enum
    MITER_SK_STROKE_JOIN, ROUND_SK_STROKE_JOIN, BEVEL_SK_STROKE_JOIN
  sk_shader_tilemode_t* {.size: sizeof(cint).} = enum
    CLAMP_SK_SHADER_TILEMODE, REPEAT_SK_SHADER_TILEMODE, MIRROR_SK_SHADER_TILEMODE
  sk_blurstyle_t* {.size: sizeof(cint).} = enum
    NORMAL_SK_BLUR_STYLE, SOLID_SK_BLUR_STYLE, OUTER_SK_BLUR_STYLE,
    INNER_SK_BLUR_STYLE
  sk_path_direction_t* {.size: sizeof(cint).} = enum
    CW_SK_PATH_DIRECTION, CCW_SK_PATH_DIRECTION
  sk_path_arc_size_t* {.size: sizeof(cint).} = enum
    SMALL_SK_PATH_ARC_SIZE, LARGE_SK_PATH_ARC_SIZE
  sk_paint_style_t* {.size: sizeof(cint).} = enum
    FILL_SK_PAINT_STYLE, STROKE_SK_PAINT_STYLE, STROKE_AND_FILL_SK_PAINT_STYLE
  sk_paint_hinting_t* {.size: sizeof(cint).} = enum
    NO_HINTING_SK_PAINT_HINTING, SLIGHT_HINTING_SK_PAINT_HINTING,
    NORMAL_HINTING_SK_PAINT_HINTING, FULL_HINTING_SK_PAINT_HINTING









type
  sk_colortable_t* {.bycopy.} = object

  sk_pixelref_factory_t* {.bycopy.} = object

  gr_surfaceorigin_t* {.size: sizeof(cint).} = enum
    TOP_LEFT_GR_SURFACE_ORIGIN, BOTTOM_LEFT_GR_SURFACE_ORIGIN
  gr_pixelconfig_t* {.size: sizeof(cint).} = enum
    UNKNOWN_GR_PIXEL_CONFIG, ALPHA_8_GR_PIXEL_CONFIG, GRAY_8_GR_PIXEL_CONFIG,
    RGB_565_GR_PIXEL_CONFIG, RGBA_4444_GR_PIXEL_CONFIG, RGBA_8888_GR_PIXEL_CONFIG,
    RGB_888_GR_PIXEL_CONFIG, BGRA_8888_GR_PIXEL_CONFIG,
    SRGBA_8888_GR_PIXEL_CONFIG, SBGRA_8888_GR_PIXEL_CONFIG,
    RGBA_1010102_GR_PIXEL_CONFIG, RGBA_FLOAT_GR_PIXEL_CONFIG,
    RG_FLOAT_GR_PIXEL_CONFIG, ALPHA_HALF_GR_PIXEL_CONFIG,
    RGBA_HALF_GR_PIXEL_CONFIG
  sk_mask_format_t* {.size: sizeof(cint).} = enum
    BW_SK_MASK_FORMAT, A8_SK_MASK_FORMAT, THREE_D_SK_MASK_FORMAT,
    ARGB32_SK_MASK_FORMAT, LCD16_SK_MASK_FORMAT
  sk_mask_t* {.bycopy.} = object
    fImage*: ptr uint8
    fBounds*: sk_irect_t
    fRowBytes*: uint32
    fFormat*: sk_mask_format_t

  gr_backendobject_t* = cint




type
  gr_backendrendertarget_t* {.bycopy.} = object

  gr_backendtexture_t* {.bycopy.} = object

  gr_context_t* {.bycopy.} = object

  gr_backend_t* {.size: sizeof(cint).} = enum
    METAL_GR_BACKEND, OPENGL_GR_BACKEND, VULKAN_GR_BACKEND
  gr_backendcontext_t* = cint


type
  gr_glinterface_t* {.bycopy.} = object

  gr_gl_func_ptr* = proc () 
  gr_gl_get_proc* = proc (ctx: pointer; name: cstring): gr_gl_func_ptr 
  gr_gl_textureinfo_t* {.bycopy.} = object
    fTarget*: cuint
    fID*: cuint
    fFormat*: cuint

  gr_gl_framebufferinfo_t* {.bycopy.} = object
    fFBOID*: cuint
    fFormat*: cuint

  sk_pathop_t* {.size: sizeof(cint).} = enum
    DIFFERENCE_SK_PATHOP, INTERSECT_SK_PATHOP, UNION_SK_PATHOP, XOR_SK_PATHOP,
    REVERSE_DIFFERENCE_SK_PATHOP


type
  sk_opbuilder_t* {.bycopy.} = object

  sk_path_convexity_t* {.size: sizeof(cint).} = enum
    UNKNOWN_SK_PATH_CONVEXITY, CONVEX_SK_PATH_CONVEXITY, CONCAVE_SK_PATH_CONVEXITY
  sk_lattice_recttype_t* {.size: sizeof(cint).} = enum
    DEFAULT_SK_LATTICE_RECT_TYPE, TRANSPARENT_SK_LATTICE_RECT_TYPE,
    FIXED_COLOR_SK_LATTICE_RECT_TYPE
  sk_lattice_t* {.bycopy.} = object
    fXDivs*: ptr cint
    fYDivs*: ptr cint
    fRectTypes*: ptr sk_lattice_recttype_t
    fXCount*: cint
    fYCount*: cint
    fBounds*: ptr sk_irect_t
    fColors*: ptr sk_color_t




type
  sk_pathmeasure_t* {.bycopy.} = object

  sk_pathmeasure_matrixflags_t* {.size: sizeof(cint).} = enum
    GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS = 0x00000001,
    GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS = 0x00000002, GET_POS_AND_TAN_SK_PATHMEASURE_MATRIXFLAGS = GET_POSITION_SK_PATHMEASURE_MATRIXFLAGS.cint or GET_TANGENT_SK_PATHMEASURE_MATRIXFLAGS.cint
  sk_bitmap_release_proc* = proc (`addr`: pointer; context: pointer) 
  sk_data_release_proc* = proc (`ptr`: pointer; context: pointer) 
  sk_image_raster_release_proc* = proc (`addr`: pointer; context: pointer) 
  sk_image_texture_release_proc* = proc (context: pointer) 
  sk_surface_raster_release_proc* = proc (`addr`: pointer; context: pointer) 
  sk_image_caching_hint_t* {.size: sizeof(cint).} = enum
    ALLOW_SK_IMAGE_CACHING_HINT, DISALLOW_SK_IMAGE_CACHING_HINT
  sk_bitmap_allocflags_t* {.size: sizeof(cint).} = enum
    NONE_SK_BITMAP_ALLOC_FLAGS = 0, ZERO_PIXELS_SK_BITMAP_ALLOC_FLAGS = 1 shl 0
  sk_time_datetime_t* {.bycopy.} = object
    fTimeZoneMinutes*: int16
    fYear*: uint16
    fMonth*: uint8
    fDayOfWeek*: uint8
    fDay*: uint8
    fHour*: uint8
    fMinute*: uint8
    fSecond*: uint8

  sk_document_pdf_metadata_t* {.bycopy.} = object
    fTitle*: ptr sk_string_t
    fAuthor*: ptr sk_string_t
    fSubject*: ptr sk_string_t
    fKeywords*: ptr sk_string_t
    fCreator*: ptr sk_string_t
    fProducer*: ptr sk_string_t
    fCreation*: ptr sk_time_datetime_t
    fModified*: ptr sk_time_datetime_t
    fRasterDPI*: cfloat
    fPDFA*: bool
    fEncodingQuality*: cint

  sk_imageinfo_t* {.bycopy.} = object
    colorspace*: ptr sk_colorspace_t
    width*: int32
    height*: int32
    colorType*: sk_colortype_t
    alphaType*: sk_alphatype_t

  sk_codecanimation_disposalmethod_t* {.size: sizeof(cint).} = enum
    KEEP_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 1,
    RESTORE_BG_COLOR_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 2,
    RESTORE_PREVIOUS_SK_CODEC_ANIMATION_DISPOSAL_METHOD = 3
  sk_codec_frameinfo_t* {.bycopy.} = object
    fRequiredFrame*: cint
    fDuration*: cint
    fFullyReceived*: bool
    fAlphaType*: sk_alphatype_t
    fDisposalMethod*: sk_codecanimation_disposalmethod_t






type
  sk_xmlstreamwriter_t* {.bycopy.} = object

  sk_xmlwriter_t* {.bycopy.} = object

  sk_svgcanvas_t* {.bycopy.} = object

  sk_3dview_t* {.bycopy.} = object

  sk_vertices_vertex_mode_t* {.size: sizeof(cint).} = enum
    TRIANGLES_SK_VERTICES_VERTEX_MODE, TRIANGLE_STRIP_SK_VERTICES_VERTEX_MODE,
    TRIANGLE_FAN_SK_VERTICES_VERTEX_MODE


type
  sk_vertices_t* {.bycopy.} = object

  sk_gamma_named_t* {.size: sizeof(cint).} = enum
    LINEAR_SK_GAMMA_NAMED, SRGB_SK_GAMMA_NAMED, TWO_DOT_TWO_CURVE_SK_GAMMA_NAMED,
    NON_STANDARD_SK_GAMMA_NAMED
  sk_colorspace_type_t* {.size: sizeof(cint).} = enum
    RGB_SK_COLORSPACE_TYPE, CMYK_SK_COLORSPACE_TYPE, GRAY_SK_COLORSPACE_TYPE
  sk_colorspace_render_target_gamma_t* {.size: sizeof(cint).} = enum
    LINEAR_SK_COLORSPACE_RENDER_TARGET_GAMMA,
    SRGB_SK_COLORSPACE_RENDER_TARGET_GAMMA
  sk_colorspace_gamut_t* {.size: sizeof(cint).} = enum
    SRGB_SK_COLORSPACE_GAMUT, ADOBE_RGB_SK_COLORSPACE_GAMUT,
    DCIP3_D65_SK_COLORSPACE_GAMUT, REC2020_SK_COLORSPACE_GAMUT
  sk_colorspace_transfer_fn_t* {.bycopy.} = object
    fG*: cfloat
    fA*: cfloat
    fB*: cfloat
    fC*: cfloat
    fD*: cfloat
    fE*: cfloat
    fF*: cfloat

  sk_colorspaceprimaries_t* {.bycopy.} = object
    fRX*: cfloat
    fRY*: cfloat
    fGX*: cfloat
    fGY*: cfloat
    fBX*: cfloat
    fBY*: cfloat
    fWX*: cfloat
    fWY*: cfloat

  sk_highcontrastconfig_invertstyle_t* {.size: sizeof(cint).} = enum
    NO_INVERT_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE,
    INVERT_BRIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE,
    INVERT_LIGHTNESS_SK_HIGH_CONTRAST_CONFIG_INVERT_STYLE
  sk_highcontrastconfig_t* {.bycopy.} = object
    fGrayscale*: bool
    fInvertStyle*: sk_highcontrastconfig_invertstyle_t
    fContrast*: cfloat

  sk_pngencoder_filterflags_t* {.size: sizeof(cint).} = enum
    ZERO_SK_PNGENCODER_FILTER_FLAGS = 0x00000000,
    NONE_SK_PNGENCODER_FILTER_FLAGS = 0x00000008,
    SUB_SK_PNGENCODER_FILTER_FLAGS = 0x00000010,
    UP_SK_PNGENCODER_FILTER_FLAGS = 0x00000020,
    AVG_SK_PNGENCODER_FILTER_FLAGS = 0x00000040,
    PAETH_SK_PNGENCODER_FILTER_FLAGS = 0x00000080, ALL_SK_PNGENCODER_FILTER_FLAGS = NONE_SK_PNGENCODER_FILTER_FLAGS.cint or SUB_SK_PNGENCODER_FILTER_FLAGS.cint or UP_SK_PNGENCODER_FILTER_FLAGS.cint or AVG_SK_PNGENCODER_FILTER_FLAGS.cint or PAETH_SK_PNGENCODER_FILTER_FLAGS.cint
  sk_pngencoder_options_t* {.bycopy.} = object
    fFilterFlags*: sk_pngencoder_filterflags_t
    fZLibLevel*: cint
    fUnpremulBehavior*: sk_transfer_function_behavior_t
    fComments*: pointer

  sk_jpegencoder_downsample_t* {.size: sizeof(cint).} = enum
    DOWNSAMPLE_420_SK_JPEGENCODER_DOWNSAMPLE,
    DOWNSAMPLE_422_SK_JPEGENCODER_DOWNSAMPLE,
    DOWNSAMPLE_444_SK_JPEGENCODER_DOWNSAMPLE
  sk_jpegencoder_alphaoption_t* {.size: sizeof(cint).} = enum
    IGNORE_SK_JPEGENCODER_ALPHA_OPTION,
    BLEND_ON_BLACK_SK_JPEGENCODER_ALPHA_OPTION
  sk_jpegencoder_options_t* {.bycopy.} = object
    fQuality*: cint
    fDownsample*: sk_jpegencoder_downsample_t
    fAlphaOption*: sk_jpegencoder_alphaoption_t
    fBlendBehavior*: sk_transfer_function_behavior_t

  sk_webpencoder_compression_t* {.size: sizeof(cint).} = enum
    LOSSY_SK_WEBPENCODER_COMPTRESSION, LOSSLESS_SK_WEBPENCODER_COMPTRESSION
  sk_webpencoder_options_t* {.bycopy.} = object
    fCompression*: sk_webpencoder_compression_t
    fQuality*: cfloat
    fUnpremulBehavior*: sk_transfer_function_behavior_t











type
  sk_rrect_t* {.bycopy.} = object

  sk_rrect_type_t* {.size: sizeof(cint).} = enum
    EMPTY_SK_RRECT_TYPE, RECT_SK_RRECT_TYPE, OVAL_SK_RRECT_TYPE,
    SIMPLE_SK_RRECT_TYPE, NINE_PATCH_SK_RRECT_TYPE, COMPLEX_SK_RRECT_TYPE
  sk_rrect_corner_t* {.size: sizeof(cint).} = enum
    UPPER_LEFT_SK_RRECT_CORNER, UPPER_RIGHT_SK_RRECT_CORNER,
    LOWER_RIGHT_SK_RRECT_CORNER, LOWER_LEFT_SK_RRECT_CORNER



type
  sk_textblob_t* {.bycopy.} = object

  sk_textblob_builder_t* {.bycopy.} = object

  sk_textblob_builder_runbuffer_t* {.bycopy.} = object
    glyphs*: pointer
    pos*: pointer
    utf8text*: pointer
    clusters*: pointer

