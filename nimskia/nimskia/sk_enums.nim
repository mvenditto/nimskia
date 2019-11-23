import ../wrapper/sk_types

type
  SKPixelGeometry* = enum
    UnknownPixelGeom = UNKNOWN_SK_PIXELGEOMETRY, 
    Rgb_H = RGB_H_SK_PIXELGEOMETRY, 
    Bgr_H = BGR_H_SK_PIXELGEOMETRY,
    Rgb_V = RGB_V_SK_PIXELGEOMETRY, 
    Bgr_V = BGR_V_SK_PIXELGEOMETRY

  SKColorType* = enum
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
  
  SKAlphaType* = enum
    Opaque = OPAQUE_SK_ALPHATYPE, 
    Premul = PREMUL_SK_ALPHATYPE, 
    Unpremul = UNPREMUL_SK_ALPHATYPE
  
  SKStrokeCap* = enum
    ButtCap = BUTT_SK_STROKE_CAP, 
    RoundCap = ROUND_SK_STROKE_CAP, 
    SquareCap = SQUARE_SK_STROKE_CAP
  
  SKStrokeJoin* = enum
    MitelJoint = MITER_SK_STROKE_JOIN, 
    RoundJoint = ROUND_SK_STROKE_JOIN, 
    BevelJoint = BEVEL_SK_STROKE_JOIN