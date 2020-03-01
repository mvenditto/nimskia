import ../wrapper/sk_types
import ../wrapper/sk_typeface
import internals/native

import sk_enums
import sk_stream
import sk_managedstream
import sk_data
import streams

type
  SkTypeface* = ref object of SkObject[sk_typeface_t]
  SkFontStyle* = ref object of SkObject[sk_fontstyle_t]

template width*(style: SkFontStyle): int = sk_fontstyle_get_width(style.native)
template weight*(style: SkFontStyle): int = sk_fontstyle_get_weight(style.native)
template slant*(style: SkFontStyle): SkFontStyleSlant = sk_fontstyle_get_slant(style.native).SkFontStyleSlant

proc newSkFontStyle*(weight: int, width: int, slant: SkFontStyleSlant): SkFontStyle =
  SkFontStyle(native: sk_fontstyle_new(weight.cint, width.cint, slant.sk_font_style_slant_t))

proc newSkFontStyle*(weight: SkFontStyleWeight, width: SkFontStyleWidth, slant: SkFontStyleSlant): SkFontStyle =
  newSkFontStyle(weight.int, width.int, slant)

proc newSkFontStyle*(): SkFontStyle =
  newSkFontStyle(SkFontStyleWeight.Normal, SkFontStyleWidth.Normal, SkFontStyleSlant.Upright)

proc dispose*(style: SkFontStyle) =
  sk_fontstyle_delete(style.native)

template normalSkFontStyle*(): SkFontStyle = 
  newSkFontStyle()

template boldSkFontStyle*(): SkFontStyle = 
  newSkFontStyle(SkFontStyleWeight.Bold, SkFontStyleWidth.Normal, SkFontStyleSlant.Upright)

template italicSkFontStyle*(): SkFontStyle = 
  newSkFontStyle(SkFontStyleWeight.Normal, SkFontStyleWidth.Normal, SkFontStyleSlant.Italic)

template boldItalicSkFontStyle*(): SkFontStyle = 
  newSkFontStyle(SkFontStyleWeight.Bold, SkFontStyleWidth.Normal, SkFontStyleSlant.Italic)

template skDefaultTypeface* = SkTypeface(native: sk_typeface_ref_default())

proc newSkTypeface*(familyName: string, style: SkFontStyle): SkTypeface =
  assert not isNil style
  SkTypeface(native: sk_typeface_create_from_name_with_font_style(familyName.cstring, style.native))

proc newSkTypeface*(familyName: string): SkTypeface =
  SkTypeface(native: sk_typeface_create_from_name_with_font_style(
      familyName.cstring, 
      normalSkFontStyle.native
    )
  )

proc newSkTypeface*(familyName: string, weight: int, width: int, slant: SkFontStyleSlant): SkTypeface =
  newSkTypeface(familyName, newSkFontStyle(weight, width, slant))

proc loadSkTypeFace*(path: string, index: int = 0): SkTypeface =
  SkTypeface(native: sk_typeface_create_from_file(path.cstring, index.cint))

proc loadSkTypeFace*(stream: Stream, index: int = 0): SkTypeface =
  let managed = newSkManagedStream(stream, false)
  result = SkTypeface(native: sk_typeface_create_from_stream(cast[ptr sk_stream_asset_t](managed.native), index.cint))
  managed.dispose()

proc loadSkTypeFace*(stream: SkStreamAsset, index: int = 0): SkTypeface =
  assert not isNil stream
  # is managed check
  result = SkTypeface(native: sk_typeface_create_from_stream(cast[ptr sk_stream_asset_t](stream.native), index.cint))
  
proc loadSkTypeFace*(data: SkData): SkTypeface = 
  let stream = newSkMemoryStream(data)
  result = loadSkTypeFace(stream)
  stream.dispose()
