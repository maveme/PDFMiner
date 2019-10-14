module PDFMiner::Analysis::PDFAnalyzer

import Set;
import List;
import String;
import PDFMiner::Result;
import PDFMiner::PDFFile;
import PDFMiner::PDFReader;

Result analizeFile(loc filePath, set[str] tools) {
	PDFFile pdf = parsePDFFile(filePath);
	list[str] textWords = ( [] | it + split(" ", line) | line <- pdf.lines);
	set[str] occurrences = findOccurrences(textWords, tools);
	return pdfResult(pdf.title, filePath.file[..-4], occurrences, size(occurrences));
}

list[Result] analyzeDirectory(loc directory, set[str] tools)
  = [ analizeFile(file, tools) | file <- directory.ls, endsWith(file.file, ".pdf")];

// This function receives the whole pdf text as a list of words enconded as strings.
set[str] findOccurrences(list[str] content, set[str] words) 
  = { word | word <- words, word in content};