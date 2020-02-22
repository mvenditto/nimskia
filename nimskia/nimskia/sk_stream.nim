import ../wrapper/sk_stream
import ../wrapper/sk_types

import internals/[
  native, 
  exceptions
]

import sk_data

type
  # still not good enough, more work needed here
  
  SkStream* = ref object of SkObject[sk_stream_t]

  SkWStream* = ref object of SkObject[sk_wstream_t]
  
  SkStreamRewindable* = ref object of SkStream
  
  SkStreamSeekable* = ref object of SkStreamRewindable
  
  SkStreamAsset* = ref object of SkStreamSeekable

  SkFileStream* = ref object of SkStreamAsset

  SkMemoryStream* = ref object of SkStreamAsset

  SkFileWStream* = ref object of SkWStream


proc isAtEnd*(s: SkStream): bool =
  sk_stream_is_at_end(cast[ptr sk_stream_t](s.native))

proc hasPosition*(s: SkStreamSeekable): bool =
  sk_stream_has_position(cast[ptr sk_stream_t](s.native))

proc hasLength*(s: SkStreamAsset): bool =
  sk_stream_has_length(cast[ptr sk_stream_t](s.native))

proc getPosition*(s: SkStreamSeekable):int =
  sk_stream_get_position(cast[ptr sk_stream_t](s.native)).int32

proc getLength*(s: SkStreamAsset):int =
  sk_stream_get_length(cast[ptr sk_stream_t](s.native)).int32

proc read*(s: SkStream, buffer: pointer, size: int): int =
  sk_stream_read(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc peek*(s: SkStream, buffer: pointer, size:int): int =
  sk_stream_peek(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc readByte*(s: SkStream, buffer: var int8): bool =
  sk_stream_read_s8(cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt16*(s: SkStream, buffer: var int16): bool =
  sk_stream_read_s16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt32*(s: SkStream, buffer: var int32): bool =
  sk_stream_read_s32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUByte*(s: SkStream, buffer: var uint8): bool =
  sk_stream_read_u8(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt16*(s: SkStream, buffer: var uint16): bool =
  sk_stream_read_u16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt32*(s: SkStream, buffer: var uint32): bool =
  sk_stream_read_u32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readBool*(s: SkStream, buffer: var bool): bool = 
  sk_stream_read_bool(
    cast[ptr sk_stream_t](s.native), buffer.addr)

# helpers
proc readByte*(s: SkStream): int8 =
  result = default int8
  discard s.readByte(result)
  
proc readInt16*(s: SkStream): int16 =
  result = default int16
  discard s.readInt16(result)

proc readInt32*(s: SkStream): int32 =
  result = default int32
  discard s.readInt32(result)

proc readUByte*(s: SkStream): uint8 =
  result = default uint8
  discard s.readUByte(result)
  
proc readUInt16*(s: SkStream): uint16 =
  result = default uint16
  discard s.readUInt16(result)

proc readUInt32*(s: SkStream): uint32 =
  result = default uint32
  discard s.readUInt32(result)

proc readBool*(s: SkStream): bool =
  result = default bool
  discard s.readBool(result)

proc skip*(s: SkStream, size:int): int =
   
  sk_stream_skip(
    cast[ptr sk_stream_t](s.native), size)

proc rewind*(s: SkStreamRewindable): bool =
   
  sk_stream_rewind(
    cast[ptr sk_stream_t](s.native))

proc seek*(s: SkStreamSeekable, position:int): bool =
  
  sk_stream_seek(
    cast[ptr sk_stream_t](s.native), position)

proc move*(s: SkStreamSeekable, offset:int): bool =
  
  sk_stream_move(
    cast[ptr sk_stream_t](s.native), offset)

discard """
proc memoryBase*(s: SkStream): pointer =
  sk_stream_get_memory_base(
    cast[ptr sk_stream_t](s.native))
"""

proc fork*(s: SkStreamSeekable): SkStreamSeekable =
  new(result) 
  result.native = sk_stream_fork(
      cast[ptr sk_stream_t](s.native))

proc duplicate*(s: SkStreamRewindable): SkStreamRewindable =
  new(result)
  result.native = sk_stream_duplicate(
    cast[ptr sk_stream_t](s.native)) 

proc dispose*(s: SkStream) =
    sk_stream_destroy(s.native)
      
# SkFileStream

proc dispose*(s: SkFileStream) =
  sk_filestream_destroy(
    cast[ptr sk_stream_filestream_t](s.native))
  
proc isValid*(s: SkFileStream): bool =
  sk_filestream_is_valid(
    cast[ptr sk_stream_filestream_t](s.native))

proc newSkFileStream*(path: string): SkFileStream =
  new(result)
  result.native = cast[ptr sk_stream_t](sk_filestream_new(path))
  
proc openSkFileStream*(path: string): SkFileStream =
  let fs = newSkFileStream(path)
  if not fs.isValid():
    fs.dispose()
    return nil
  return fs

# SkMemoryStream

proc checkCreated(s: SkMemoryStream) =
  if isNil s.native:
    raise newException(UnsupportedOperationError, "Cannot create new SkMemoryStream instance.")

proc newSkMemoryStream*(): SkMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](sk_memorystream_new())
  checkCreated(result)

proc newSkMemoryStream*(length: int): SkMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_length(length))
  checkCreated(result)

proc newSkMemoryStream*(data: pointer, length: int, copyData: bool): SkMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_data(data, length, copyData)
  )
  checkCreated(result)

proc newSkMemoryStream*(data: SkData): SkMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_skdata(data.native)
  )
  checkCreated(result)

