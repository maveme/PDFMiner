package org.rascal.pdfReader;

import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.rascalmpl.uri.URIResolverRegistry;

import io.usethesource.vallang.IConstructor;
import io.usethesource.vallang.ISourceLocation;
import io.usethesource.vallang.IValueFactory;
import io.usethesource.vallang.type.Type;
import io.usethesource.vallang.type.TypeFactory;
import io.usethesource.vallang.type.TypeStore;


// https://www.mkyong.com/java/pdfbox-how-to-read-pdf-file-in-java/


public class PDFReader {

	private IValueFactory vf;
	private TypeFactory tf;
	private TypeStore tStore;
	private PDFTextStripper textStripper;
	private Type pdfFileADT;
	private Type pdfConstructor;


	public PDFReader(IValueFactory vf) {
		this.vf = vf;
		this.tf = TypeFactory.getInstance();
		this.tStore =  new TypeStore();
		this.pdfFileADT = tf.abstractDataType(tStore, "PDFFile");
		this.pdfConstructor = tf.constructor(tStore, pdfFileADT, "pdf", tf.stringType(), "title", tf.stringType(), "text");
		
		try {
			this.textStripper = new PDFTextStripper();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public IConstructor readPDFFile(ISourceLocation path) {
		try (PDDocument document = PDDocument.load(URIResolverRegistry.getInstance().getInputStream(path))) {
			document.getClass();

			PDDocumentInformation pdfInformation  = document.getDocumentInformation();
			String title = pdfInformation.getTitle();
			String keywords = pdfInformation.getKeywords();
			pdfInformation.getSubject();
			

			if (!document.isEncrypted()) {
				PDFTextStripperByArea stripper = new PDFTextStripperByArea();
				stripper.setSortByPosition(true);
				String pdfText = this.textStripper.getText(document);
				
				return vf.constructor(pdfConstructor, vf.string(title), vf.string(pdfText));

			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return vf.constructor(pdfConstructor, vf.string("Error"), vf.string("Error"));
	}
}

//public class PDF {
//	
//	public String title;
//	public String text;
//	
//	public PDF(String pTitle, String pText) {
//		this.title = pTitle;
//		this.text = pText;
//	}
//}