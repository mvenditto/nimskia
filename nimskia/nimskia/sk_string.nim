import ../wrapper/sk_types
import ../wrapper/sk_string

import internals/native
import internals/exceptions

type
  SKString* = ref object of SKObject[sk_string_t]

proc createCopy(src: string, length: int): ptr sk_string_t =
  sk_string_new_with_copy(src, length)

proc newSKString*(): SKString =
  result = SKString(native: sk_string_new_empty())
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create a new SKString instance.")

proc newSKString*(src: string): SKString =
  result = SKString(native: createCopy(src, src.len))
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create a new SKString instance.")

proc `$`*(this: SKString): string =
  $sk_string_get_c_str(this.native)

proc dispose*(this: SKString) =
  sk_string_destructor(this.native)
