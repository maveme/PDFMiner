module PDFMiner::Result

data Result 
  = pdfResult(str pdfName, str pdfFileName, set[str] occurrences, int numberOccurrences)
  ;