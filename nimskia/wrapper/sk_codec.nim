when defined(Linux):
  const dynlibsk_codec = "libskia.so"
when defined(Windows):
  const dynlibsk_codec = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_codec_min_buffered_bytes_needed*(): csize {.cdecl,
    importc: "sk_codec_min_buffered_bytes_needed", dynlib: dynlibsk_codec.}
proc sk_codec_new_from_stream*(stream: ptr sk_stream_t;
                              result: ptr sk_codec_result_t): ptr sk_codec_t {.cdecl,
    importc: "sk_codec_new_from_stream", dynlib: dynlibsk_codec.}
proc sk_codec_new_from_data*(data: ptr sk_data_t): ptr sk_codec_t {.cdecl,
    importc: "sk_codec_new_from_data", dynlib: dynlibsk_codec.}
proc sk_codec_destroy*(codec: ptr sk_codec_t) {.cdecl, importc: "sk_codec_destroy",
    dynlib: dynlibsk_codec.}
proc sk_codec_get_info*(codec: ptr sk_codec_t; info: ptr sk_imageinfo_t) {.cdecl,
    importc: "sk_codec_get_info", dynlib: dynlibsk_codec.}
proc sk_codec_get_origin*(codec: ptr sk_codec_t): sk_encodedorigin_t {.cdecl,
    importc: "sk_codec_get_origin", dynlib: dynlibsk_codec.}
proc sk_codec_get_scaled_dimensions*(codec: ptr sk_codec_t; desiredScale: cfloat;
                                    dimensions: ptr sk_isize_t) {.cdecl,
    importc: "sk_codec_get_scaled_dimensions", dynlib: dynlibsk_codec.}
proc sk_codec_get_valid_subset*(codec: ptr sk_codec_t; desiredSubset: ptr sk_irect_t): bool {.
    cdecl, importc: "sk_codec_get_valid_subset", dynlib: dynlibsk_codec.}
proc sk_codec_get_encoded_format*(codec: ptr sk_codec_t): sk_encoded_image_format_t {.
    cdecl, importc: "sk_codec_get_encoded_format", dynlib: dynlibsk_codec.}
proc sk_codec_get_pixels*(codec: ptr sk_codec_t; info: ptr sk_imageinfo_t;
                         pixels: pointer; rowBytes: csize;
                         options: ptr sk_codec_options_t): sk_codec_result_t {.
    cdecl, importc: "sk_codec_get_pixels", dynlib: dynlibsk_codec.}
proc sk_codec_start_incremental_decode*(codec: ptr sk_codec_t;
                                       info: ptr sk_imageinfo_t; pixels: pointer;
                                       rowBytes: csize;
                                       options: ptr sk_codec_options_t): sk_codec_result_t {.
    cdecl, importc: "sk_codec_start_incremental_decode", dynlib: dynlibsk_codec.}
proc sk_codec_incremental_decode*(codec: ptr sk_codec_t; rowsDecoded: ptr cint): sk_codec_result_t {.
    cdecl, importc: "sk_codec_incremental_decode", dynlib: dynlibsk_codec.}
proc sk_codec_start_scanline_decode*(codec: ptr sk_codec_t;
                                    info: ptr sk_imageinfo_t;
                                    options: ptr sk_codec_options_t): sk_codec_result_t {.
    cdecl, importc: "sk_codec_start_scanline_decode", dynlib: dynlibsk_codec.}
proc sk_codec_get_scanlines*(codec: ptr sk_codec_t; dst: pointer; countLines: cint;
                            rowBytes: csize): cint {.cdecl,
    importc: "sk_codec_get_scanlines", dynlib: dynlibsk_codec.}
proc sk_codec_skip_scanlines*(codec: ptr sk_codec_t; countLines: cint): bool {.cdecl,
    importc: "sk_codec_skip_scanlines", dynlib: dynlibsk_codec.}
proc sk_codec_get_scanline_order*(codec: ptr sk_codec_t): sk_codec_scanline_order_t {.
    cdecl, importc: "sk_codec_get_scanline_order", dynlib: dynlibsk_codec.}
proc sk_codec_next_scanline*(codec: ptr sk_codec_t): cint {.cdecl,
    importc: "sk_codec_next_scanline", dynlib: dynlibsk_codec.}
proc sk_codec_output_scanline*(codec: ptr sk_codec_t; inputScanline: cint): cint {.
    cdecl, importc: "sk_codec_output_scanline", dynlib: dynlibsk_codec.}
proc sk_codec_get_frame_count*(codec: ptr sk_codec_t): cint {.cdecl,
    importc: "sk_codec_get_frame_count", dynlib: dynlibsk_codec.}
proc sk_codec_get_frame_info*(codec: ptr sk_codec_t;
                             frameInfo: ptr sk_codec_frameinfo_t) {.cdecl,
    importc: "sk_codec_get_frame_info", dynlib: dynlibsk_codec.}
proc sk_codec_get_frame_info_for_index*(codec: ptr sk_codec_t; index: cint;
                                       frameInfo: ptr sk_codec_frameinfo_t): bool {.
    cdecl, importc: "sk_codec_get_frame_info_for_index", dynlib: dynlibsk_codec.}
proc sk_codec_get_repetition_count*(codec: ptr sk_codec_t): cint {.cdecl,
    importc: "sk_codec_get_repetition_count", dynlib: dynlibsk_codec.}