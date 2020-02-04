import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_bitmap,
  sk_imageinfo,
  sk_paint,
  sk_data,
  sk_codec,
  sk_rect,
  sk_stream,
  sk_enums
]
import sample_base
import strformat

const
  w = 320
  h = 320
  title = "sample: bitmap annotation"

proc readBitmap(path: string): SKBitmap =
  var fs = newSKFileStream(path)
  assert fs.isValid
  var(res,codec) = newCodec(fs)
  assert res == Success
  result = decodeBitmap(codec)

proc main() =

  var bitmap = readBitmap("resources/images/skia.png")

  echo &"bitmap: {bitmap.info.width}x{bitmap.info.height}"

  let paint = newPaint()
  paint.strokeWidth = 4
  paint.color = Red
  paint.style = Stroke 

  const(padX, padY) = (4.0, 4.0)

  let annotCanvas = newCanvas(bitmap)
  var rect = newRect(
    0, 
    0,
    bitmap.info.width.float,
    bitmap.info.height.float
  )
  annotCanvas.drawRect(rect, paint)

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(DefaultBg)
    canvas.drawBitmap(bitmap,padX,h / 2.0 - bitmap.info.height.float / 2.0)

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

  paint.dispose()
  annotCanvas.dispose()

main()
