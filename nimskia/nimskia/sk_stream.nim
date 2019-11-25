import ../wrapper/sk_stream
import ../wrapper/sk_types

type
  SKStream* = concept s
    (s.native is ptr sk_stream_t) or
    (s.native is ptr sk_stream_filestream_t) or
    (s.native is ptr sk_stream_memorystream_t) 

proc isAtEnd*(this: SKStream): bool =
  sk_stream_is_at_end(
    cast[ptr sk_stream_t](this.native))

proc hasPosition*(this: SKStream): bool =
  sk_stream_has_position(
    cast[ptr sk_stream_t](this.native))

proc hasLength*(this: SKStream): bool =
  sk_stream_has_length(
    cast[ptr sk_stream_t](this.native))

proc position*(this: SKStream): int32 =
  sk_stream_get_position(
    cast[ptr sk_stream_t](this.native)).int32

proc length*(this: SKStream): int32 =
  sk_stream_get_length(
    cast[ptr sk_stream_t](this.native)).int32

proc len*(this: SKStream): int32 = 
  length(this)

proc readByte*(this: SKStream, buffer: var int8): bool =
  sk_stream_read_s8(
    cast[ptr sk_stream_t](this.native), buffer.addr)
  
proc readInt16*(this: SKStream, buffer: var int16): bool =
  sk_stream_read_s16(
    cast[ptr sk_stream_t](this.native), buffer.addr)

proc readInt32*(this: SKStream, buffer: var int32): bool =
  sk_stream_read_s32(
    cast[ptr sk_stream_t](this.native), buffer.addr)

proc readUByte*(this: SKStream, buffer: var uint8): bool =
  sk_stream_read_u8(
    cast[ptr sk_stream_t](this.native), buffer.addr)
  
proc readUInt16*(this: SKStream, buffer: var uint16): bool =
  sk_stream_read_u16(
    cast[ptr sk_stream_t](this.native), buffer.addr)

proc readUInt32*(this: SKStream, buffer: var uint32): bool =
  sk_stream_read_u32(
    cast[ptr sk_stream_t](this.native), buffer.addr)

proc readBool*(this: SKStream, buffer: var bool): bool = 
  sk_stream_read_bool(
    cast[ptr sk_stream_t](this.native), buffer.addr)

###

proc readByte*(this: SKStream): int8 =
  result = default int8
  discard this.readByte(result)
  
proc readInt16*(this: SKStream): int16 =
  result = default int16
  discard this.readInt16(result)

proc readInt32*(this: SKStream): int32 =
  result = default int32
  discard this.readInt32(result)

proc readUByte*(this: SKStream): uint8 =
  result = default uint8
  discard this.readUByte(result)
  
proc readUInt16*(this: SKStream): uint16 =
  result = default uint16
  discard this.readUInt16(result)

proc readUInt32*(this: SKStream): uint32 =
  result = default uint32
  discard this.readUInt32(result)

proc readBool*(this: SKStream): bool =
  result = default bool
  discard this.readBool(result)

proc read*(this: SKStream, buffer: pointer, size: int32): int =
  sk_stream_read(
    cast[ptr sk_stream_t](this.native), buffer, size)

proc peek*(this: SKStream, buffer: pointer, size: int32): int =
  sk_stream_peek(
    cast[ptr sk_stream_t](this.native), buffer, size)

proc skip*(this: SKStream, size: int32): int =
  sk_stream_skip(
    cast[ptr sk_stream_t](this.native), size)

proc rewind*(this: SKStream): bool =
  sk_stream_rewind(
    cast[ptr sk_stream_t](this.native))

proc seek*(this: SKStream, position: int32): bool =
  sk_stream_seek(
    cast[ptr sk_stream_t](this.native), position)

proc move*(this: SKStream, offset: int32): bool =
  sk_stream_move(
    cast[ptr sk_stream_t](this.native), offset)

proc memoryBase*(this: SKStream): pointer =
  sk_stream_get_memory_base(
    cast[ptr sk_stream_t](this.native))

proc fork*(this: SKStream): SKStream =
  new(result)
  result.native = sk_stream_fork(
    cast[ptr sk_stream_t](this.native))

proc duplicate*(this: SKStream): SKStream =
  new(result)
  result.native = sk_stream_duplicate(
    cast[ptr sk_stream_t](this.native)) 

proc dispose*(this: SKStream) =
  sk_stream_destroy(
    cast[ptr sk_stream_t](this.native))

type
  SKFileStream* = ref object
    native*: ptr sk_stream_filestream_t

proc newSKFileStream*(path: string): SKFileStream =
  new(result)
  result.native = sk_filestream_new(path)

proc dispose*(this: SKFileStream) =
  sk_filestream_destroy(this.native)
  
proc isValid*(this: SKFileStream): bool =
  sk_filestream_is_valid(this.native)

proc test() =
  var fs = newSKFileStream("../docs/images/skia.png")
  assert not isNil fs.native
  echo $(fs.isValid)
  echo $len(fs)
  dispose(fs)

test()

  




