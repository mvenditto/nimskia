when defined(Linux):
  const dynlibsk_xml = "libskia.so"
when defined(Windows):
  const dynlibsk_xml = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_xmlstreamwriter_new*(stream: ptr sk_wstream_t): ptr sk_xmlstreamwriter_t {.
    cdecl, importc: "sk_xmlstreamwriter_new", dynlib: dynlibsk_xml.}
proc sk_xmlstreamwriter_delete*(writer: ptr sk_xmlstreamwriter_t) {.cdecl,
    importc: "sk_xmlstreamwriter_delete", dynlib: dynlibsk_xml.}