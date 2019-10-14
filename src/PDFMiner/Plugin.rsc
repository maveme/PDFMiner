module PDFMiner::Plugin

import IO;
import Set;
import List;
import String;
import PDFMiner::Result;
import PDFMiner::Persistence;

import util::Benchmark;

data PDFFile
  = pdf(str title, str text)
  | pdf(str title, list[str] lines);

void readPDF() {
	rtas = readFileLines(|project://SLR-WordsOcurrency/Examples/em.pdf|);
	println(size(rtas));
	println(rtas[1000]);
}

@javaClass{org.rascal.pdfReader.PDFReader}
public java PDFFile readPDFFile(loc path);

PDFFile parsePDFFile(loc filePath) {
	PDFFile doc = readPDFFile(filePath);
	list[str] stripes = split("\n", doc.text);
	return pdf(doc.title, stripes);
}

void corporaAnalysis(loc directory) {
	set[str] tools = {"Scratch","GP","gp","Snap!","Snap","Blockly","blockly","App inventor","app inventor","AppInventor","CT-Blocks","Openblocks","Makecode","StarLogoNova","Tynker","Modkit","Ardublockly","Lego Mindstorms","Dash and dot","Dash and Dot","Ozobots","Alice","Agentcubes","Open roberta","Open Roberta","Finch robot","Finch Robot","BLOX","Tiled Grace","Bags","Squeak eToys.","StarLogo TNG","GreenFoot","AppyBuilder","Thunkable","Sketchware","UML","Ladder","Micropython","Kodu","Blockly@rduino","Blocklyduino","PencilCode","PocketCode","Deltatick","Frog Pond","Turtle Art","RoboBuilder","CodeSpells","BYOB","CustomPrograms","NetsBlox"};
	list[Result] result = analyzeDirectory(directory, tools);
	// TODO: Export results as CSV file
	persistResults(|project://SLR-WordsOcurrency/output/result.csv|, result);
	println(size(result));
}

Result fileAnalysis(loc filePath, set[str] tools) {
	PDFFile pdf = parsePDFFile(filePath);
	list[str] textWords = ( [] | it + split(" ", line) | line <- pdf.lines);
	set[str] occurrences = findOccurrences(textWords, tools);
	return pdfResult(pdf.title, filePath.file[..-4], occurrences, size(occurrences));
}

list[Result] analyzeDirectory(loc directory, set[str] tools)
  = [ fileAnalysis(file, tools) | file <- directory.ls, endsWith(file.file, ".pdf")];

// This one receive the whole document in only one list
set[str] findOccurrences(list[str] content, set[str] words) 
  = { word | word <- words, word in content};

// This is around a hundred times slower than the other implementation.
set[str] findOccurrences2(list[str] content, set[str] words) {
  set[str] r = {};
  bool guard;
  for (word <- words) {
	guard = false;
  	for (stripe <- content && !guard) { 
		if (word in split(" ", stripe)) {
  			guard = true;
  			r += word;
  		}
  	}
  }
  return r;
}

void main() {
	loc papersFolder = |file:///Users/mauricio/Documents/ResearchProjects/SLR-Block-based/Papers|;
	corporaAnalysis(papersFolder);
}