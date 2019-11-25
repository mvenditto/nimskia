when defined(Linux):
  const dynlibsk_managedstream = "libskia.so"

import strutils
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
type
  sk_wstream_managedstream_t* {.bycopy.} = object

  sk_managedwstream_write_proc* = proc (s: ptr sk_wstream_managedstream_t;
                                     context: pointer; buffer: pointer; size: csize): bool {.
      cdecl.}
  sk_managedwstream_flush_proc* = proc (s: ptr sk_wstream_managedstream_t;
                                     context: pointer) {.cdecl.}
  sk_managedwstream_bytesWritten_proc* = proc (s: ptr sk_wstream_managedstream_t;
      context: pointer): csize {.cdecl.}
  sk_managedwstream_destroy_proc* = proc (s: ptr sk_wstream_managedstream_t;
                                       context: pointer) {.cdecl.}
  sk_managedwstream_procs_t* {.bycopy.} = object
    fWrite*: sk_managedwstream_write_proc
    fFlush*: sk_managedwstream_flush_proc
    fBytesWritten*: sk_managedwstream_bytesWritten_proc
    fDestroy*: sk_managedwstream_destroy_proc


proc sk_managedwstream_set_procs*(procs: sk_managedwstream_procs_t) {.cdecl,
    importc: "sk_managedwstream_set_procs", dynlib: dynlibsk_managedstream.}
proc sk_managedwstream_new*(context: pointer): ptr sk_wstream_managedstream_t {.
    cdecl, importc: "sk_managedwstream_new", dynlib: dynlibsk_managedstream.}
proc sk_managedwstream_destroy*(s: ptr sk_wstream_managedstream_t) {.cdecl,
    importc: "sk_managedwstream_destroy", dynlib: dynlibsk_managedstream.}
type
  sk_stream_managedstream_t* {.bycopy.} = object

  sk_managedstream_read_proc* = proc (s: ptr sk_stream_managedstream_t;
                                   context: pointer; buffer: pointer; size: csize): csize {.
      cdecl.}
  sk_managedstream_peek_proc* = proc (s: ptr sk_stream_managedstream_t;
                                   context: pointer; buffer: pointer; size: csize): csize {.
      cdecl.}
  sk_managedstream_isAtEnd_proc* = proc (s: ptr sk_stream_managedstream_t;
                                      context: pointer): bool {.cdecl.}
  sk_managedstream_hasPosition_proc* = proc (s: ptr sk_stream_managedstream_t;
      context: pointer): bool {.cdecl.}
  sk_managedstream_hasLength_proc* = proc (s: ptr sk_stream_managedstream_t;
                                        context: pointer): bool {.cdecl.}
  sk_managedstream_rewind_proc* = proc (s: ptr sk_stream_managedstream_t;
                                     context: pointer): bool {.cdecl.}
  sk_managedstream_getPosition_proc* = proc (s: ptr sk_stream_managedstream_t;
      context: pointer): csize {.cdecl.}
  sk_managedstream_seek_proc* = proc (s: ptr sk_stream_managedstream_t;
                                   context: pointer; position: csize): bool {.cdecl.}
  sk_managedstream_move_proc* = proc (s: ptr sk_stream_managedstream_t;
                                   context: pointer; offset: clong): bool {.cdecl.}
  sk_managedstream_getLength_proc* = proc (s: ptr sk_stream_managedstream_t;
                                        context: pointer): csize {.cdecl.}
  sk_managedstream_duplicate_proc* = proc (s: ptr sk_stream_managedstream_t;
                                        context: pointer): ptr sk_stream_managedstream_t {.
      cdecl.}
  sk_managedstream_fork_proc* = proc (s: ptr sk_stream_managedstream_t;
                                   context: pointer): ptr sk_stream_managedstream_t {.
      cdecl.}
  sk_managedstream_destroy_proc* = proc (s: ptr sk_stream_managedstream_t;
                                      context: pointer) {.cdecl.}
  sk_managedstream_procs_t* {.bycopy.} = object
    fRead*: sk_managedstream_read_proc
    fPeek*: sk_managedstream_peek_proc
    fIsAtEnd*: sk_managedstream_isAtEnd_proc
    fHasPosition*: sk_managedstream_hasPosition_proc
    fHasLength*: sk_managedstream_hasLength_proc
    fRewind*: sk_managedstream_rewind_proc
    fGetPosition*: sk_managedstream_getPosition_proc
    fSeek*: sk_managedstream_seek_proc
    fMove*: sk_managedstream_move_proc
    fGetLength*: sk_managedstream_getLength_proc
    fDuplicate*: sk_managedstream_duplicate_proc
    fFork*: sk_managedstream_fork_proc
    fDestroy*: sk_managedstream_destroy_proc


proc sk_managedstream_set_procs*(procs: sk_managedstream_procs_t) {.cdecl,
    importc: "sk_managedstream_set_procs", dynlib: dynlibsk_managedstream.}
proc sk_managedstream_new*(context: pointer): ptr sk_stream_managedstream_t {.cdecl,
    importc: "sk_managedstream_new", dynlib: dynlibsk_managedstream.}
proc sk_managedstream_destroy*(s: ptr sk_stream_managedstream_t) {.cdecl,
    importc: "sk_managedstream_destroy", dynlib: dynlibsk_managedstream.}