import ../wrapper/sk_types
import ../wrapper/sk_string

import internals/native
import internals/exceptions

type
  SkString* = ref object of SkObject[sk_string_t]

proc createCopy(src: string, length: int): ptr sk_string_t =
  sk_string_new_with_copy(src, length)

proc newSkString*(): SkString =
  result = SkString(native: sk_string_new_empty())
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create a new SkString instance.")

proc newSkString*(src: string): SkString =
  result = SkString(native: createCopy(src, src.len))
  if isNil result.native:
    raise newException(UnsupportedOperationError, "Cannot create a new SkString instance.")

proc `$`*(this: SkString): string =
  $sk_string_get_c_str(this.native)

proc dispose*(this: SkString) =
  sk_string_destructor(this.native)
