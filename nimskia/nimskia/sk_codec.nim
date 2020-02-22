import ../wrapper/sk_types
import ../wrapper/sk_codec

import sk_data
import sk_imageinfo
import sk_enums
import sk_stream

import internals/native

type
  SkCodec* = ref object of SkObject[sk_codec_t]

proc newSkCodec*(data: SkData): SkCodec =
  SkCodec(native: sk_codec_new_from_data(data.native))

proc newSkCodec*(stream: SkStream): (SkCodecResult, SkCodec) =
  var res: sk_codec_result_t
  var codec = SkCodec(native: sk_codec_new_from_stream(stream.native, res.addr))
  return (res.SkCodecResult, codec)

proc newSkCodec*(filename: string): (SkCodecResult, SkCodec) = 
  let fs = openSkFileStream(filename)
  if isNil fs:
    return (InternalError, nil)
  return newSkCodec(fs)

proc dispose*(this: SkCodec) =
  sk_codec_destroy(this.native)

proc info*(this: SkCodec): SkImageInfo =
  var info = cast[ptr sk_imageinfo_t](alloc(sizeof(sk_imageinfo_t)))
  sk_codec_get_info(this.native, info)
  SkImageInfo(native: info[])

proc pixels*(this: SkCodec, info: SkImageInfo, pixels: pointer): SkCodecResult =
  var options = sk_codec_options_t(
    fZeroInitialized: NO_Sk_CODEC_ZERO_INITIALIZED,
    fSubset: nil,
    fFrameIndex: 0,
    fPriorFrame: -1,
    fPremulBehavior: RESPECT_Sk_TRANSFER_FUNCTION_BEHAVIOR
  )
  sk_codec_get_pixels(this.native, info.native.addr, pixels, info.rowBytes, options.addr).SkCodecResult
