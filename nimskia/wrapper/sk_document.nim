when defined(Linux):
  const dynlibsk_document = "libskia.so"
when defined(Windows):
  const dynlibsk_document = "libskia.dll"

import strutils
import sk_types
const sourcePath = currentSourcePath().split({'\\', '/'})[0..^2].join("/")
{.passC: "-I\"" & sourcePath & "skia/include/c\"".}
{.passC: "-I\"" & sourcePath & "skia/include/xamarin\"".}
proc sk_document_unref*(document: ptr sk_document_t) {.cdecl,
    importc: "sk_document_unref", dynlib: dynlibsk_document.}
proc sk_document_create_pdf_from_stream*(stream: ptr sk_wstream_t): ptr sk_document_t {.
    cdecl, importc: "sk_document_create_pdf_from_stream", dynlib: dynlibsk_document.}
proc sk_document_create_pdf_from_stream_with_metadata*(stream: ptr sk_wstream_t;
    metadata: ptr sk_document_pdf_metadata_t): ptr sk_document_t {.cdecl,
    importc: "sk_document_create_pdf_from_stream_with_metadata",
    dynlib: dynlibsk_document.}
proc sk_document_create_xps_from_stream*(stream: ptr sk_wstream_t; dpi: cfloat): ptr sk_document_t {.
    cdecl, importc: "sk_document_create_xps_from_stream", dynlib: dynlibsk_document.}
proc sk_document_begin_page*(document: ptr sk_document_t; width: cfloat;
                            height: cfloat; content: ptr sk_rect_t): ptr sk_canvas_t {.
    cdecl, importc: "sk_document_begin_page", dynlib: dynlibsk_document.}
proc sk_document_end_page*(document: ptr sk_document_t) {.cdecl,
    importc: "sk_document_end_page", dynlib: dynlibsk_document.}
proc sk_document_close*(document: ptr sk_document_t) {.cdecl,
    importc: "sk_document_close", dynlib: dynlibsk_document.}
proc sk_document_abort*(document: ptr sk_document_t) {.cdecl,
    importc: "sk_document_abort", dynlib: dynlibsk_document.}