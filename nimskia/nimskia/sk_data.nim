import ../wrapper/sk_types
import ../wrapper/sk_data

import sequtils
import sugar

type
  SKData* = ref object
    native*: ptr sk_data_t

proc newData*(): SKData = 
  SKData(native: sk_data_new_empty())

proc newData*(src: pointer, size: int): SKData = 
  SKData(native: sk_data_new_with_copy(src, size))

proc newData*(data: SKData, offset: int, length: int): SKData =
  SKData(native: sk_data_new_subset(data.native, offset, length))

proc newData*(value: string): SKData =
  let cvalue = value.cstring
  var bytes = cvalue.toSeq.map(c => c.byte)
  bytes.add(0.byte)
  newData(bytes[0].unsafeAddr, bytes.len)

proc dispose*(data: SKData) = sk_data_unref(data.native)

template size*(this: SKData): int = sk_data_get_size(this.native)

template data*(this: SKData): pointer = sk_data_get_data(this.native)

template len*(this: SKData): int = size(this)

