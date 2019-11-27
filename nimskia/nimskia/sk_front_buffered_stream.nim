import sk_stream

const
  DefaultBufferSize* = 4096

type
  SkFrontBufferedStream* = ref object of SKStreamRewindable
    underlyingStream: SKStream
    totalBufferSize: int64
    totalLength: int64
    currentOffset: int64
    bufferedSoFar: int64
    internalBuffer: ptr UncheckedArray[byte]

proc dispose*(s: SkFrontBufferedStream, disposeUnderlyingStream: bool) =
  dealloc(s.internalBuffer)
  if disposeUnderlyingStream:
    s.underlyingStream.dispose()

proc newFrontBufferedStream*(stream: SKStream, bufferSize: int64): SkFrontBufferedStream =
  new(result)
  result.native = stream.native
  result.underlyingStream = stream
  result.totalBufferSize = bufferSize
 
  if (stream is SKStreamAsset):
    var seekable = cast[SKStreamAsset](stream)
    if seekable.hasPosition(): result.totalLength = seekable.getLength()
  else:
    result.totalLength = -1
  
  result.currentOffset = 0
  result.bufferedSoFar = 0
  result.internalBuffer = cast[ptr UncheckedArray[byte]](alloc(bufferSize))

proc readFromBuffer(s: SkFrontBufferedStream, dst: pointer, size: int): int = 
    assert s.currentOffset < s.bufferedSoFar

    let bytesToCopy = min(size, s.bufferedSoFar - s.currentOffset)
    
    if not isNil dst:
      copyMem(dst, s.internalBuffer[s.currentOffset].addr, size)

    s.currentOffset += bytesToCopy

    assert s.currentOffset <= s.bufferedSoFar

    return bytesToCopy.int

proc bufferAndWriteTo(s: SkFrontBufferedStream, dst: pointer, size: int): int = 
    assert size > 0
    assert s.currentOffset >= s.bufferedSoFar
    assert not isNil s.underlyingStream

    let bytesToBuffer = min(size, s.totalBufferSize - s.bufferedSoFar).int
    var buffer: pointer = s.internalBuffer[s.currentOffset].addr
    var buffered = read(s, buffer, bytesToBuffer)
    s.bufferedSoFar += buffered
    s.currentOffset = s.bufferedSoFar
    assert s.bufferedSoFar <= s.totalBufferSize
    if not isNil dst:
      copyMem(dst, buffer, buffered)
    return buffered.int
    
proc readDirectlyFromStream(s: SkFrontBufferedStream, dst: pointer, size: int): int = 
    assert size > 0
    assert (s.totalBufferSize == s.bufferedSoFar and s.currentOffset >= s.totalBufferSize)
    let bytesReadDirectly = s.underlyingStream.read(dst, size)
    s.currentOffset += bytesReadDirectly
    if bytesReadDirectly > 0:
      dispose(s, disposeUnderlyingStream=false)
    return bytesReadDirectly.int

proc isAtEndFbs(s: SkFrontBufferedStream): bool =
  if s.currentOffset < s.bufferedSoFar:
    return false
  s.underlyingStream.isAtEnd()

proc rewindFbs(s: SkFrontBufferedStream): bool =
  if s.currentOffset <= s.totalBufferSize:
    s.currentOffset = 0
    return true
  return false

proc readFbs(s: SkFrontBufferedStream, buffer: pointer, size: int): int =
  discard 

proc peekFbs(s: SkFrontBufferedStream, buffer: pointer, size: int): int =
  let start: int = s.currentOffset.int
  if start >= s.totalBufferSize:
    return 0
  let ssize = min(size, s.totalBufferSize - start).int
  let bytesRead: int = s.readFbs(buffer, ssize)
  s.currentOffset = ssize
  return bytesRead



  

  

  




