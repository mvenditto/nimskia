import ../wrapper/sk_stream
import ../wrapper/sk_types

import internals/[
  native, 
  exceptions
]

import sk_data

type
  # still not good enough, more work needed here
  
  SKStream* = ref object of SKObject[sk_stream_t]

  SKWStream* = ref object of SKObject[sk_wstream_t]
  
  SKStreamRewindable* = ref object of SKStream
  
  SKStreamSeekable* = ref object of SKStreamRewindable
  
  SKStreamAsset* = ref object of SKStreamSeekable

  SKFileStream* = ref object of SKStreamAsset

  SKMemoryStream* = ref object of SKStreamAsset

  SKFileWStream* = ref object of SKWStream


proc isAtEnd*(s: SKStream): bool =
  sk_stream_is_at_end(cast[ptr sk_stream_t](s.native))

proc hasPosition*(s: SKStreamSeekable): bool =
  sk_stream_has_position(cast[ptr sk_stream_t](s.native))

proc hasLength*(s: SKStreamAsset): bool =
  sk_stream_has_length(cast[ptr sk_stream_t](s.native))

proc getPosition*(s: SKStreamSeekable):int =
  sk_stream_get_position(cast[ptr sk_stream_t](s.native)).int32

proc getLength*(s: SKStreamAsset):int =
  sk_stream_get_length(cast[ptr sk_stream_t](s.native)).int32

