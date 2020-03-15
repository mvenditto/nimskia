import sk_canvas
import sk_shaper
import sk_paint
import sk_enums
import sk_point

proc drawShapedText*(
  canvas: SkCanvas, 
  shaper: SkShaper, 
  text: string, 
  x, y: float, 
  paint: SkPaint) =

  assert not isNil canvas
  assert not isNil paint
  assert not isNil shaper
  
  if text.len == 0: return

  let(codepoints, _, points) = shaper.shape(text, x, y, paint)
  
  let paintClone = paint.clone()
  paintClone.textEncoding = GlyphId
  paintClone.typeface = shaper.typeface

  var bytes = newSeqUninitialized[uint8](codepoints.len * 2)
  var idx = 0
  for cp in codepoints:
    let cpb = cast[array[0..2, uint8]](cp)
    bytes[idx] = cpb[0]
    bytes[idx + 1] = cpb[1]
    idx += 2

  canvas.drawPositionedText(bytes, points, paintClone)

