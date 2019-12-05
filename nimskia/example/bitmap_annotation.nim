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
  w = 640
  h = 480
  title = "sample: bitmap annotation"

proc readBitmap(path: string): SKBitmap =
  echo "read bitmap from stream"
  var fs = newSKFileStream(path)
  assert fs.isValid
  var(res,codec) = newCodec(fs)
  assert res == Success
  let desiredInfo = newImageInfo(380, 133, Rgba8888, Premul, nil)
  result = decodeBitmap(codec, desiredInfo)

proc main() =

  var bitmap = readBitmap("../docs/images/skia.png")

  let imageHeigth = bitmap.info.height
  echo &"bitmap: {bitmap.info.width}x{bitmap.info.height}"

  let paint = newPaint()
  paint.strokeWidth = 3
  paint.color = Red
  paint.style = Stroke 

  let annotCanvas = newCanvas(bitmap)
  var(rx, ry) = (80.float, 33.float) 
  var rect = newRect(
    rx, 
    ry,
    bitmap.info.width.float - rx,
    bitmap.info.height.float - ry
  )
  annotCanvas.drawRect(rect, paint)

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(DarkBlue)
    #discard canvas.save()
    # flip vertically to adjust coords
    #canvas.scale(
    #  1.0, -1.0,  0, imageHeigth.float / 2.0
    #);
    canvas.drawBitmap(bitmap,0,0)
    #canvas.restore()

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
