package com.utils;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.ElementList;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.ElementHandlerPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.model.Person;
import com.model.Student;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

 
/**
 *
 * @author iText
 */
public class IDCardGenerator {
   // public static final String DEST = "html_table_2.pdf";
    public static final String CSS = "table { width:55%;} th { background-color: seagreen; padding: 3px;color:white;font-size:30px; text-align:center;padding:3%; } td {background-color: lightblue;  padding: 3px; } img {padding:2%;}";
    
    List<Person> persons;
    List<Student> students;
    List<Person> mothers;
    List<Person> fathers;
    IDCardGenerator(List<Person> persons, List<Student> students, List<Person> mothers, List<Person>fathers){
    	this.students = students;
    	this.persons = persons;
    	this.mothers = mothers;
    	this.fathers = fathers;
    }
    
    IDCardGenerator(){
    	
    }
    
   /* public static void main(String[] args) throws IOException, DocumentException {
       // File file = new File(DEST);
        //new ParseHtmlTable2().createPdf(DEST);
    }*/
 
    /**
     * Creates a PDF with the words "Hello World"
     * @param file
     * @throws IOException
     * @throws DocumentException
     */
    public void createPdf(String file) {
    	
    	
    	try{
    		
    		System.out.println("file name = " + file);
    	
        // step 1
        Document document = new Document();
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
        // step 3
        document.open();
        // step 4
       // document.add(new Paragraph("This is my HTML table:"));
        document.add(Chunk.NEWLINE);
        for(int i = 0; i<students.size(); i++){
        	PdfPTable table = getTable(persons.get(i),students.get(i), mothers.get(i), fathers.get(i));
        	document.add(table);
        	if((i+1)%3 == 0){
        		//document.add(Chunk.NEWLINE);
        		document.add(Chunk.NEXTPAGE);
        	}
        }
        
       
		
        // step 5
        System.out.println("closed document");
        document.close();
        
        BufferedReader br = new BufferedReader(new FileReader(file));
        
        while(br.readLine()!=null){
        	
        	System.out.println(br.readLine());
        }
        
    	}
    	catch(Exception e){
    		e.printStackTrace();
    	}
    }
 
    public PdfPTable getTable(Person per, Student s, Person mother, Person father) throws IOException {
 
    	String name = " " + per.getLastName() + " " + per.getFirstName();
		String dob =  per.getDob();
		String grNo = String.valueOf(s.getGrNo());
    	/*
		String photo = per.getPhoto();
    	
		File f = new File("cd-1.jpg");
		
		byte[] data = Base64.decodeBase64(photo);
		try (OutputStream stream = new FileOutputStream(f)) {
		    stream.write(data);
		} */
		
    	StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        sb.append("<tr>");
        sb.append("<th colspan=\"3\">National English School</th>");
        sb.append("</tr>");
		
		sb.append("<tr>");
		sb.append("<td colspan=\"2\"> Gr No :" + s.getGrNo());
			sb.append("</td>");
			sb.append("<td rowspan=\"6\"><img src=\"cd-1.jpg\" height=\"150px\" width=\"117px\"/>");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			
			
			sb.append("<td colspan=\"2\"> Name :" + name);
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> D.O.B. :"+ per.getDob());
			sb.append("</td>");
		sb.append("</tr>");
		
		
		sb.append("<tr>");
		sb.append("<td colspan=\"2\"> Standard: V");
		sb.append("</td>");
	sb.append("</tr>");
	
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> Contact Number :" + per.getMobileNo());
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> School  Number : 9898212129");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"3\"> School Address: Vatva Road, Isanpur, 382443");
			sb.append("</td>");
		sb.append("</tr>");
        sb.append("</table>");
 
 
 
        CSSResolver cssResolver = new StyleAttrCSSResolver();
        CssFile cssFile = XMLWorkerHelper.getCSS(new ByteArrayInputStream(CSS.getBytes()));
        cssResolver.addCss(cssFile);
 
        // HTML
        HtmlPipelineContext htmlContext = new HtmlPipelineContext(null);
        htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());
 
        // Pipelines
        ElementList elements = new ElementList();
        ElementHandlerPipeline pdf = new ElementHandlerPipeline(elements, null);
        HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
 
        // XML Worker
        XMLWorker worker = new XMLWorker(css, true);
        XMLParser p = new XMLParser(worker);
        p.parse(new ByteArrayInputStream(sb.toString().getBytes()));
 
        return (PdfPTable)elements.get(0);
    }
}