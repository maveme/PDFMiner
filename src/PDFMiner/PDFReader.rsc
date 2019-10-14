module PDFMiner::PDFReader

import String;
import PDFMiner::PDFFile;


@javaClass{PDFMiner.PDFReader}
public java PDFFile readPDFFile(loc path);

PDFFile parsePDFFile(loc filePath) {
	PDFFile doc = readPDFFile(filePath);
	list[str] stripes = split("\n", doc.text);
	return pdf(doc.title, stripes);
}