import ../wrapper/[
  sk_types,
  sk_typeface,
  sk_string
]

import internals/native
import internals/exceptions

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
  SkTypeface(native: sk_typeface_create_from_file(path, index.cint))

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

proc openStream*(face: SkTypeface): (SkStreamAsset, int) =
  var ttcIndex: cint = 0
  var stream = SkStreamAsset(native: 
      cast[ptr sk_stream_t](sk_typeface_open_stream(face.native, ttcIndex.addr))
  )

  (stream, ttcIndex.int)

proc familyName*(face: SkTypeface): string = 
  let famNameSk = sk_typeface_get_family_name(face.native)
  result = $sk_string_get_c_str(famNameSk)
  sk_string_destructor(famNameSk)

template fontStyle*(face: SkTypeface): SkFontStyle = SkFontStyle(native: sk_typeface_get_fontstyle(face.native))

template fontWidth*(face: SkTypeface): int = sk_typeface_get_font_width(face.native).int

template fontWeight*(face: SkTypeface): int = sk_typeface_get_font_weight(face.native).int

template fontSlant*(face: SkTypeface): SkFontStyleSlant = sk_typeface_get_font_slant(face.native).SkFontStyleSlant

template isBold*(face: SkTypeface): bool = cast[cint](face.fontStyle.weight) >= cast[cint](SKFontStyleWeight.SemiBold)

template isItalic*(face: SkTypeface): bool = face.fontStyle.slant != SKFontStyleSlant.Upright

template isFixedPitch*(face: SkTypeface): bool = sk_typeface_is_fixed_pitch(face.native)

template unitsPerEm*(face: SkTypeface): int = sk_typeface_get_units_per_em(face.native)

template tableCount*(face: SkTypeface): int = sk_typeface_count_tables(face.native)

template getTableSize*(face: SkTypeface, tag: uint32): int = sk_typeface_get_table_size(face.native, tag)

proc tryGetTableTags*(face: SkTypeface, tags: var seq[uint32]): bool =
  var buff = newSeqUninitialized[uint32](face.tableCount)
  if sk_typeface_get_table_tags(face.native, buff[0].unsafeAddr) == 0:
    return false
  tags = buff
  return true

proc getTableTags*(face: SkTypeface): seq[uint32] = 
    var tags: seq[uint32]
    if not tryGetTableTags(face, tags):
      raise newException(NativeError, "Unable to read the tables for the file.")
    return tags

proc tryGetTableData*(face: SkTypeface, tag: uint32, offset: int, length: int, tableData: var ptr UncheckedArray[byte]): bool =
  tableData = cast[ptr UncheckedArray[byte]](alloc(length))
  let actual = sk_typeface_get_table_data(
    face.native,
    tag,
    offset.cint,
    length.cint,
    tableData
  )
  result = actual != 0

  if not result:
    dealloc(tableData)

proc tryGetTableData*(face: SkTypeface, tag: uint32, tableData: var seq[byte]): bool = 
    let length = face.getTableSize(tag)
    var buffer: ptr UncheckedArray[byte]
    if not tryGetTableData(face, tag, 0, length, buffer):
      return false
    tableData = newSeqUninitialized[byte](length)
    copyMem(tableData[0].unsafeAddr, buffer.addr, length)
    dealloc(buffer)
    return true

proc countGlyphs*(face: SkTypeface, str: string, strLen: int, encoding: SkEncoding): int = 
    sk_typeface_chars_to_glyphs(face.native, str, encoding.sk_encoding_t, nil, strLen.cint)

proc countGlyphs*(face: SkTypeface, str: string, encoding: SkEncoding): int = 
    countGlyphs(face, str, str.len, encoding)

proc getGlyphs*(face: SkTypeface, text: string, length: int, encoding: SkEncoding, glyphs: var seq[uint16]): int =
  
  let n = sk_typeface_chars_to_glyphs(
    face.native,
    text,
    encoding.sk_encoding_t,
    nil,
    length.cint
  )

  if n <= 0:
    glyphs = newSeq[uint16]()
    return 0
  
  glyphs = newSeq[uint16](n)

  return sk_typeface_chars_to_glyphs(
    face.native,
    text,
    encoding.sk_encoding_t,
    glyphs[0].unsafeAddr,
    n.cint
  )

proc getGlyphs*(face: SkTypeface, text: string, encoding: SkEncoding, glyphs: var seq[uint16]): int =
  getGlyphs(face, text, text.len, encoding, glyphs)

proc getGlyphs*(face: SkTypeface, text: string): seq[uint16] =
  discard face.getGlyphs(text, SkEncoding.Utf16, result)
  result
