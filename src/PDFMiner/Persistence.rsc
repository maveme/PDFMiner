module PDFMiner::Persistence

import lang::csv::IO;
import PDFMiner::Plugin;
import PDFMiner::PDFResult;

void persistResults(loc dest, list[PDFResult] results) {
	rel[str pdfName,str pdfFileName, set[str] occurences, int numberOccurences, str keywords] tmp = list2rel(results);
	writeCSV(tmp, dest);
}

rel[str pdfName,str pdfFileName, set[str] occurences, int numberOccurences, str keywords] list2rel(list[PDFResult] results)
  = { <r.pdfName, r.pdfFileName, r.occurrences, r.numberOccurrences, r.keywords> | r <- results };