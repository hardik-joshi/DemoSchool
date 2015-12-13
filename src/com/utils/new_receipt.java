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
import com.itextpdf.text.Image;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
 
/**
 *
 * @author iText
 */
public class new_receipt 
{
	public static final String DEST = "e:/exam_fees_new_2.pdf";
    public static final String CSS = "table { width:100%;font-family:calibri;padding:20px;} th {padding: 3px;color:white;font-size:30px; text-align:center;padding:3%; } td { padding: 7px;font-size:14px;border-bottom:1px solid black; } img {padding:2%;}";
 
    public static void main(String[] args) throws IOException, DocumentException 
	{
        File file = new File(DEST);
        new new_receipt().createPdf(DEST);
    }
 
    public void createPdf(String file) throws IOException, DocumentException 
	{
        // step 1
        Document document = new Document();
        // step 2
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
        // step 3
        document.open();
        // step 4
		
		for(int i=0;i<2;i++)
		{
			if(i%2 == 0)
			{
				PdfPTable blank_line_table = blank_line();
				document.add(blank_line_table);
				
				PdfPTable first_line_table = first_line();
				document.add(first_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable second_line_table = second_line();
				document.add(second_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable third_line_table = third_line();
				document.add(third_line_table);
				
				Image image1 = Image.getInstance("gu_logo.png");
				image1.setAbsolutePosition(300f, 700f);
				//document.add(Chunk.TABBING);
				document.add(image1);
				
				Image image2 = Image.getInstance("Untitled.png");
				image2.setAbsolutePosition(440f, 630f);
				image2.scaleAbsolute(100f, 120f);
				//document.add(Chunk.TABBING);
				document.add(image2);
				
				document.add(Chunk.NEWLINE);
				PdfPTable fourth_line_table = fourth_line();
				document.add(fourth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable fifth_line_table = fifth_line();
				document.add(fifth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable sixth_line_table = sixth_line();
				document.add(sixth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable seventh_line_table = seventh_line();
				document.add(seventh_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable eighth_line_table = eighth_line();
				document.add(eighth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable ninth_line_table = ninth_line();
				document.add(ninth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable tenth_line_table = tenth_line();
				document.add(tenth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable elevanth_line_table = elevanth_line();
				document.add(elevanth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable twelve_line_table = twelve_line();
				document.add(twelve_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable thirteen_line_table = thirteen_line();
				document.add(thirteen_line_table);
				
				
				document.add(blank_line_table);
				
			}
			else
			{	
				PdfPTable blank_line_table = blank_line();
				//document.add(blank_line_table);
				
				PdfPTable first_line_table = first_line();
				document.add(first_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable second_line_table = second_line();
				document.add(second_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable third_line_table = third_line();
				document.add(third_line_table);
				
				Image image1 = Image.getInstance("gu_logo.png");
				image1.setAbsolutePosition(300f, 360f);
				//document.add(Chunk.TABBING);
				document.add(image1);
				
				Image image2 = Image.getInstance("Untitled.png");
				image2.setAbsolutePosition(440f,290f);
				image2.scaleAbsolute(100f, 120f);
				//document.add(Chunk.TABBING);
				document.add(image2);
				
				document.add(Chunk.NEWLINE);
				PdfPTable fourth_line_table = fourth_line();
				document.add(fourth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable fifth_line_table = fifth_line();
				document.add(fifth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable sixth_line_table = sixth_line();
				document.add(sixth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable seventh_line_table = seventh_line();
				document.add(seventh_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable eighth_line_table = eighth_line();
				document.add(eighth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable ninth_line_table = ninth_line();
				document.add(ninth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable tenth_line_table = tenth_line();
				document.add(tenth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable elevanth_line_table = elevanth_line();
				document.add(elevanth_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable twelve_line_table = twelve_line();
				document.add(twelve_line_table);
				
				document.add(Chunk.NEWLINE);
				PdfPTable thirteen_line_table = thirteen_line();
				document.add(thirteen_line_table);
				document.add(blank_line_table);
				document.add(Chunk.NEXTPAGE);
			}
			
		}
        // step 5
        document.close();
		
    }
	public PdfPTable blank_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        sb.append("<tr>");
				sb.append("<td style=\"font-size:23px;text-align:center;\" colspan=\"5\">------------------------------------------------------------------------------------------------");
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
	public PdfPTable first_line() throws IOException 
	{		
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<th></th>");
			sb.append("</tr>");
			sb.append("<tr>");
				sb.append("<td>621-1,50,000-11-2011");
				sb.append("</td>");
				sb.append("<td>Class : ");
				sb.append("<label><b><i><u>MCA-6</u></i></b>");
				sb.append("</label>");
				sb.append("</td>");
				sb.append("<td>Roll No : <b><i><u>12</u></i></b>");
				sb.append("</td>");
				sb.append("<td>Uni. Seat No : <b><i><u>5012</u></i></b>");
				sb.append("</td>");
				sb.append("<td style=\"padding-left:40px;\">Candidate's Copy");
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
	public PdfPTable second_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
        sb.append("<tr>");
				sb.append("<td style=\"font-size:23px;text-align:center;\" colspan=\"5\">GUJARAT UNIVERSITY");
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
	public PdfPTable third_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"2\">No :");
				sb.append("<label> <b><i>11111</i></b></label>");
				sb.append("</td>");
				sb.append("<td colspan=\"2\" style=\"text-align:left;padding-left:100px;\">");
				sb.append("</td>");
				sb.append("<td></td>");
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
	public PdfPTable fourth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td>Received From Shri/Smt.");
				sb.append("</td>");
				sb.append("<td colspan=\"3\" style=\"padding-right:150px;border-bottom:3px dashed black;\"><u>_________________<b><i>Krunal M. Panchal</i></b>________________</u>");
				sb.append("</td>");
				sb.append("<td>");
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
	public PdfPTable fifth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td>Rupees (in words");
				sb.append("</td>");
				sb.append("<td><b><i><u>__________Five Hundred Only_________</u></i></b>");
				sb.append("</td>");
				sb.append("<td style=\"padding-right:180px;\">only) for the following:");
				sb.append("</td>");
				sb.append("<td colspan=\"2\">");
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
	public PdfPTable sixth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td style=\"padding-left:20px;\">1.Examination Fees Rs.");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("<label><b><i><u>____500___</u></i></b></label>");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("<label>for</label>");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("<label><b><i><u>_____none_____</u></i></b></label>");
				sb.append("</td>");
				sb.append("<td style=\"padding-right:200px;\">");
				sb.append("<label>Examination. </label>");
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
	
	public PdfPTable seventh_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"2\" style=\"padding-left:20px;\">2.Marks Statements fees Rs.");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("<label><b><i><u>_____500_____</u></i></b></label>");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("<label>Total Fees</label>");
				sb.append("</td>");
				sb.append("<td style=\"padding-right:200px;\">");
				sb.append("<label><b><i><u>_____500_____</u></i></b></label>");
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
	
	public PdfPTable eighth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"2\">Signature of the Head of College : _______________________________");
				sb.append("</td>");
				sb.append("<td>");
				sb.append("</td>");
				sb.append("<td colspan=\"2\">__________________________________");
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
	
	public PdfPTable ninth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"3\">Candidate's Signature : _____________________________");
				sb.append("</td>");
				sb.append("<td colspan=\"2\" style=\"text-align;left;\">for,Registrar");
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
	
	public PdfPTable tenth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"5\">I identify that the above photograph is of the candidate named in the receipt who has signed in my presence.");
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
	public PdfPTable elevanth_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td>Date:________");
				sb.append("</td>");
				sb.append("<td>");
					sb.append("<label></label>");
				sb.append("</td>");
				sb.append("<td colspan=\"2\" style=\"text-align:center;\">");
					sb.append("<label>Principal's Signature and College Stamp :</label>_____________________________________________");
				sb.append("</td>");
				sb.append("<td>");
					
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
	
	public PdfPTable twelve_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"5\">College stamp must be affixed on the photograph by the College Office in such a way that the photograph bears half the impression of the stamp and the other half impression appears on the fee receipt.");
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
	
	public PdfPTable thirteen_line() throws IOException 
	{
        StringBuilder sb = new StringBuilder();
        sb.append("<table>");
			sb.append("<tr>");
				sb.append("<td colspan=\"5\">");
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

