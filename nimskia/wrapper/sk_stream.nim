when defined(Linux):
  const dynlibsk_stream = "libskia.so"
when defined(Windows):
  const dynlibsk_stream = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_stream_asset_destroy*(cstream: ptr sk_stream_asset_t) {.cdecl,
    importc: "sk_stream_asset_destroy", dynlib: dynlibsk_stream.}
proc sk_filestream_new*(path: cstring): ptr sk_stream_filestream_t {.cdecl,
    importc: "sk_filestream_new", dynlib: dynlibsk_stream.}
proc sk_filestream_destroy*(cstream: ptr sk_stream_filestream_t) {.cdecl,
    importc: "sk_filestream_destroy", dynlib: dynlibsk_stream.}
proc sk_filestream_is_valid*(cstream: ptr sk_stream_filestream_t): bool {.cdecl,
    importc: "sk_filestream_is_valid", dynlib: dynlibsk_stream.}
proc sk_memorystream_new*(): ptr sk_stream_memorystream_t {.cdecl,
    importc: "sk_memorystream_new", dynlib: dynlibsk_stream.}
proc sk_memorystream_new_with_length*(length: csize): ptr sk_stream_memorystream_t {.
    cdecl, importc: "sk_memorystream_new_with_length", dynlib: dynlibsk_stream.}
proc sk_memorystream_new_with_data*(data: pointer; length: csize; copyData: bool): ptr sk_stream_memorystream_t {.
    cdecl, importc: "sk_memorystream_new_with_data", dynlib: dynlibsk_stream.}
proc sk_memorystream_new_with_skdata*(data: ptr sk_data_t): ptr sk_stream_memorystream_t {.
    cdecl, importc: "sk_memorystream_new_with_skdata", dynlib: dynlibsk_stream.}
proc sk_memorystream_set_memory*(cmemorystream: ptr sk_stream_memorystream_t;
                                data: pointer; length: csize; copyData: bool) {.cdecl,
    importc: "sk_memorystream_set_memory", dynlib: dynlibsk_stream.}
proc sk_memorystream_destroy*(cstream: ptr sk_stream_memorystream_t) {.cdecl,
    importc: "sk_memorystream_destroy", dynlib: dynlibsk_stream.}
proc sk_stream_read*(cstream: ptr sk_stream_t; buffer: pointer; size: csize): csize {.
    cdecl, importc: "sk_stream_read", dynlib: dynlibsk_stream.}
proc sk_stream_peek*(cstream: ptr sk_stream_t; buffer: pointer; size: csize): csize {.
    cdecl, importc: "sk_stream_peek", dynlib: dynlibsk_stream.}
proc sk_stream_skip*(cstream: ptr sk_stream_t; size: csize): csize {.cdecl,
    importc: "sk_stream_skip", dynlib: dynlibsk_stream.}
proc sk_stream_is_at_end*(cstream: ptr sk_stream_t): bool {.cdecl,
    importc: "sk_stream_is_at_end", dynlib: dynlibsk_stream.}
proc sk_stream_read_s8*(cstream: ptr sk_stream_t; buffer: ptr int8): bool {.cdecl,
    importc: "sk_stream_read_s8", dynlib: dynlibsk_stream.}
proc sk_stream_read_s16*(cstream: ptr sk_stream_t; buffer: ptr int16): bool {.cdecl,
    importc: "sk_stream_read_s16", dynlib: dynlibsk_stream.}
proc sk_stream_read_s32*(cstream: ptr sk_stream_t; buffer: ptr int32): bool {.cdecl,
    importc: "sk_stream_read_s32", dynlib: dynlibsk_stream.}
proc sk_stream_read_u8*(cstream: ptr sk_stream_t; buffer: ptr uint8): bool {.cdecl,
    importc: "sk_stream_read_u8", dynlib: dynlibsk_stream.}
proc sk_stream_read_u16*(cstream: ptr sk_stream_t; buffer: ptr uint16): bool {.cdecl,
    importc: "sk_stream_read_u16", dynlib: dynlibsk_stream.}