proc read*(s: SKStream, buffer: pointer, size: int): int =
  sk_stream_read(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc peek*(s: SKStream, buffer: pointer, size:int): int =
  sk_stream_peek(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc readByte*(s: SKStream, buffer: var int8): bool =
  sk_stream_read_s8(cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt16*(s: SKStream, buffer: var int16): bool =
  sk_stream_read_s16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt32*(s: SKStream, buffer: var int32): bool =
  sk_stream_read_s32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUByte*(s: SKStream, buffer: var uint8): bool =
  sk_stream_read_u8(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt16*(s: SKStream, buffer: var uint16): bool =
  sk_stream_read_u16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt32*(s: SKStream, buffer: var uint32): bool =
  sk_stream_read_u32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readBool*(s: SKStream, buffer: var bool): bool = 
  sk_stream_read_bool(
    cast[ptr sk_stream_t](s.native), buffer.addr)

# helpers
proc readByte*(s: SKStream): int8 =
  result = default int8
  discard s.readByte(result)
  
proc readInt16*(s: SKStream): int16 =
  result = default int16
  discard s.readInt16(result)

proc readInt32*(s: SKStream): int32 =
  result = default int32
  discard s.readInt32(result)

proc readUByte*(s: SKStream): uint8 =
  result = default uint8
  discard s.readUByte(result)
  
proc readUInt16*(s: SKStream): uint16 =
  result = default uint16
  discard s.readUInt16(result)

proc readUInt32*(s: SKStream): uint32 =
  result = default uint32
  discard s.readUInt32(result)

proc readBool*(s: SKStream): bool =
  result = default bool
  discard s.readBool(result)

proc skip*(s: SKStream, size:int): int =
   
  sk_stream_skip(
    cast[ptr sk_stream_t](s.native), size)

proc rewind*(s: SKStreamRewindable): bool =
   
  sk_stream_rewind(
    cast[ptr sk_stream_t](s.native))

proc seek*(s: SKStreamSeekable, position:int): bool =
  
  sk_stream_seek(
    cast[ptr sk_stream_t](s.native), position)

proc move*(s: SKStreamSeekable, offset:int): bool =
  
  sk_stream_move(
    cast[ptr sk_stream_t](s.native), offset)

discard """
proc memoryBase*(s: SKStream): pointer =
  sk_stream_get_memory_base(
    cast[ptr sk_stream_t](s.native))
"""

proc fork*(s: SKStreamSeekable): SKStreamSeekable =
  new(result) 
  result.native = sk_stream_fork(
      cast[ptr sk_stream_t](s.native))

proc duplicate*(s: SKStreamRewindable): SKStreamRewindable =
  new(result)
  result.native = sk_stream_duplicate(
    cast[ptr sk_stream_t](s.native)) 

proc dispose*(s: SKStream) =
    sk_stream_destroy(s.native)
      
# SKFileStream

proc dispose*(s: SKFileStream) =
  sk_filestream_destroy(
    cast[ptr sk_stream_filestream_t](s.native))
  
proc isValid*(s: SKFileStream): bool =
  sk_filestream_is_valid(
    cast[ptr sk_stream_filestream_t](s.native))

proc newSKFileStream*(path: string): SKFileStream =
  new(result)
  result.native = cast[ptr sk_stream_t](sk_filestream_new(path))
  
proc openSKFileStream*(path: string): SKFileStream =
  let fs = newSKFileStream(path)
  if not fs.isValid():
    fs.dispose()
    return nil
  return fs

# SKMemoryStream

proc checkCreated(s: SKMemoryStream) =
  if isNil s.native:
    raise newException(UnsupportedOperationError, "Cannot create new SKMemoryStream instance.")

proc newSKMemoryStream*(): SKMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](sk_memorystream_new())
  checkCreated(result)

proc newSKMemoryStream*(length: int): SKMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_length(length))
  checkCreated(result)

proc newSKMemoryStream*(data: pointer, length: int, copyData: bool): SKMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_data(data, length, copyData)
  )
  checkCreated(result)

proc newSKMemoryStream*(data: SKData): SKMemoryStream =
  new(result)
  result.native = cast[ptr sk_stream_t](
    sk_memorystream_new_with_skdata(data.native)
  )
  checkCreated(result)

proc dispose*(s: SKMemoryStream) =
  sk_memorystream_destroy(
    cast[ptr sk_stream_memorystream_t](s.native))

proc setMemory*(s: SKMemoryStream, data: pointer, length: int, copyData: bool = false) = 
  sk_memorystream_set_memory(cast[ptr sk_stream_memorystream_t](s.native), data, length, copyData)

proc setMemory*(s: SKMemoryStream, data: seq[byte], copyData: bool = false) =
  s.setMemory(cast[pointer](data[0].unsafeAddr), data.len, copyData)

proc newSKMemoryStream*(data: seq[byte]): SKMemoryStream =
  result = newSKMemoryStream()
  result.setMemory(data, true)

# SKWStream

proc write8*(s: SKWStream, value: uint8): bool =
  sk_wstream_write_8(s.native, value)

proc write16*(s: SKWStream, value: uint16): bool =
  sk_wstream_write_16(s.native, value)

proc write32*(s: SKWStream, value: uint32): bool =
  sk_wstream_write_32(s.native, value)

proc writeText*(s: SKWStream, value: string): bool =
  sk_wstream_write_text(s.native, value)

proc writeDecimalAsText*(s: SKWStream, value: int32): bool =
  sk_wstream_write_dec_as_text(s.native, value)

proc writeBigDecimalAsText*(s: SKWStream, value: int64, digits: int32): bool =
  sk_wstream_write_bigdec_as_text(s.native, value, digits)

proc writeHexAsText*(s: SKWStream, value: uint32, digits: int32): bool = 
  sk_wstream_write_hex_as_text(s.native, value, digits)

proc writeScalarAsText*(s: SKWStream, value: float): bool = 
  sk_wstream_write_scalar_as_text(s.native, value)

proc writeBool*(s: SKWStream, value: bool): bool =
  sk_wstream_write_bool(s.native, value)

proc writeScalar*(s: SKWStream, value: float): bool = 
  sk_wstream_write_scalar(s.native, value)

proc writeStream*(s: SKWStream, input: SKStream, length: int): bool = 
  sk_wstream_write_stream(s.native, input.native, length)

proc newSKFileWStream*(path: string): SKFileWStream =
  new(result)
  result.native = cast[ptr sk_wstream_t](sk_filewstream_new(path))
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create new SKFileWStream instance.")

proc dispose*(s: SKFileWStream) =
  sk_filewstream_destroy(cast[ptr sk_wstream_filestream_t](s.native))

template isValid*(s: SKFileWStream): bool =
  sk_filewstream_is_valid(cast[ptr sk_wstream_filestream_t](s.native))

proc openSKFileWStream*(path: string): SKFileWStream =
  var stream = newSKFileWStream(path)
  if not stream.isValid:
    stream.dispose()
    stream = nil
  return stream










  



