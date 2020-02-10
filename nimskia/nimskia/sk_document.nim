import ../wrapper/sk_types
import ../wrapper/sk_document

import internals/native

import sk_stream
import sk_canvas
import sk_rect
import sk_converters
import sk_string

import times

const
  DefaultRasterDpi* = 72.0
  DefaultEncodingQuality* = 101

type
  SKDocument* = ref object of SKObject[sk_document_t]
    underlyingStream*: SKWStream

  SKDocumentPdfMetadata* = object
    title*: string
    author*: string
    subject*: string
    keywords*: string
    creator*: string
    producer*: string
    creation*: DateTime
    modified*: DateTime
    rasterDpi*: float
    pdfA*: bool
    encodingQuality*: int

proc newPdfMetadataNow(): SKDocumentPdfMetadata =
  SKDocumentPdfMetadata(
    creation: now(),
    modified: now()
  )

proc newPdfMetadata*(): SKDocumentPdfMetadata =
  result = newPdfMetadataNow()
  result.rasterDpi = DefaultRasterDpi
  result.pdfA = false
  result.encodingQuality = DefaultEncodingQuality

proc newPdfMetadata*(rasterDpi: float): SKDocumentPdfMetadata =
  result = newPdfMetadataNow()
  result.rasterDpi = rasterDpi
  result.pdfA = false
  result.encodingQuality = DefaultEncodingQuality

proc newPdfMetadata*(encodingQuality: int): SKDocumentPdfMetadata =
  result = newPdfMetadataNow()
  result.rasterDpi = DefaultRasterDpi
  result.pdfA = false
  result.encodingQuality = encodingQuality

proc newPdfMetadata*(rasterDpi: float, encodingQuality: int): SKDocumentPdfMetadata =
  result = newPdfMetadataNow()
  result.rasterDpi = rasterDpi
  result.pdfA = false
  result.encodingQuality = encodingQuality

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

proc createPdf*(path: string): SKDocument =
  new(result)
  let stream = openSKFileWStream(path)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)

proc createPdf*(stream: SKWStream): SKDocument =
  if isNil stream: raise newException(ValueError, "stream cannot be nul")
  new(result)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)

proc createPdf*(stream: SKWStream, meta: SKDocumentPdfMetadata, createdNow: bool = false): SKDocument = 
  if isNil stream: raise newException(ValueError, "stream cannot be nul")
  new(result)

  let 
    title = newSKString(meta.title)
    author = newSKString(meta.author)
    subject = newSKString(meta.subject)
    keywords = newSKString(meta.keywords)
    creator = newSKString(meta.creator)
    producer = newSKString(meta.producer)
  
  var metadata = sk_document_pdf_metadata_t(
    fTitle: if isNil title.native: nil else: title.native,
    fAuthor: if isNil author.native: nil else: author.native,
    fSubject: if isNil subject.native: nil else: subject.native,
    fKeywords: if isNil keywords.native: nil else: keywords.native,
    fCreator: if isNil creator.native: nil else: creator.native,
    fProducer: if isNil producer.native: nil else: producer.native,
    fRasterDpi: meta.rasterDpi,
    fPDFA: meta.pdfA,
    fEncodingQuality: meta.encodingQuality.cint
  )
  
  var creation: sk_time_datetime_t = if createdNow: now() else: meta.creation
  metadata.fCreation = creation.addr
  var modified: sk_time_datetime_t = if createdNow: now() else: meta.modified
  metadata.fModified = modified.addr
  
  defer:
    title.dispose()
    author.dispose()
    subject.dispose()
    keywords.dispose()
    creator.dispose()
    producer.dispose()

  SKDocument(native: sk_document_create_pdf_from_stream_with_metadata(
    stream.native, metadata.addr
  ))

proc createPdf*(path: string, meta: SKDocumentPdfMetadata): SKDocument = 
    let stream = openSKFileWStream(path)
    createPdf(stream, meta)

