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


import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
 
/**
 *
 * @author iText
 */
public class ReceiptGenerator {
   // public static final String DEST = "html_table_2.pdf";
    public static final String CSS = "table { width:55%;} th { background-color: seagreen; padding: 3px;color:white;font-size:30px; text-align:center;padding:3%; } td {background-color: lightblue;  padding: 3px; } img {padding:2%;}";
    
    ReceiptGenerator(){
    	
    }
    
    public void createPdf(String file) throws IOException, DocumentException {
        // step 1
        Document document = new Document();
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
        // step 3
        document.open();
        // step 4
        document.add(new Paragraph("This is my HTML table:"));
        document.add(Chunk.NEWLINE);
        PdfPTable table = getTable();
        document.add(table);
		document.add(Chunk.NEWLINE);
		document.add(Chunk.NEXTPAGE);
        // step 5
        document.close();
    }
 
    public PdfPTable getTable() throws IOException {
 
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        sb.append("<tr>");
        sb.append("<th colspan=\"3\">Student Id Card</th>");
        sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> 2010-2020");
			sb.append("</td>");
			sb.append("<td rowspan=\"7\"><img src=\"cd-1.jpg\" height=\"150px\" width=\"117px\"/>");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> Name : Panchal Krunal");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> D.O.B. : 02/10/1991");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> ID No : 01010101");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> Exp Date : 12/12/2020");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> Rollwala Computer Center");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"2\"> Gujarat University");
			sb.append("</td>");
		sb.append("</tr>");
		
		sb.append("<tr>");
			sb.append("<td colspan=\"3\"> for the confirmation of the holder's identity call 0845 658 0845");
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