type
  SKObject*[H] {.inheritable.} = object of RootObj
    native*: ptr H

template nativeRaw*[H](skObj: ref SKObject[H]): pointer =
  cast[pointer](skObj.native)

proc nativeSafe*[H](skObj: ref SKObject[H]): ptr H =
  if isNil skObj:
    return nil
  return skObj.native