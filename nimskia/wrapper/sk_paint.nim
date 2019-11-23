when defined(Linux):
  const dynlibsk_paint = "libskia.so"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
proc sk_paint_new*(): ptr sk_paint_t {.cdecl, importc: "sk_paint_new",
                                   dynlib: dynlibsk_paint.}
proc sk_paint_clone*(a1: ptr sk_paint_t): ptr sk_paint_t {.cdecl,
    importc: "sk_paint_clone", dynlib: dynlibsk_paint.}
proc sk_paint_delete*(a1: ptr sk_paint_t) {.cdecl, importc: "sk_paint_delete",
                                        dynlib: dynlibsk_paint.}
proc sk_paint_reset*(a1: ptr sk_paint_t) {.cdecl, importc: "sk_paint_reset",
                                       dynlib: dynlibsk_paint.}
proc sk_paint_is_antialias*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_antialias", dynlib: dynlibsk_paint.}
proc sk_paint_set_antialias*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_antialias", dynlib: dynlibsk_paint.}
proc sk_paint_get_color*(a1: ptr sk_paint_t): sk_color_t {.cdecl,
    importc: "sk_paint_get_color", dynlib: dynlibsk_paint.}
proc sk_paint_set_color*(a1: ptr sk_paint_t; a2: sk_color_t) {.cdecl,
    importc: "sk_paint_set_color", dynlib: dynlibsk_paint.}
proc sk_paint_get_style*(a1: ptr sk_paint_t): sk_paint_style_t {.cdecl,
    importc: "sk_paint_get_style", dynlib: dynlibsk_paint.}
