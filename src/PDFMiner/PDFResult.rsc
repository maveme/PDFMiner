module PDFMiner::PDFResult

data PDFResult 
  = pdfResult(str pdfName, str pdfFileName, set[str] occurrences, int numberOccurrences, str keywords)
  ;