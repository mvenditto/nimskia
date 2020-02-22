import ../wrapper/sk_types
import ../wrapper/sk_data

import sequtils
import sugar

type
  SkData* = ref object
    native*: ptr sk_data_t

proc newSkData*(): SkData = 
  SkData(native: sk_data_new_empty())

proc newSkData*(src: pointer, size: int): SkData = 
  SkData(native: sk_data_new_with_copy(src, size))

proc newSkData*(data: SkData, offset: int, length: int): SkData =
  SkData(native: sk_data_new_subset(data.native, offset, length))

proc newSkData*(value: string): SkData =
  let cvalue = value.cstring
  var bytes = cvalue.toSeq.map(c => c.byte)
  bytes.add(0.byte)
  newSkData(bytes[0].unsafeAddr, bytes.len)

proc dispose*(data: SkData) = sk_data_unref(data.native)

template size*(this: SkData): int = sk_data_get_size(this.native)

template data*(this: SkData): pointer = sk_data_get_data(this.native)

template len*(this: SkData): int = size(this)

