type
  SKObject*[H] {.inheritable.} = object of RootObj
    native*: ptr H

template nativeRaw*[H](skObj: SKObject[H]): pointer =
  cast[pointer](skObj.native)