proc sk_stream_read_u32*(cstream: ptr sk_stream_t; buffer: ptr uint32): bool {.cdecl,
    importc: "sk_stream_read_u32", dynlib: dynlibsk_stream.}
proc sk_stream_read_bool*(cstream: ptr sk_stream_t; buffer: ptr bool): bool {.cdecl,
    importc: "sk_stream_read_bool", dynlib: dynlibsk_stream.}
proc sk_stream_rewind*(cstream: ptr sk_stream_t): bool {.cdecl,
    importc: "sk_stream_rewind", dynlib: dynlibsk_stream.}
proc sk_stream_has_position*(cstream: ptr sk_stream_t): bool {.cdecl,
    importc: "sk_stream_has_position", dynlib: dynlibsk_stream.}
proc sk_stream_get_position*(cstream: ptr sk_stream_t): csize {.cdecl,
    importc: "sk_stream_get_position", dynlib: dynlibsk_stream.}
proc sk_stream_seek*(cstream: ptr sk_stream_t; position: csize): bool {.cdecl,
    importc: "sk_stream_seek", dynlib: dynlibsk_stream.}
proc sk_stream_move*(cstream: ptr sk_stream_t; offset: clong): bool {.cdecl,
    importc: "sk_stream_move", dynlib: dynlibsk_stream.}
proc sk_stream_has_length*(cstream: ptr sk_stream_t): bool {.cdecl,
    importc: "sk_stream_has_length", dynlib: dynlibsk_stream.}
proc sk_stream_get_length*(cstream: ptr sk_stream_t): csize {.cdecl,
    importc: "sk_stream_get_length", dynlib: dynlibsk_stream.}
proc sk_stream_get_memory_base*(cstream: ptr sk_stream_t): pointer {.cdecl,
    importc: "sk_stream_get_memory_base", dynlib: dynlibsk_stream.}
proc sk_stream_fork*(cstream: ptr sk_stream_t): ptr sk_stream_t {.cdecl,
    importc: "sk_stream_fork", dynlib: dynlibsk_stream.}
proc sk_stream_duplicate*(cstream: ptr sk_stream_t): ptr sk_stream_t {.cdecl,
    importc: "sk_stream_duplicate", dynlib: dynlibsk_stream.}
proc sk_stream_destroy*(cstream: ptr sk_stream_t) {.cdecl,
    importc: "sk_stream_destroy", dynlib: dynlibsk_stream.}
proc sk_filewstream_new*(path: cstring): ptr sk_wstream_filestream_t {.cdecl,
    importc: "sk_filewstream_new", dynlib: dynlibsk_stream.}
proc sk_filewstream_destroy*(cstream: ptr sk_wstream_filestream_t) {.cdecl,
    importc: "sk_filewstream_destroy", dynlib: dynlibsk_stream.}
