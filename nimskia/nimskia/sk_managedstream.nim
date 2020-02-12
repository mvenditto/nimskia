import ../wrapper/sk_managedstream
import ../wrapper/sk_stream as sk_stream_bindings
import ../wrapper/sk_types

import sk_stream

import system
import streams

type

  SKManagedStreamObj* = object of SKStreamAsset
    onReadImpl*: proc(s: SKManagedStream, buff: pointer, size: int): int
    onPeekImpl*: proc(s: SKManagedStream, buff: pointer, size: int): int
    onIsAtEndImpl*: proc(s: SKManagedStream): bool
    onHasPositionImpl*: proc(s: SKManagedStream): bool
    onHasLengthImpl*: proc(s: SKManagedStream): bool
    onRewindImpl*: proc(s: SKManagedStream): bool
    onGetPositionImpl*: proc(s: SKManagedStream): int
    onGetLengthImpl*: proc(s: SKManagedStream): int
    onSeekImpl*: proc(s: SKManagedStream, position: int): bool
    onMoveImpl*: proc(s: SKManagedStream, offset: int): bool
    onCreateNewImpl*: proc(s: SKManagedStream): SKManagedStream

  SKManagedStream* = ref object of SKManagedStreamObj
    test: int
    stream: Stream

proc onFork*(s: SKManagedStream): SKManagedStream =
  var stream = s.onCreateNewImpl(s)
  discard sk_stream_seek(
    cast[ptr sk_stream_t](stream.native), 
    sk_stream_get_position(s.native)  
  )
  stream

proc onDuplicate*(s: SKManagedStream): SKManagedStream =
  s.onCreateNewImpl(s);
  
proc dispose*(s: SKManagedStream) =
  sk_managedstream_destroy(cast[ptr sk_stream_managedstream_t](s.native))

proc getStreamFromCtx(context: pointer): SKManagedStream =
  cast[ref SKManagedStream](context)[]

proc readProc(s: ptr sk_stream_managedstream_t, context: pointer, buffer: pointer, size: int): int {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onReadImpl(stream, buffer, size)

proc peekProc(s: ptr sk_stream_managedstream_t;context: pointer; buffer: pointer; size: int): int {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onPeekImpl(stream, buffer, size)

proc isAtEndProc(s: ptr sk_stream_managedstream_t;context: pointer): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onIsAtEndImpl(stream)

proc hasPositionProc(s: ptr sk_stream_managedstream_t;context: pointer): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onHasPositionImpl(stream)

proc hasLengthProc(s: ptr sk_stream_managedstream_t;context: pointer): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onHasLengthImpl(stream)

proc rewindProc(s: ptr sk_stream_managedstream_t;context: pointer): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onRewindImpl(stream)

proc getPositionProc(s: ptr sk_stream_managedstream_t;context: pointer): int {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onGetPositionImpl(stream)

proc seekProc(s: ptr sk_stream_managedstream_t;context: pointer, position: int): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onSeekImpl(stream, position)

proc moveProc(s: ptr sk_stream_managedstream_t;context: pointer, offset: int): bool {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onMoveImpl(stream, offset)

proc getLengthProc(s: ptr sk_stream_managedstream_t;context: pointer): int {.cdecl.} =
  var stream = getStreamFromCtx(context)
  stream.onGetLengthImpl(stream)

proc duplicateProc(s: ptr sk_stream_managedstream_t;context: pointer): ptr sk_stream_managedstream_t {.cdecl.} =
  var stream = getStreamFromCtx(context)
  cast[ptr sk_stream_managedstream_t](stream.onDuplicate().native)

proc forkProc(s: ptr sk_stream_managedstream_t;context: pointer): ptr sk_stream_managedstream_t {.cdecl.} =
  var stream = getStreamFromCtx(context)
  cast[ptr sk_stream_managedstream_t](stream.onFork().native)

proc destroyProc(s: ptr sk_stream_managedstream_t;context: pointer) {.cdecl.} =
  var stream = getStreamFromCtx(context)
  if not isNil stream.native:
    stream.dispose()
  dealloc(context)

system.once:
  var procs = new sk_managedstream_procs_t
  procs.fRead = readProc
  procs.fPeek = peekProc
  procs.fIsAtEnd = isAtEndProc
  procs.fDestroy = destroyProc
  procs.fIsAtEnd = isAtEndProc
  procs.fHasPosition = hasPositionProc
  procs.fHasLength = hasLengthProc
  procs.fRewind = rewindProc
  procs.fGetPosition = getPositionProc
  procs.fSeek = seekProc
  procs.fMove = moveProc
  procs.fGetLength = getLengthProc
  procs.fDuplicate = duplicateProc
  procs.fFork = forkProc
  procs.fDestroy = destroyProc
  sk_managedstream_set_procs(procs[])

proc newSKManagedStreamInternal*(): SKManagedStream = 
  var x = cast[ptr SKManagedStream](alloc(sizeof(SKManagedStream)))
  x[] = SKManagedStream(
    native: cast[ptr sk_stream_t](sk_managedstream_new(x)))
  x[]

proc read(s: SKManagedStream, buff: pointer, length: int): int =
  s.stream.readData(buff, length)

proc atEnd(s: SKManagedStream): bool = s.atEnd()

proc newSKManagedStream*(stream: Stream): SKManagedStream =
  result = newSKManagedStreamInternal()
  result.stream = stream
  result.onReadImpl = read
  result.onIsAtEndImpl = atEnd
