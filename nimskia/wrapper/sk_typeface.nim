when defined(Linux):
  const dynlibsk_typeface = "libskia.so"
when defined(Windows):
  const dynlibsk_typeface = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_typeface_create_default*(): ptr sk_typeface_t {.cdecl,
    importc: "sk_typeface_create_default", dynlib: dynlibsk_typeface.}
proc sk_typeface_ref_default*(): ptr sk_typeface_t {.cdecl,
    importc: "sk_typeface_ref_default", dynlib: dynlibsk_typeface.}
proc sk_typeface_create_from_name_with_font_style*(familyName: cstring;
    style: ptr sk_fontstyle_t): ptr sk_typeface_t {.cdecl,
    importc: "sk_typeface_create_from_name_with_font_style",
    dynlib: dynlibsk_typeface.}
proc sk_typeface_unref*(a1: ptr sk_typeface_t) {.cdecl, importc: "sk_typeface_unref",
    dynlib: dynlibsk_typeface.}
proc sk_typeface_create_from_file*(path: cstring; index: cint): ptr sk_typeface_t {.
    cdecl, importc: "sk_typeface_create_from_file", dynlib: dynlibsk_typeface.}
proc sk_typeface_create_from_stream*(stream: ptr sk_stream_asset_t; index: cint): ptr sk_typeface_t {.
    cdecl, importc: "sk_typeface_create_from_stream", dynlib: dynlibsk_typeface.}
proc sk_typeface_chars_to_glyphs*(typeface: ptr sk_typeface_t; chars: cstring;
                                 encoding: sk_encoding_t; glyphs: ptr uint16;
                                 glyphCount: cint): cint {.cdecl,
    importc: "sk_typeface_chars_to_glyphs", dynlib: dynlibsk_typeface.}
