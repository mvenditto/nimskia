import strformat
import system

type
  UnsupportedOperationError* = object of CatchableError

proc notSupported*() =
  assert(false, &"not supported")

proc notSupported*(msg: string) =
  assert(false, &"not supported: {msg}")

