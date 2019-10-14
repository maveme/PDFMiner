module PDFMiner::Plugin

import IO;
import Set;
import List;
import String;
import PDFMiner::Result;
import PDFMiner::Persistence;
import PDFMiner::Analysis::PDFAnalyzer;


import util::Benchmark;


void corporaAnalysis(loc directory) {
	set[str] tools = {"Scratch","GP","gp","Snap!","Snap","Blockly","blockly","App inventor","app inventor","AppInventor","CT-Blocks","Openblocks","Makecode","StarLogoNova","Tynker","Modkit","Ardublockly","Lego Mindstorms","Dash and dot","Dash and Dot","Ozobots","Alice","Agentcubes","Open roberta","Open Roberta","Finch robot","Finch Robot","BLOX","Tiled Grace","Bags","Squeak eToys.","StarLogo TNG","GreenFoot","AppyBuilder","Thunkable","Sketchware","UML","Ladder","Micropython","Kodu","Blockly@rduino","Blocklyduino","PencilCode","PocketCode","Deltatick","Frog Pond","Turtle Art","RoboBuilder","CodeSpells","BYOB","CustomPrograms","NetsBlox"};
	list[Result] result = analyzeDirectory(directory, tools);
	persistResults(|project://SLR-WordsOcurrency/output/result.csv|, result);
	println(size(result));
}


void main() {
	loc papersFolder = |file:///Users/mauricio/Documents/ResearchProjects/SLR-Block-based/Papers|;
	corporaAnalysis(papersFolder);
}