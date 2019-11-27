import ../wrapper/sk_stream
import ../wrapper/sk_types
import internals/native

type
  # still not good enough, more work needed here
  
  SKStream* = ref object of SKObject[sk_stream_t]
    isAtEndImpl*: proc(s: SKStream): bool {.nimcall.}
    readImpl*: proc(s: SKStream, buffer: pointer, size: int): int {.nimcall.}
    peekImpl*: proc(s: SKStream, buffer: pointer, size: int): int {.nimcall.}
    skipImpl*: proc(s: SKStream, size:int):int {.nimcall.}
    readBoolImpl*: proc(s: SKStream, buffer: var bool):bool {.nimcall.}
    readByteImpl*: proc(s: SKStream, buffer: var int8):bool {.nimcall.}
    readInt16Impl*: proc(s: SKStream, buffer: var int16):bool {.nimcall.}
    readInt32Impl*: proc(s: SKStream, buffer: var int32):bool {.nimcall.}
    readUByteImpl*: proc(s: SKStream, buffer: var uint8):bool {.nimcall.}
    readUInt16Impl*: proc(s: SKStream, buffer: var uint16):bool {.nimcall.}
    readUInt32Impl*: proc(s: SKStream, buffer: var uint32):bool {.nimcall.}
  
  SKStreamRewindable* = ref object of SKStream
    rewindImpl*: proc(s: SKStream): bool {.nimcall.}
    duplicateImpl*: proc(s: SKStream): SKStreamRewindable {.nimcall.}
  
  SKStreamSeekable* = ref object of SKStreamRewindable
    seekImpl*: proc(s: SKStream, position:int): bool {.nimcall.}
    moveImpl*: proc(s: SKStream, offset:int): bool {.nimcall.}
    forkImpl*: proc(s: SKStream): SKStreamSeekable {.nimcall.}
    hasPositionImpl*: proc(s: SKStream): bool {.nimcall.}
    getPositionImpl*: proc(s: SKStream):int {.nimcall.}
  
  SKStreamAsset* = ref object of SKStreamSeekable
    hasLengthImpl*: proc(s: SKStream): bool {.nimcall.}
    getLengthImpl*: proc(s: SKStream):int {.nimcall.}

  SKFileStream* = ref object of SKStreamAsset


proc isAtEnd*(s: SKStream): bool =
  if not isNil s.isAtEndImpl: 
    return s.isAtEndImpl(s) 
  sk_stream_is_at_end(cast[ptr sk_stream_t](s.native))

proc hasPosition*(s: SKStreamSeekable): bool =
  if not isNil s.hasPositionImpl: 
    return s.hasPositionImpl(s)
  sk_stream_has_position(cast[ptr sk_stream_t](s.native))

proc hasLength*(s: SKStreamAsset): bool =
  if not isNil s.hasLengthImpl:
    return s.hasLengthImpl(s)
  sk_stream_has_length(cast[ptr sk_stream_t](s.native))

proc getPosition*(s: SKStreamSeekable):int =
  if not isNil s.getPositionImpl:
    return s.getPositionImpl(s)
  sk_stream_get_position(cast[ptr sk_stream_t](s.native)).int32

proc getLength*(s: SKStreamAsset):int =
  if not isNil s.getLengthImpl:
    return s.getLengthImpl(s)
  sk_stream_get_length(cast[ptr sk_stream_t](s.native)).int32

proc read*(s: SKStream, buffer: pointer, size: int): int =
  if not isNil s.readImpl:
    return s.readImpl(s, buffer, size)
  sk_stream_read(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc peek*(s: SKStream, buffer: pointer, size:int): int =
  if not isNil s.peekImpl:
    return s.peekImpl(s, buffer, size)
  sk_stream_peek(
    cast[ptr sk_stream_t](s.native), buffer, size)

proc readByte*(s: SKStream, buffer: var int8): bool =
  if not isNil s.readByteImpl:
    return s.readByteImpl(s, buffer)
  sk_stream_read_s8(cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt16*(s: SKStream, buffer: var int16): bool =
  if not isNil s.readInt16Impl:
    return s.readInt16Impl(s, buffer)
  sk_stream_read_s16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readInt32*(s: SKStream, buffer: var int32): bool =
  if not isNil s.readInt32Impl:
    return s.readInt32Impl(s, buffer)
  sk_stream_read_s32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUByte*(s: SKStream, buffer: var uint8): bool =
  if not isNil s.readUByteImpl:
    return s.readUByteImpl(s, buffer)
  sk_stream_read_u8(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt16*(s: SKStream, buffer: var uint16): bool =
  if not isNil s.readUInt16Impl:
    return s.readUInt16Impl(s, buffer)
  sk_stream_read_u16(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readUInt32*(s: SKStream, buffer: var uint32): bool =
  if not isNil s.readUInt32Impl:
    return s.readUInt32Impl(s, buffer)
  sk_stream_read_u32(
    cast[ptr sk_stream_t](s.native), buffer.addr)

proc readBool*(s: SKStream, buffer: var bool): bool = 
  if not isNil s.readBoolImpl:
    return s.readBoolImpl(s, buffer)
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
  if not isNil s.skipImpl:
    return s.skipImpl(s, size) 
  sk_stream_skip(
    cast[ptr sk_stream_t](s.native), size)

proc rewind*(s: SKStreamRewindable): bool =
  if not isNil s.rewindImpl:
    return s.rewindImpl(s) 
  sk_stream_rewind(
    cast[ptr sk_stream_t](s.native))

proc seek*(s: SKStreamSeekable, position:int): bool =
  if not isNil s.seekImpl:
    return s.seekImpl(s, position)
  sk_stream_seek(
    cast[ptr sk_stream_t](s.native), position)

proc move*(s: SKStreamSeekable, offset:int): bool =
  if not isNil s.moveImpl:
    return s.moveImpl(s, offset)
  sk_stream_move(
    cast[ptr sk_stream_t](s.native), offset)

discard """
proc memoryBase*(s: SKStream): pointer =
  sk_stream_get_memory_base(
    cast[ptr sk_stream_t](s.native))
"""

proc fork*(s: SKStreamSeekable): SKStreamSeekable =
  if not isNil s.forkImpl:
    result = s.forkImpl(s)
  else:
    new(result)
    result.native = sk_stream_fork(
      cast[ptr sk_stream_t](s.native))

proc duplicate*(s: SKStreamRewindable): SKStreamRewindable =
  if not isNil s.duplicateImpl:
    result = s.duplicateImpl(s)
  else:
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
  echo "new file stream created: " & path
  new(result)
  result.native = cast[ptr sk_stream_t](sk_filestream_new(path))