proc sk_typeface_open_stream*(typeface: ptr sk_typeface_t; ttcIndex: ptr cint): ptr sk_stream_asset_t {.
    cdecl, importc: "sk_typeface_open_stream", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_units_per_em*(typeface: ptr sk_typeface_t): cint {.cdecl,
    importc: "sk_typeface_get_units_per_em", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_family_name*(typeface: ptr sk_typeface_t): ptr sk_string_t {.
    cdecl, importc: "sk_typeface_get_family_name", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_fontstyle*(typeface: ptr sk_typeface_t): ptr sk_fontstyle_t {.
    cdecl, importc: "sk_typeface_get_fontstyle", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_font_weight*(typeface: ptr sk_typeface_t): cint {.cdecl,
    importc: "sk_typeface_get_font_weight", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_font_width*(typeface: ptr sk_typeface_t): cint {.cdecl,
    importc: "sk_typeface_get_font_width", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_font_slant*(typeface: ptr sk_typeface_t): sk_font_style_slant_t {.
    cdecl, importc: "sk_typeface_get_font_slant", dynlib: dynlibsk_typeface.}
proc sk_typeface_count_tables*(typeface: ptr sk_typeface_t): cint {.cdecl,
    importc: "sk_typeface_count_tables", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_table_tags*(typeface: ptr sk_typeface_t;
                                tags: ptr sk_font_table_tag_t): cint {.cdecl,
    importc: "sk_typeface_get_table_tags", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_table_size*(typeface: ptr sk_typeface_t;
                                tag: sk_font_table_tag_t): csize {.cdecl,
    importc: "sk_typeface_get_table_size", dynlib: dynlibsk_typeface.}
proc sk_typeface_get_table_data*(typeface: ptr sk_typeface_t;
                                tag: sk_font_table_tag_t; offset: csize;
                                length: csize; data: pointer): csize {.cdecl,
    importc: "sk_typeface_get_table_data", dynlib: dynlibsk_typeface.}
proc sk_typeface_is_fixed_pitch*(typeface: ptr sk_typeface_t): bool {.cdecl,
    importc: "sk_typeface_is_fixed_pitch", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_create_default*(): ptr sk_fontmgr_t {.cdecl,
    importc: "sk_fontmgr_create_default", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_ref_default*(): ptr sk_fontmgr_t {.cdecl,
    importc: "sk_fontmgr_ref_default", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_unref*(a1: ptr sk_fontmgr_t) {.cdecl, importc: "sk_fontmgr_unref",
    dynlib: dynlibsk_typeface.}
proc sk_fontmgr_count_families*(a1: ptr sk_fontmgr_t): cint {.cdecl,
    importc: "sk_fontmgr_count_families", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_get_family_name*(a1: ptr sk_fontmgr_t; index: cint;
                                familyName: ptr sk_string_t) {.cdecl,
    importc: "sk_fontmgr_get_family_name", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_create_styleset*(a1: ptr sk_fontmgr_t; index: cint): ptr sk_fontstyleset_t {.
    cdecl, importc: "sk_fontmgr_create_styleset", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_match_family*(a1: ptr sk_fontmgr_t; familyName: cstring): ptr sk_fontstyleset_t {.
    cdecl, importc: "sk_fontmgr_match_family", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_match_family_style*(a1: ptr sk_fontmgr_t; familyName: cstring;
                                   style: ptr sk_fontstyle_t): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontmgr_match_family_style", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_match_family_style_character*(a1: ptr sk_fontmgr_t;
    familyName: cstring; style: ptr sk_fontstyle_t; bcp47: cstringArray;
    bcp47Count: cint; character: int32): ptr sk_typeface_t {.cdecl,
    importc: "sk_fontmgr_match_family_style_character", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_match_face_style*(a1: ptr sk_fontmgr_t; face: ptr sk_typeface_t;
                                 style: ptr sk_fontstyle_t): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontmgr_match_face_style", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_create_from_data*(a1: ptr sk_fontmgr_t; data: ptr sk_data_t;
                                 index: cint): ptr sk_typeface_t {.cdecl,
    importc: "sk_fontmgr_create_from_data", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_create_from_stream*(a1: ptr sk_fontmgr_t;
                                   stream: ptr sk_stream_asset_t; index: cint): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontmgr_create_from_stream", dynlib: dynlibsk_typeface.}
proc sk_fontmgr_create_from_file*(a1: ptr sk_fontmgr_t; path: cstring; index: cint): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontmgr_create_from_file", dynlib: dynlibsk_typeface.}
proc sk_fontstyle_new*(weight: cint; width: cint; slant: sk_font_style_slant_t): ptr sk_fontstyle_t {.
    cdecl, importc: "sk_fontstyle_new", dynlib: dynlibsk_typeface.}
proc sk_fontstyle_delete*(fs: ptr sk_fontstyle_t) {.cdecl,
    importc: "sk_fontstyle_delete", dynlib: dynlibsk_typeface.}
proc sk_fontstyle_get_weight*(fs: ptr sk_fontstyle_t): cint {.cdecl,
    importc: "sk_fontstyle_get_weight", dynlib: dynlibsk_typeface.}
proc sk_fontstyle_get_width*(fs: ptr sk_fontstyle_t): cint {.cdecl,
    importc: "sk_fontstyle_get_width", dynlib: dynlibsk_typeface.}
proc sk_fontstyle_get_slant*(fs: ptr sk_fontstyle_t): sk_font_style_slant_t {.cdecl,
    importc: "sk_fontstyle_get_slant", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_create_empty*(): ptr sk_fontstyleset_t {.cdecl,
    importc: "sk_fontstyleset_create_empty", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_unref*(fss: ptr sk_fontstyleset_t) {.cdecl,
    importc: "sk_fontstyleset_unref", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_get_count*(fss: ptr sk_fontstyleset_t): cint {.cdecl,
    importc: "sk_fontstyleset_get_count", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_get_style*(fss: ptr sk_fontstyleset_t; index: cint;
                               fs: ptr sk_fontstyle_t; style: ptr sk_string_t) {.
    cdecl, importc: "sk_fontstyleset_get_style", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_create_typeface*(fss: ptr sk_fontstyleset_t; index: cint): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontstyleset_create_typeface", dynlib: dynlibsk_typeface.}
proc sk_fontstyleset_match_style*(fss: ptr sk_fontstyleset_t;
                                 style: ptr sk_fontstyle_t): ptr sk_typeface_t {.
    cdecl, importc: "sk_fontstyleset_match_style", dynlib: dynlibsk_typeface.}