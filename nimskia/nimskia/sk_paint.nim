import ../wrapper/sk_types
import ../wrapper/sk_paint

import sk_color
import sk_enums
import sk_shader
import sk_rect
import sk_patheffect
import sk_typeface

import internals/native

type
  SkPaint* = ref object of SkObject[sk_paint_t]

proc dispose*(this: SkPaint) = sk_paint_delete(this.native)

template isAntialias*(this: SkPaint): bool = sk_paint_is_antialias(this.native)

template `antialias=`*(this: SkPaint, enabled: bool) = 
  sk_paint_set_antialias(this.native, enabled)

template color*(this: SkPaint): SkColor = 
  sk_paint_get_color(this.native).SkColor

template `color=`*(this: SkPaint, color: SkColor) =
  sk_paint_set_color(this.native, cast[sk_color_t](color))

template `color=`*(this: SkPaint, argb: (int,int,int,int)) =
  var(a,r,g,b) = argb
  sk_paint_set_color(this.native, newSkColorARGB(a,r,g,b)) 

template style*(this: SkPaint): SkPaintStyle = 
  sk_paint_get_style(this.native).SkPaintStyle

template `style=`*(this: SkPaint, style: SkPaintStyle) = 
  sk_paint_set_style(this.native, cast[sk_paint_style_t](style))

template isStroke*(this: SkPaint): bool = 
  this.style == Stroke

template `shader=`*(this: SkPaint, shader: SkShader) =
  sk_paint_set_shader(
    this.native, 
    if not isNil shader: shader.native else: nil
  )

template shader*(this: SkPaint): SkShader = 
  SkShader(native: sk_paint_get_shader(this.native))

template `pathEffect=`*(this: SkPaint, pathEffect: SkPathEffect) =
  sk_paint_set_path_effect(this.native, pathEffect.native) 

template strokeWidth*(this: SkPaint): float = 
  sk_paint_get_stroke_width(this.native).float

template `strokeWidth=`*(this: SkPaint, strokeWidth: float) =
  sk_paint_set_stroke_width(this.native, strokeWidth) 

template miterWidth*(this: SkPaint): float = 
  sk_paint_get_stroke_miter(this.native)

template `miterWidth=`*(this: SkPaint, miterWidth: float) =
  sk_paint_set_stroke_miter(this.native, miterWidth) 

template strokeCap*(this: SkPaint): SkStrokeCap = 
  sk_paint_get_stroke_cap(this.native).SkStrokeCap

template `strokeCap=`*(this: SkPaint, capType: SkStrokeCap) =
  sk_paint_set_stroke_cap(this.native, capType.sk_stroke_cap_t) 

template joinCap*(this: SkPaint): SkStrokeJoin = 
  sk_paint_get_stroke_join(this.native).SkStrokeJoin

template `joinCap=`*(this: SkPaint, jointType: SkStrokeJoin) =
  sk_paint_set_stroke_join(this.native, jointType.sk_stroke_join_t) 

template textScaleX*(this: SkPaint): float = 
  sk_paint_get_text_scale_x(this.native)

template textEncoding*(this: SkPaint): SkTextEncoding =
  sk_paint_get_text_encoding(this.native).SkTextEncoding

template `textEncoding=`*(this:SkPaint, encoding: SkTextEncoding) =
  sk_paint_set_text_encoding(this.native, cast[sk_text_encoding_t](encoding))

template `typeface=`*(this: SkPaint, newTypeface: SkTypeface) =
  sk_paint_set_typeface(this.native, newTypeface.native)

template subpixelText*(this: SkPaint): bool =
  sk_paint_is_subpixel_text(this.native)

template `subpixelText=`*(this: SkPaint, subpixelText: bool) =
  sk_paint_set_subpixel_text(this.native, subpixelText)

proc clone*(this: SkPaint): SkPaint =
  SkPaint(native: sk_paint_clone(this.native))

proc measureText*(this: SkPaint, text: pointer, length: int, cbounds: SkRect): float =
  return sk_paint_measure_text(
    this.native,
    text,
    length.cint,
    cbounds.native.addr
  )

proc measureText*(this: SkPaint, text: string, length: int, cbounds: SkRect): float =
  return sk_paint_measure_text(
    this.native,
    text.cstring,
    length.cint,
    cbounds.native.addr
  )

proc measureText*(this: SkPaint, text: string): float =
  return sk_paint_measure_text(
    this.native,
    text.cstring,
    len(text).cint,
    nil
  )

proc measureText*(this: SkPaint, text: string, cbounds: var SkRect) =
  discard sk_paint_measure_text(
    this.native,
    text.cstring,
    len(text).cint,
    cbounds.native.addr
  )

proc measureTextBounds*(this: SkPaint, text: string): SkRect =
  result = newSkRect()
  discard sk_paint_measure_text(
    this.native,
    text.cstring,
    len(text).cint,
    result.native.addr
  )

proc `textSize=`*(this: SkPaint, textSize: float) =
  sk_paint_set_textsize(this.native, textSize)

template textSize*(this: SkPaint): float =
  sk_paint_get_textsize(this.native).float

template fontSpacing*(this: SkPaint): float =
  sk_paint_get_fontmetrics(this.native, nil, 0)

proc `textAlign=`*(this: SkPaint, align: SkTextAlign) =
  sk_paint_set_text_align(this.native, align.sk_text_align_t)

proc newSkPaint*(): SkPaint = SkPaint(native: sk_paint_new())

proc newSkPaint*(color: SkColor): SkPaint = 
  result = newSkPaint()
  result.color = color

proc newSkPaint*(a,r,g,b: int): SkPaint = 
  result = newSkPaint()
  result.color = newSkColorARGB(a,r,g,b)
