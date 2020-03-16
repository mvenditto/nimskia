import ../wrapper/sk_types

type
  SkPixelGeometry* = enum
    UnknownPixelGeom = UNKNOWN_SK_PIXELGEOMETRY, 
    Rgb_H = RGB_H_SK_PIXELGEOMETRY, 
    Bgr_H = BGR_H_SK_PIXELGEOMETRY,
    Rgb_V = RGB_V_SK_PIXELGEOMETRY, 
    Bgr_V = BGR_V_SK_PIXELGEOMETRY

  SkColorType* = enum
    UnknownColorType = UNKNOWN_SK_COLORTYPE, 
    Alpha8 = ALPHA_8_SK_COLORTYPE, 
    Rgb565 = RGB_565_SK_COLORTYPE,
    Argb4444 = ARGB_4444_SK_COLORTYPE, 
    Rgba8888 = RGBA_8888_SK_COLORTYPE, 
    Rgb888X = RGB_888X_SK_COLORTYPE,
    Bgra8888 = BGRA_8888_SK_COLORTYPE, 
    Rgba1010102 = RGBA_1010102_SK_COLORTYPE, 
    Rgb101010X = RGB_101010X_SK_COLORTYPE,
    Gray8 = GRAY_8_SK_COLORTYPE, 
    RgbaF16 = RGBA_F16_SK_COLORTYPE
  
  SkAlphaType* = enum
    Opaque = OPAQUE_SK_ALPHATYPE, 
    Premul = PREMUL_SK_ALPHATYPE, 
    Unpremul = UNPREMUL_SK_ALPHATYPE
  
  SkStrokeCap* = enum
    ButtCap = BUTT_SK_STROKE_CAP, 
    RoundCap = ROUND_SK_STROKE_CAP, 
    SquareCap = SQUARE_SK_STROKE_CAP
  
  SkStrokeJoin* = enum
    MitelJoint = MITER_SK_STROKE_JOIN, 
    RoundJoint = ROUND_SK_STROKE_JOIN, 
    BevelJoint = BEVEL_SK_STROKE_JOIN
  
  SkClipOp* {.pure.} = enum
    Difference = DIFFERENCE_SK_CLIPOP
    Intersect = INTERSECT_SK_CLIPOP

  SkPathArcSize* {.pure.} = enum
    Small = SMALL_SK_PATH_ARC_SIZE
    Large = LARGE_SK_PATH_ARC_SIZE
  
  SkPathDirection* = enum
    Clockwise = CW_SK_PATH_DIRECTION
    CounterClockwise = CCW_SK_PATH_DIRECTION

  SkPaintStyle* = enum
    Fill = FILL_SK_PAINT_STYLE
    Stroke = STROKE_SK_PAINT_STYLE
    StrokeAndFill = STROKE_AND_FILL_SK_PAINT_STYLE
  
  SkZeroInitialized* = enum
    Yes = YES_SK_CODEC_ZERO_INITIALIZED
    No = NO_SK_CODEC_ZERO_INITIALIZED

  SkCodecResult* = enum
    Success = SUCCESS_SK_CODEC_RESULT
    IncompleteInput = INCOMPLETE_INPUT_SK_CODEC_RESULT
    ErrorInInput = ERROR_IN_INPUT_SK_CODEC_RESULT
    InvalidConversion = INVALID_CONVERSION_SK_CODEC_RESULT
    InvalidScale = INVALID_SCALE_SK_CODEC_RESULT 
    InvalidParameters = INVALID_PARAMETERS_SK_CODEC_RESULT
    InvalidInput = INVALID_INPUT_SK_CODEC_RESULT
    CouldNotRewind = COULD_NOT_REWIND_SK_CODEC_RESULT
    InternalError = INTERNAL_ERROR_SK_CODEC_RESULT
    Unimplemented = UNIMPLEMENTED_SK_CODEC_RESULT

  SkBlendMode* = enum
    Clear = CLEAR_SK_BLENDMODE
    Src = SRC_SK_BLENDMODE
    Dst = DST_SK_BLENDMODE
    SrcOver = SRCOVER_SK_BLENDMODE
    DstOver = DSTOVER_SK_BLENDMODE
    SrcIn = SRCIN_SK_BLENDMODE
    DstIn = DSTIN_SK_BLENDMODE
    SrcOut = SRCOUT_SK_BLENDMODE
    DstOut = DSTOUT_SK_BLENDMODE
    SrcATop = SRCATOP_SK_BLENDMODE
    DstATop = DSTATOP_SK_BLENDMODE
    Xor = XOR_SK_BLENDMODE
    Plus = PLUS_SK_BLENDMODE
    Modulate = MODULATE_SK_BLENDMODE
    Screen = SCREEN_SK_BLENDMODE
    Overlay = OVERLAY_SK_BLENDMODE
    Darken = DARKEN_SK_BLENDMODE
    Lighten = LIGHTEN_SK_BLENDMODE
    ColorDodge = COLORDODGE_SK_BLENDMODE
    ColorBurn = COLORBURN_SK_BLENDMODE
    HardLight = HARDLIGHT_SK_BLENDMODE
    SoftLight = SOFTLIGHT_SK_BLENDMODE
    Difference = DIFFERENCE_SK_BLENDMODE
    Exclusion = EXCLUSION_SK_BLENDMODE
    Multiply = MULTIPLY_SK_BLENDMODE
    Hue = HUE_SK_BLENDMODE
    Saturation = SATURATION_SK_BLENDMODE
    Color = COLOR_SK_BLENDMODE
    Luminosity LUMINOSITY_SK_BLENDMODE

  SkShaderTileMode* = enum
    Clamp = CLAMP_SK_SHADER_TILEMODE
    Repeat = REPEAT_SK_SHADER_TILEMODE
    Mirror = MIRROR_SK_SHADER_TILEMODE
  
  SkTextAlign* = enum
    Left = LEFT_SK_TEXT_ALIGN
    Center = CENTER_SK_TEXT_ALIGN
    Right = RIGHT_SK_TEXT_ALIGN

  SkPathFillType* = enum
    Winding = WINDING_SK_PATH_FILLTYPE, 
    EvenOdd = EVENODD_SK_PATH_FILLTYPE,
    InverseWinding = INVERSE_WINDING_SK_PATH_FILLTYPE, 
    InverseEvenOdd = INVERSE_EVENODD_SK_PATH_FILLTYPE

  SkTransferFunctionBehavior* = enum
    Respect = RESPECT_SK_TRANSFER_FUNCTION_BEHAVIOR
    Ignore = IGNORE_SK_TRANSFER_FUNCTION_BEHAVIOR

  SkImageCachingHint* = enum
    Allow = ALLOW_SK_IMAGE_CACHING_HINT
    Disallow = DISALLOW_SK_IMAGE_CACHING_HINT
  
  SkPathEffect1DStyle* = enum
    Translate = TRANSLATE_SK_PATH_EFFECT_1D_STYLE
    Rotate = ROTATE_SK_PATH_EFFECT_1D_STYLE
    Morph = MORPH_SK_PATH_EFFECT_1D_STYLE

  SkTextEncoding* {.pure.} = enum
    Utf8 = UTF8_SK_TEXT_ENCODING
    Utf16 = UTF16_SK_TEXT_ENCODING
    Utf32 = UTF32_SK_TEXT_ENCODING
    GlyphId = GLYPH_ID_SK_TEXT_ENCODING
  
  SkEncoding* {.pure.} = enum
    Utf8 = UTF8_SK_ENCODING
    Utf16 = UTF16_SK_ENCODING
    Utf32 = UTF32_SK_ENCODING

  SkVertexMode* = enum
    Triangles = TRIANGLES_SK_VERTICES_VERTEX_MODE, 
    TriangleStrip = TRIANGLE_STRIP_SK_VERTICES_VERTEX_MODE,
    TriangleFan = TRIANGLE_FAN_SK_VERTICES_VERTEX_MODE

  SkLatticeRectType* {.pure.} = enum
    Default = DEFAULT_SK_LATTICE_RECT_TYPE
    Transparent = TRANSPARENT_SK_LATTICE_RECT_TYPE
    FixedColor = FIXED_COLOR_SK_LATTICE_RECT_TYPE

  SkTypefaceFlag* {.pure.} = enum
    Normal = 0,
    Bold = 0x01,  
    Italic = 0x02,
    BoldItalic = 0x03
  
  SkTypeFaceStyle* = set[SkTypefaceFlag]

  SkFontStyleSlant* {.pure.} = enum
    Upright = UPRIGHT_SK_FONT_STYLE_SLANT,
    Italic = ITALIC_SK_FONT_STYLE_SLANT,
    Oblique = OBLIQUE_SK_FONT_STYLE_SLANT

  SkFontStyleWeight* {.pure.} = enum
    Invisible = 0,
    Thin = 100,
    ExtraLight = 200,
    Light = 300,
    Normal = 400,
    Medium = 500,
    SemiBold = 600,
    Bold = 700,
    ExtraBold = 800,
    Black = 900,
    ExtraBlack = 1000

  SkFontStyleWidth* {.pure.} = enum
    UltraCondensed = 1,
    ExtraCondensed = 2,
    Condensed = 3,
    SemiCondensed = 4,
    Normal = 5,
    SemiExpanded = 6,
    Expanded = 7,
    ExtraExpanded = 8,
    UltraExpanded = 9

  SkPaintHinting* = enum
    NoHinting = NO_HINTING_SK_PAINT_HINTING
    Slight = SLIGHT_HINTING_SK_PAINT_HINTING
    Normal = NORMAL_HINTING_SK_PAINT_HINTING 
    Full = FULL_HINTING_SK_PAINT_HINTING

const
  LastSeparableMode* = Multiply
  LastCoeffMode* = Screen
  LastMode* = Luminosity