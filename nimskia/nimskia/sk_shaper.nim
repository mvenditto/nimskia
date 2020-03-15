import ../extra/harfbuzz/[
  buffer,
  face,
  font,
  blob
]

import sk_typeface
import sk_stream
import sk_paint
import sk_point
import sk_enums
import sugar

type
  SkShaper* = ref object
    font: Font
    buffer: Buffer
    typeface*: SkTypeface

const
  FontSizeScale = 512

proc fromCString(p: pointer, len: int): string =
  result = newString(len)
  copyMem(result.cstring, p, len)

proc toHarfBuffBlob*(stream: SkStreamAsset): Blob =

  assert stream.native != nil

  let size = stream.getLength()

  var 
    blob: Blob
    memoryBase = stream.memoryBase

  if not isNil memoryBase:
    blob = newBlob(
      fromCString(memoryBase, size), 
      size.cuint, 
      ReadOnly, 
      (ctx: pointer) => stream.dispose()
    )
  else:
    var buff = alloc(size)
    discard stream.read(buff, size)
    
    blob = newBlob(
      fromCString(buff, size), 
      size.cuint, 
      ReadOnly, 
      (ctx: pointer) => dealloc(buff)
    )

  return blob

proc newSkShaper*(typeface: SkTypeface): SkShaper =
  assert not isNil typeface
  new(result)
  result.typeface = typeface

  var 
    stream: SkStreamAsset
    face: Face
    index: int

  try:
    (stream, index) = result.typeface.openStream()
    let blob = stream.toHarfBuffBlob()
    face = newFace(blob, index.uint)
    face.index = index.uint
    face.unitsPerEm = typeface.unitsPerEm.uint
    result.font = newFont(face)
    result.font.scale = (FontSizeScale, FontSizeScale)
    result.font.setFunctionsOpenType()
    result.buffer = newBuffer()
  except:
    echo "error"
  finally:
    face.dispose()
    stream.dispose()

proc shape*(shaper: SkShaper, buffer: Buffer, xOffset, yOffset: float, paint: SkPaint): (seq[uint],seq[uint],seq[SkPoint]) =
  assert not isNil buffer
  assert not isNil paint

  shaper.font.shape(buffer)

  let
    len = buffer.length
    info = buffer.getGlyphInfos()
    pos = buffer.getGlyphPositions()
    textSizeY = paint.textSize / FontSizeScale
    textSizeX = textSizeY * paint.textScaleX

  var
    cursorX = xOffset
    cursorY = yOffset
    points = newSeqOfCap[SkPoint](len)
    clusters = newSeqUninitialized[uint](len)
    codepoints = newSeqUninitialized[uint](len)

  for i in 0..len - 1:
    codepoints[i] = info[i].codepoint
    clusters[i] = info[i].cluster
    points.add((
      cursorX + pos[i].xOffset.float * textSizeX,
      cursorY - pos[i].yOffset.float * textSizeY
    ))
    cursorX += pos[i].xAdvance.float * textSizeX
    cursorY += pos[i].yAdvance.float * textSizeY

  return (codepoints, clusters, points)

proc shape*(shaper: SkShaper, buffer: Buffer, paint: SkPaint): (seq[uint],seq[uint],seq[SkPoint]) =
  shaper.shape(buffer, 0, 0, paint)

proc shape*(shaper: SkShaper, text: string, xOffset, yOffset: float, paint: SkPaint): (seq[uint],seq[uint],seq[SkPoint]) =
  if text.len == 0:
    return (newSeq[uint](), newSeq[uint](), newSeq[SkPoint]())

  let buffer = newBuffer()

  assert paint.textEncoding == SkTextEncoding.Utf8
  buffer.addUtf8(text)

  buffer.guessSegmentProperties()

  shaper.shape(buffer, xOffset, yOffset, paint)

proc shape*(shaper: SkShaper, text: string, paint: SkPaint): (seq[uint],seq[uint],seq[SkPoint]) =
  shaper.shape(text, 0, 0, paint)

proc dispose*(shaper: SkShaper) =
  shaper.font.dispose()
  shaper.buffer.dispose()