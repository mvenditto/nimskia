import ../nimskia/[
  sk_canvas, 
  sk_colors,
  sk_bitmap,
  sk_imageinfo,
  sk_data,
  sk_codec
]
import sample_base
import streams
import strformat

const
  w = 640
  h = 480
  title = "sample: bitmap basics"

proc readBitmap(file: File): SKBitmap =
  let length = file.getFileSize()
  let buff = alloc(length)
  var s = newFileStream(file)
  assert s.readData(buff, length.int) > 0
  var data = newData(buff, length.int)
  result = decodeBitmap(newCodec(data))
  s.close()

proc main() =
  var bitmap = readBitmap(
    open("../docs/images/skia.png", fmRead)
  )

  let imageHeigth = bitmap.info.heigth
  echo &"bitmap: {bitmap.info.width}x{bitmap.info.heigth}"

  proc update(canvas: SKCanvas, dt: float) =
    canvas.clear(DarkBlue)
    discard canvas.save()
    # flip vertically to adjust coords
    canvas.scale(
      1.0, -1.0,  0, imageHeigth.float / 2.0
    );
    canvas.drawBitmap(bitmap,0,0)
    canvas.restore()

  let sample = Sample(
    title: title,
    w: w,
    h: h,
    update: update
  )

  sample.start()

main()
