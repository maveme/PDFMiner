module PDFMiner::Persistence

import lang::csv::IO;
import PDFMiner::Plugin;
import PDFMiner::Result;

void persistResults(loc dest, list[Result] results) {
	rel[str pdfName,str pdfFileName, set[str] occurences, int numberOccurences] tmp = list2rel(results);
	writeCSV(tmp, dest);
}

rel[str pdfName,str pdfFileName, set[str] occurences, int numberOccurences] list2rel(list[Result] results)
  = { <r.pdfName, r.pdfFileName, r.occurrences, r.numberOccurrences> | r <- results };