proc sk_filewstream_is_valid*(cstream: ptr sk_wstream_filestream_t): bool {.cdecl,
    importc: "sk_filewstream_is_valid", dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_new*(): ptr sk_wstream_dynamicmemorystream_t {.cdecl,
    importc: "sk_dynamicmemorywstream_new", dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_detach_as_stream*(
    cstream: ptr sk_wstream_dynamicmemorystream_t): ptr sk_stream_asset_t {.cdecl,
    importc: "sk_dynamicmemorywstream_detach_as_stream", dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_detach_as_data*(
    cstream: ptr sk_wstream_dynamicmemorystream_t): ptr sk_data_t {.cdecl,
    importc: "sk_dynamicmemorywstream_detach_as_data", dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_copy_to*(cstream: ptr sk_wstream_dynamicmemorystream_t;
                                     data: pointer) {.cdecl,
    importc: "sk_dynamicmemorywstream_copy_to", dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_write_to_stream*(
    cstream: ptr sk_wstream_dynamicmemorystream_t; dst: ptr sk_wstream_t): bool {.
    cdecl, importc: "sk_dynamicmemorywstream_write_to_stream",
    dynlib: dynlibsk_stream.}
proc sk_dynamicmemorywstream_destroy*(cstream: ptr sk_wstream_dynamicmemorystream_t) {.
    cdecl, importc: "sk_dynamicmemorywstream_destroy", dynlib: dynlibsk_stream.}
proc sk_wstream_write*(cstream: ptr sk_wstream_t; buffer: pointer; size: csize): bool {.
    cdecl, importc: "sk_wstream_write", dynlib: dynlibsk_stream.}
proc sk_wstream_newline*(cstream: ptr sk_wstream_t): bool {.cdecl,
    importc: "sk_wstream_newline", dynlib: dynlibsk_stream.}
proc sk_wstream_flush*(cstream: ptr sk_wstream_t) {.cdecl,
    importc: "sk_wstream_flush", dynlib: dynlibsk_stream.}
proc sk_wstream_bytes_written*(cstream: ptr sk_wstream_t): csize {.cdecl,
    importc: "sk_wstream_bytes_written", dynlib: dynlibsk_stream.}
proc sk_wstream_write_8*(cstream: ptr sk_wstream_t; value: uint8): bool {.cdecl,
    importc: "sk_wstream_write_8", dynlib: dynlibsk_stream.}
proc sk_wstream_write_16*(cstream: ptr sk_wstream_t; value: uint16): bool {.cdecl,
    importc: "sk_wstream_write_16", dynlib: dynlibsk_stream.}
proc sk_wstream_write_32*(cstream: ptr sk_wstream_t; value: uint32): bool {.cdecl,
    importc: "sk_wstream_write_32", dynlib: dynlibsk_stream.}
proc sk_wstream_write_text*(cstream: ptr sk_wstream_t; value: cstring): bool {.cdecl,
    importc: "sk_wstream_write_text", dynlib: dynlibsk_stream.}
proc sk_wstream_write_dec_as_text*(cstream: ptr sk_wstream_t; value: int32): bool {.
    cdecl, importc: "sk_wstream_write_dec_as_text", dynlib: dynlibsk_stream.}
proc sk_wstream_write_bigdec_as_text*(cstream: ptr sk_wstream_t; value: int64;
                                     minDigits: cint): bool {.cdecl,
    importc: "sk_wstream_write_bigdec_as_text", dynlib: dynlibsk_stream.}
proc sk_wstream_write_hex_as_text*(cstream: ptr sk_wstream_t; value: uint32;
                                  minDigits: cint): bool {.cdecl,
    importc: "sk_wstream_write_hex_as_text", dynlib: dynlibsk_stream.}
proc sk_wstream_write_scalar_as_text*(cstream: ptr sk_wstream_t; value: cfloat): bool {.
    cdecl, importc: "sk_wstream_write_scalar_as_text", dynlib: dynlibsk_stream.}
proc sk_wstream_write_bool*(cstream: ptr sk_wstream_t; value: bool): bool {.cdecl,
    importc: "sk_wstream_write_bool", dynlib: dynlibsk_stream.}
proc sk_wstream_write_scalar*(cstream: ptr sk_wstream_t; value: cfloat): bool {.cdecl,
    importc: "sk_wstream_write_scalar", dynlib: dynlibsk_stream.}
proc sk_wstream_write_packed_uint*(cstream: ptr sk_wstream_t; value: csize): bool {.
    cdecl, importc: "sk_wstream_write_packed_uint", dynlib: dynlibsk_stream.}
proc sk_wstream_write_stream*(cstream: ptr sk_wstream_t; input: ptr sk_stream_t;
                             length: csize): bool {.cdecl,
    importc: "sk_wstream_write_stream", dynlib: dynlibsk_stream.}
proc sk_wstream_get_size_of_packed_uint*(value: csize): cint {.cdecl,
    importc: "sk_wstream_get_size_of_packed_uint", dynlib: dynlibsk_stream.}