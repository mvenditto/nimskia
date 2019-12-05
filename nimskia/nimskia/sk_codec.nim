import ../wrapper/sk_types
import ../wrapper/sk_codec

import sk_data
import sk_imageinfo
import sk_enums
import sk_stream

import internals/native


type
  SkCodec* = ref object of SKObject[sk_codec_t]

proc newCodec*(data: SKData): SKCodec =
  SKCodec(native: sk_codec_new_from_data(data.native))

proc newCodec*(stream: SKStream): (SKCodecResult, SKCodec) =
  var res: sk_codec_result_t
  var codec = SkCodec(native: sk_codec_new_from_stream(stream.native, res.addr))
  return (res.SkCodecResult, codec)

proc newCodec*(filename: string): (SKCodecResult, SKCodec) = 
  let fs = openSKFileStream(filename)
  if isNil fs:
    return (InternalError, nil)
  return newCodec(fs)

proc dispose*(this: SkCodec) =
  sk_codec_destroy(this.native)

proc info*(this: SKCodec): SKImageInfo =
  var info = cast[ptr sk_imageinfo_t](alloc(sizeof(sk_imageinfo_t)))
  sk_codec_get_info(this.native, info)
  SKImageInfo(native: info[])

proc pixels*(this: SkCodec, info: SKImageInfo, pixels: pointer): SkCodecResult =
  var options = sk_codec_options_t(
    fZeroInitialized: NO_SK_CODEC_ZERO_INITIALIZED,
    fSubset: nil,
    fFrameIndex: 0,
    fPriorFrame: -1,
    fPremulBehavior: RESPECT_SK_TRANSFER_FUNCTION_BEHAVIOR
  )
  sk_codec_get_pixels(this.native, info.native.addr, pixels, info.rowBytes, options.addr).SkCodecResult
