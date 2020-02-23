type
  SkObject*[H] = object of RootObj
    native*: ptr H

template nativeRaw*[H](skObj: ref SkObject[H]): pointer =
  cast[pointer](skObj.native)

proc nativeSafe*[H](skObj: ref SkObject[H]): ptr H =
  if isNil skObj:
    return nil
  return skObj.native