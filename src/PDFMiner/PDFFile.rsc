module PDFMiner::PDFFile

data PDFFile
  = pdf(str title, str text)
  | pdf(str title, list[str] lines)
  | pdf(str title, list[str] lines, str keywords = "")
  ;