proc dispose*(s: SkMemoryStream) =
  sk_memorystream_destroy(
    cast[ptr sk_stream_memorystream_t](s.native))

proc setMemory*(s: SkMemoryStream, data: pointer, length: int, copyData: bool = false) = 
  sk_memorystream_set_memory(cast[ptr sk_stream_memorystream_t](s.native), data, length, copyData)

proc setMemory*(s: SkMemoryStream, data: seq[byte], copyData: bool = false) =
  s.setMemory(cast[pointer](data[0].unsafeAddr), data.len, copyData)

proc newSkMemoryStream*(data: seq[byte]): SkMemoryStream =
  result = newSkMemoryStream()
  result.setMemory(data, true)

# SkWStream

proc write8*(s: SkWStream, value: uint8): bool =
  sk_wstream_write_8(s.native, value)

proc write16*(s: SkWStream, value: uint16): bool =
  sk_wstream_write_16(s.native, value)

proc write32*(s: SkWStream, value: uint32): bool =
  sk_wstream_write_32(s.native, value)

proc writeText*(s: SkWStream, value: string): bool =
  sk_wstream_write_text(s.native, value)

proc writeDecimalAsText*(s: SkWStream, value: int32): bool =
  sk_wstream_write_dec_as_text(s.native, value)

proc writeBigDecimalAsText*(s: SkWStream, value: int64, digits: int32): bool =
  sk_wstream_write_bigdec_as_text(s.native, value, digits)

proc writeHexAsText*(s: SkWStream, value: uint32, digits: int32): bool = 
  sk_wstream_write_hex_as_text(s.native, value, digits)

proc writeScalarAsText*(s: SkWStream, value: float): bool = 
  sk_wstream_write_scalar_as_text(s.native, value)

proc writeBool*(s: SkWStream, value: bool): bool =
  sk_wstream_write_bool(s.native, value)

proc writeScalar*(s: SkWStream, value: float): bool = 
  sk_wstream_write_scalar(s.native, value)

proc writeStream*(s: SkWStream, input: SkStream, length: int): bool = 
  sk_wstream_write_stream(s.native, input.native, length)

proc newSkFileWStream*(path: string): SkFileWStream =
  new(result)
  result.native = cast[ptr sk_wstream_t](sk_filewstream_new(path))
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create new SkFileWStream instance.")

proc dispose*(s: SkFileWStream) =
  sk_filewstream_destroy(cast[ptr sk_wstream_filestream_t](s.native))

template isValid*(s: SkFileWStream): bool =
  sk_filewstream_is_valid(cast[ptr sk_wstream_filestream_t](s.native))

proc openSkFileWStream*(path: string): SkFileWStream =
  var stream = newSkFileWStream(path)
  if not stream.isValid:
    stream.dispose()
    stream = nil
  return stream










  



