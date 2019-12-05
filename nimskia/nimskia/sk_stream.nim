import ../wrapper/sk_stream
import ../wrapper/sk_types
import internals/native

type
  # still not good enough, more work needed here
  
  SKStream* = ref object of SKObject[sk_stream_t]
  
  SKStreamRewindable* = ref object of SKStream
  
  SKStreamSeekable* = ref object of SKStreamRewindable
  
  SKStreamAsset* = ref object of SKStreamSeekable

  SKFileStream* = ref object of SKStreamAsset


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
  



