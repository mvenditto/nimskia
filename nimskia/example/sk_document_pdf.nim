import ../nimskia/[
  sk_canvas, 
  sk_paint, 
  sk_color, 
  sk_rect, 
  sk_enums,
  sk_colors,
  sk_document,
  sk_stream,
  sk_point
]

import os
import times


const
  sampleTmpDir = "sk_document_create_pdf_tmp"

proc createExampleDir() =
  if existsDir(sampleTmpDir):
    removeDir(sampleTmpDir)
  createDir(sampleTmpDir)

proc createPdfMetadata(): SkDocumentPdfMetadata =
  result = newSkPdfMetadata()
  result.author = "cool developer"
  result.creator = "cool developer library"
  result.keywords = "pdf, skia, nimskia"
  result.producer = "nimskia"
  result.subject = "pdf creation example"
  result.title = "example pdf"
  result.creation = now()
  result.modified = now()

proc createPdf() =
  let path = joinPath(sampleTmpDir, "example.pdf")
  let meta = createPdfMetadata()

  let stream = openSkFileWStream(path)
  let document = createPdf(stream, meta)

  let paint = newSkPaint()
  paint.textSize = 64
  paint.antialias = true
  paint.color = 0xFF9CAFB7.SkColor
  paint.strokeWidth = 3
  paint.textAlign = Center

  let 
    width = 840.0
    height = 1188.0

  # draw page 1
  let pdfCanvas = document.beginPage(width, height)
  let nextPagePaint = newSkPaint()
  nextPagePaint.antialias = true
  nextPagePaint.textSize = 16
  nextPagePaint.color = OrangeRed
  let nextText = "Next Page >>"
  var btn = newSkRect(
    width - nextPagePaint.measureText(nextText) - 24,
    0,
    width,
    nextPagePaint.textSize + 24
  )
  pdfCanvas.drawText(nextText, btn.left + 12, btn.bottom - 12, nextPagePaint);
  pdfCanvas.drawLinkDestinationAnnotation(btn, "next-page");
  
  pdfCanvas.drawText("...PDF 1/2...", width / 2, height / 4, paint)
  document.endPage()
  
  # draw page 2
  let pdfCanvas2 = document.beginPage(width, height)
  pdfCanvas2.drawNamedDestinationAnnotation(newSkPoint(0f,0), "next-page");
  pdfCanvas2.drawText("...PDF 2/2...", width / 2, height / 4, paint)
  document.endPage()
  document.close()

  # cleanup
  paint.dispose()
  stream.dispose()

proc main() =
  createExampleDir()
  createPdf()

main()