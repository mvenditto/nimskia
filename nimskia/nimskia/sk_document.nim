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
  SkDocument* = ref object of SkObject[sk_document_t]
    underlyingStream*: SkWStream

  SkDocumentPdfMetadata* = object
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

proc newSkPdfMetadataNow(): SkDocumentPdfMetadata =
  SkDocumentPdfMetadata(
    creation: now(),
    modified: now()
  )

proc newSkPdfMetadata*(): SkDocumentPdfMetadata =
  result = newSkPdfMetadataNow()
  result.rasterDpi = DefaultRasterDpi
  result.pdfA = false
  result.encodingQuality = DefaultEncodingQuality

proc newSkPdfMetadata*(rasterDpi: float): SkDocumentPdfMetadata =
  result = newSkPdfMetadataNow()
  result.rasterDpi = rasterDpi
  result.pdfA = false
  result.encodingQuality = DefaultEncodingQuality

proc newSkPdfMetadata*(encodingQuality: int): SkDocumentPdfMetadata =
  result = newSkPdfMetadataNow()
  result.rasterDpi = DefaultRasterDpi
  result.pdfA = false
  result.encodingQuality = encodingQuality

proc newSkPdfMetadata*(rasterDpi: float, encodingQuality: int): SkDocumentPdfMetadata =
  result = newSkPdfMetadataNow()
  result.rasterDpi = rasterDpi
  result.pdfA = false
  result.encodingQuality = encodingQuality

proc abort*(doc: SkDocument) =
  sk_document_abort(doc.native)

proc beginPage*(doc: SkDocument, width, height: float): SkCanvas =
  SkCanvas(native: sk_document_begin_page(doc.native, width, height, nil))

proc beginPage*(doc: SkDocument, width: float, height: float, content: SkRect): SkCanvas =
  SkCanvas(native: sk_document_begin_page(doc.native, width, height, content.native.addr))

proc endPage*(doc: SkDocument) =
  sk_document_end_page(doc.native)

proc close*(doc: SkDocument) =
  sk_document_close(doc.native)

# PDF creation

proc createPdf*(path: string): SkDocument =
  new(result)
  let stream = openSkFileWStream(path)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)

proc createPdf*(stream: SkWStream): SkDocument =
  if isNil stream: raise newException(ValueError, "stream cannot be null")
  new(result)
  result.underlyingStream = stream
  result.native = sk_document_create_pdf_from_stream(stream.native)

proc createPdf*(stream: SkWStream, meta: SkDocumentPdfMetadata, createdNow: bool = false): SkDocument = 
  if isNil stream: raise newException(ValueError, "stream cannot be null")
  new(result)

  let 
    title = newSkString(meta.title)
    author = newSkString(meta.author)
    subject = newSkString(meta.subject)
    keywords = newSkString(meta.keywords)
    creator = newSkString(meta.creator)
    producer = newSkString(meta.producer)
  
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

  SkDocument(native: sk_document_create_pdf_from_stream_with_metadata(
    stream.native, metadata.addr
  ))

proc createPdf*(path: string, meta: SkDocumentPdfMetadata): SkDocument = 
    let stream = openSkFileWStream(path)
    createPdf(stream, meta)

