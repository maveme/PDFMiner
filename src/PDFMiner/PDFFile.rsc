module PDFMiner::PDFFile

data PDFFile
  = pdf(str title, str text, str keywords)
  | pdf(str title, list[str] lines, str keywords)
  ;