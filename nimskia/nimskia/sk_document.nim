import ../wrapper/sk_types
import ../wrapper/sk_document

import internals/native

import sk_stream
import sk_canvas
import sk_rect

type
  SKDocument* = ref object of SKObject[sk_document_t]
    underlyingStream*: SKWStream

proc abort*(doc: SKDocument) =
  sk_document_abort(doc.native)

proc beginPage*(doc: SKDocument, width, height: float): SKCanvas =
  SKCanvas(native: sk_document_begin_page(doc.native, width, height, nil))

proc beginPage*(doc: SKDocument, width: float, height: float, content: SKRect): SKCanvas =
  SKCanvas(native: sk_document_begin_page(doc.native, width, height, content.native.addr))

proc endPage*(doc: SKDocument) =
  sk_document_end_page(doc.native)

proc close*(doc: SKDocument) =
  sk_document_close(doc.native)

# PDF creation

proc createPdf*(stream: SKWStream): SKDocument =
  new(result)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)

proc createPdf*(path: string): SKDocument =
  new(result)
  let stream = openSKFileWStream(path)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)


