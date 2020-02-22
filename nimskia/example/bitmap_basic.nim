import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_bitmap,
  sk_imageinfo,
  sk_data,
  sk_codec,
  sk_stream,
  sk_enums
]
import sample_base
import streams
import strformat

const
  w = 320
  h = 320
  title = "sample: bitmap basics"

proc readBitmapData(path: string): SkBitmap =
  var file = open(path, fmRead)
  let length = file.getFileSize()
  let buff = alloc(length)
  var s = newFileStream(file)
  assert s.readData(buff, length.int) > 0
  var data = newSkData(buff, length.int)
  result = decodeBitmap(newSkCodec(data))
  s.close()

proc readBitmapStream(path: string): SkBitmap =
  echo "read bitmap from stream"
  var fs = newSkFileStream(path)
  assert fs.isValid
  var(res,codec) = newSkCodec(fs)
  assert res == Success
  result = decodeBitmap(codec)

proc main() =

  var bitmap = readBitmapStream("resources/images/skia.png")

  let imageHeigth = bitmap.info.height
  echo &"bitmap: {bitmap.info.width}x{bitmap.info.height}"

  proc update(canvas: SkCanvas, dt: float) =
    canvas.clear(DefaultBg)
    #discard canvas.save()
    # flip vertically to adjust coords
    #canvas.scale(
    #  1.0, -1.0,  0, imageHeigth.float / 2.0
    #);
    canvas.drawBitmap(bitmap, 4, h / 2.0 - imageHeigth.float / 2.0)
    #canvas.restore()

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
