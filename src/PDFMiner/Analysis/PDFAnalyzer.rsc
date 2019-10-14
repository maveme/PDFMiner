module PDFMiner::Analysis::PDFAnalyzer

import Set;
import List;
import String;
import PDFMiner::PDFResult;
import PDFMiner::PDFFile;
import PDFMiner::PDFReader;

PDFResult analizeFile(loc filePath, set[str] tools) {
	PDFFile pdf = parsePDFFile(filePath);
	list[str] textWords = ( [] | it + split(" ", line) | line <- pdf.lines);
	set[str] occurrences = findOccurrences(textWords, tools);
	return pdfResult(pdf.title, filePath.file[..-4], occurrences, size(occurrences), pdf.keywords);
}

list[PDFResult] analyzeDirectory(loc directory, set[str] tools)
  = [ analizeFile(file, tools) | file <- directory.ls, endsWith(file.file, ".pdf")];

// This function receives the whole pdf text as a list of words enconded as strings.
set[str] findOccurrences(list[str] content, set[str] words) 
  = { word | word <- words, !contains(word, " ") && word in content} + { word | word <- words, contains(word, " ") && matchSpecialCase(word, content) };

// This function handles words with spaces. It first splits the string by space, flattens it, and then it tries to match it to the text
bool matchSpecialCase(str word, list[str] content) {
  list[str] s = split(" ", word);
  if ([*_, *s, *_] := content) 
  	return true;
  else 
  	return false;
}