proc sk_paint_set_style*(a1: ptr sk_paint_t; a2: sk_paint_style_t) {.cdecl,
    importc: "sk_paint_set_style", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_width*(a1: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_stroke_width", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_width*(a1: ptr sk_paint_t; width: cfloat) {.cdecl,
    importc: "sk_paint_set_stroke_width", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_miter*(a1: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_stroke_miter", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_miter*(a1: ptr sk_paint_t; miter: cfloat) {.cdecl,
    importc: "sk_paint_set_stroke_miter", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_cap*(a1: ptr sk_paint_t): sk_stroke_cap_t {.cdecl,
    importc: "sk_paint_get_stroke_cap", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_cap*(a1: ptr sk_paint_t; a2: sk_stroke_cap_t) {.cdecl,
    importc: "sk_paint_set_stroke_cap", dynlib: dynlibsk_paint.}
proc sk_paint_get_stroke_join*(a1: ptr sk_paint_t): sk_stroke_join_t {.cdecl,
    importc: "sk_paint_get_stroke_join", dynlib: dynlibsk_paint.}
proc sk_paint_set_stroke_join*(a1: ptr sk_paint_t; a2: sk_stroke_join_t) {.cdecl,
    importc: "sk_paint_set_stroke_join", dynlib: dynlibsk_paint.}
proc sk_paint_set_shader*(a1: ptr sk_paint_t; a2: ptr sk_shader_t) {.cdecl,
    importc: "sk_paint_set_shader", dynlib: dynlibsk_paint.}
proc sk_paint_set_maskfilter*(a1: ptr sk_paint_t; a2: ptr sk_maskfilter_t) {.cdecl,
    importc: "sk_paint_set_maskfilter", dynlib: dynlibsk_paint.}
proc sk_paint_set_blendmode*(a1: ptr sk_paint_t; a2: sk_blendmode_t) {.cdecl,
    importc: "sk_paint_set_blendmode", dynlib: dynlibsk_paint.}
proc sk_paint_is_dither*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_dither", dynlib: dynlibsk_paint.}
proc sk_paint_set_dither*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_dither", dynlib: dynlibsk_paint.}
proc sk_paint_is_verticaltext*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_verticaltext", dynlib: dynlibsk_paint.}
proc sk_paint_set_verticaltext*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_verticaltext", dynlib: dynlibsk_paint.}
proc sk_paint_get_shader*(a1: ptr sk_paint_t): ptr sk_shader_t {.cdecl,
    importc: "sk_paint_get_shader", dynlib: dynlibsk_paint.}
proc sk_paint_get_maskfilter*(a1: ptr sk_paint_t): ptr sk_maskfilter_t {.cdecl,
    importc: "sk_paint_get_maskfilter", dynlib: dynlibsk_paint.}
proc sk_paint_set_colorfilter*(a1: ptr sk_paint_t; a2: ptr sk_colorfilter_t) {.cdecl,
    importc: "sk_paint_set_colorfilter", dynlib: dynlibsk_paint.}
proc sk_paint_get_colorfilter*(a1: ptr sk_paint_t): ptr sk_colorfilter_t {.cdecl,
    importc: "sk_paint_get_colorfilter", dynlib: dynlibsk_paint.}
proc sk_paint_set_imagefilter*(a1: ptr sk_paint_t; a2: ptr sk_imagefilter_t) {.cdecl,
    importc: "sk_paint_set_imagefilter", dynlib: dynlibsk_paint.}
proc sk_paint_get_imagefilter*(a1: ptr sk_paint_t): ptr sk_imagefilter_t {.cdecl,
    importc: "sk_paint_get_imagefilter", dynlib: dynlibsk_paint.}
proc sk_paint_get_blendmode*(a1: ptr sk_paint_t): sk_blendmode_t {.cdecl,
    importc: "sk_paint_get_blendmode", dynlib: dynlibsk_paint.}
proc sk_paint_set_filter_quality*(a1: ptr sk_paint_t; a2: sk_filter_quality_t) {.
    cdecl, importc: "sk_paint_set_filter_quality", dynlib: dynlibsk_paint.}
proc sk_paint_get_filter_quality*(a1: ptr sk_paint_t): sk_filter_quality_t {.cdecl,
    importc: "sk_paint_get_filter_quality", dynlib: dynlibsk_paint.}
proc sk_paint_get_typeface*(a1: ptr sk_paint_t): ptr sk_typeface_t {.cdecl,
    importc: "sk_paint_get_typeface", dynlib: dynlibsk_paint.}
proc sk_paint_set_typeface*(a1: ptr sk_paint_t; a2: ptr sk_typeface_t) {.cdecl,
    importc: "sk_paint_set_typeface", dynlib: dynlibsk_paint.}
proc sk_paint_get_textsize*(a1: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_textsize", dynlib: dynlibsk_paint.}
proc sk_paint_set_textsize*(a1: ptr sk_paint_t; a2: cfloat) {.cdecl,
    importc: "sk_paint_set_textsize", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_align*(a1: ptr sk_paint_t): sk_text_align_t {.cdecl,
    importc: "sk_paint_get_text_align", dynlib: dynlibsk_paint.}
proc sk_paint_set_text_align*(a1: ptr sk_paint_t; a2: sk_text_align_t) {.cdecl,
    importc: "sk_paint_set_text_align", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_encoding*(a1: ptr sk_paint_t): sk_text_encoding_t {.cdecl,
    importc: "sk_paint_get_text_encoding", dynlib: dynlibsk_paint.}
proc sk_paint_set_text_encoding*(a1: ptr sk_paint_t; a2: sk_text_encoding_t) {.cdecl,
    importc: "sk_paint_set_text_encoding", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_scale_x*(cpaint: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_text_scale_x", dynlib: dynlibsk_paint.}
proc sk_paint_set_text_scale_x*(cpaint: ptr sk_paint_t; scale: cfloat) {.cdecl,
    importc: "sk_paint_set_text_scale_x", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_skew_x*(cpaint: ptr sk_paint_t): cfloat {.cdecl,
    importc: "sk_paint_get_text_skew_x", dynlib: dynlibsk_paint.}
proc sk_paint_set_text_skew_x*(cpaint: ptr sk_paint_t; skew: cfloat) {.cdecl,
    importc: "sk_paint_set_text_skew_x", dynlib: dynlibsk_paint.}
proc sk_paint_break_text*(cpaint: ptr sk_paint_t; text: pointer; length: csize;
                         maxWidth: cfloat; measuredWidth: ptr cfloat): csize {.cdecl,
    importc: "sk_paint_break_text", dynlib: dynlibsk_paint.}
proc sk_paint_measure_text*(cpaint: ptr sk_paint_t; text: pointer; length: csize;
                           cbounds: ptr sk_rect_t): cfloat {.cdecl,
    importc: "sk_paint_measure_text", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_path*(cpaint: ptr sk_paint_t; text: pointer; length: csize;
                            x: cfloat; y: cfloat): ptr sk_path_t {.cdecl,
    importc: "sk_paint_get_text_path", dynlib: dynlibsk_paint.}
proc sk_paint_get_pos_text_path*(cpaint: ptr sk_paint_t; text: pointer; length: csize;
                                pos: ptr sk_point_t): ptr sk_path_t {.cdecl,
    importc: "sk_paint_get_pos_text_path", dynlib: dynlibsk_paint.}
proc sk_paint_get_fontmetrics*(cpaint: ptr sk_paint_t;
                              cfontmetrics: ptr sk_fontmetrics_t; scale: cfloat): cfloat {.
    cdecl, importc: "sk_paint_get_fontmetrics", dynlib: dynlibsk_paint.}
proc sk_paint_get_path_effect*(cpaint: ptr sk_paint_t): ptr sk_path_effect_t {.cdecl,
    importc: "sk_paint_get_path_effect", dynlib: dynlibsk_paint.}
proc sk_paint_set_path_effect*(cpaint: ptr sk_paint_t; effect: ptr sk_path_effect_t) {.
    cdecl, importc: "sk_paint_set_path_effect", dynlib: dynlibsk_paint.}
proc sk_paint_is_linear_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_linear_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_linear_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_linear_text", dynlib: dynlibsk_paint.}
proc sk_paint_is_subpixel_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_subpixel_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_subpixel_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_subpixel_text", dynlib: dynlibsk_paint.}
proc sk_paint_is_lcd_render_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_lcd_render_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_lcd_render_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_lcd_render_text", dynlib: dynlibsk_paint.}
proc sk_paint_is_embedded_bitmap_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_embedded_bitmap_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_embedded_bitmap_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_embedded_bitmap_text", dynlib: dynlibsk_paint.}
proc sk_paint_get_hinting*(a1: ptr sk_paint_t): sk_paint_hinting_t {.cdecl,
    importc: "sk_paint_get_hinting", dynlib: dynlibsk_paint.}
proc sk_paint_set_hinting*(a1: ptr sk_paint_t; a2: sk_paint_hinting_t) {.cdecl,
    importc: "sk_paint_set_hinting", dynlib: dynlibsk_paint.}
proc sk_paint_is_autohinted*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_autohinted", dynlib: dynlibsk_paint.}
proc sk_paint_set_autohinted*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_autohinted", dynlib: dynlibsk_paint.}
proc sk_paint_is_fake_bold_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_fake_bold_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_fake_bold_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_fake_bold_text", dynlib: dynlibsk_paint.}
proc sk_paint_is_dev_kern_text*(a1: ptr sk_paint_t): bool {.cdecl,
    importc: "sk_paint_is_dev_kern_text", dynlib: dynlibsk_paint.}
proc sk_paint_set_dev_kern_text*(a1: ptr sk_paint_t; a2: bool) {.cdecl,
    importc: "sk_paint_set_dev_kern_text", dynlib: dynlibsk_paint.}
proc sk_paint_get_fill_path*(a1: ptr sk_paint_t; src: ptr sk_path_t;
                            dst: ptr sk_path_t; cullRect: ptr sk_rect_t;
                            resScale: cfloat): bool {.cdecl,
    importc: "sk_paint_get_fill_path", dynlib: dynlibsk_paint.}
proc sk_paint_text_to_glyphs*(cpaint: ptr sk_paint_t; text: pointer;
                             byteLength: csize; glyphs: ptr uint16): cint {.cdecl,
    importc: "sk_paint_text_to_glyphs", dynlib: dynlibsk_paint.}
proc sk_paint_contains_text*(cpaint: ptr sk_paint_t; text: pointer; byteLength: csize): bool {.
    cdecl, importc: "sk_paint_contains_text", dynlib: dynlibsk_paint.}
proc sk_paint_count_text*(cpaint: ptr sk_paint_t; text: pointer; byteLength: csize): cint {.
    cdecl, importc: "sk_paint_count_text", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_widths*(cpaint: ptr sk_paint_t; text: pointer;
                              byteLength: csize; widths: ptr cfloat;
                              bounds: ptr sk_rect_t): cint {.cdecl,
    importc: "sk_paint_get_text_widths", dynlib: dynlibsk_paint.}
proc sk_paint_get_text_intercepts*(cpaint: ptr sk_paint_t; text: pointer;
                                  byteLength: csize; x: cfloat; y: cfloat;
                                  bounds: array[2, cfloat]; intervals: ptr cfloat): cint {.
    cdecl, importc: "sk_paint_get_text_intercepts", dynlib: dynlibsk_paint.}
proc sk_paint_get_pos_text_intercepts*(cpaint: ptr sk_paint_t; text: pointer;
                                      byteLength: csize; pos: ptr sk_point_t;
                                      bounds: array[2, cfloat];
                                      intervals: ptr cfloat): cint {.cdecl,
    importc: "sk_paint_get_pos_text_intercepts", dynlib: dynlibsk_paint.}
proc sk_paint_get_pos_text_h_intercepts*(cpaint: ptr sk_paint_t; text: pointer;
                                        byteLength: csize; xpos: ptr cfloat;
                                        y: cfloat; bounds: array[2, cfloat];
                                        intervals: ptr cfloat): cint {.cdecl,
    importc: "sk_paint_get_pos_text_h_intercepts", dynlib: dynlibsk_paint.}
proc sk_paint_get_pos_text_blob_intercepts*(cpaint: ptr sk_paint_t;
    blob: ptr sk_textblob_t; bounds: array[2, cfloat]; intervals: ptr cfloat): cint {.
    cdecl, importc: "sk_paint_get_pos_text_blob_intercepts", dynlib: dynlibsk_paint.}