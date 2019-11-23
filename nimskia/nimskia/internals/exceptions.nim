import strformat

proc notSupported*() =
  assert(false, &"not supported")

proc notSupported*(msg: string) =
  assert(false, &"not supported: {msg}")