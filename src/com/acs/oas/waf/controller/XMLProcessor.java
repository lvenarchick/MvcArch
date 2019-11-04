package com.acs.oas.waf.controller;
import java.io.BufferedInputStream;
import java.io.InputStream;
import java.util.HashMap;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 * This class is a SingleTon class which parses the requestmap.xml file
 * located in the classpath and creates a HashMap of uris v/s URIMapping objects.
 * Each URIMapping object maps to the <uri-mapping> element in the XML file.
 */
public class XMLProcessor
{
	// SingleTon instance of the processor
	private static XMLProcessor processor = new XMLProcessor();
	/** Default parser name. */
	protected static final String DEFAULT_PARSER_NAME = "org.apache.xerces.parsers.SAXParser";
    private WafProperties waf = new WafProperties();
	public String lname = waf.getProperty("waf.logger.name");

	/**
	* Defalult private constructor, takes no arguments.
	*/
	private XMLProcessor()
	{}
	/**
	* Static method to access the singleton instance
	* @return XMLProcessor the SingleTon instance of XMLProcessor
	*/
	public static XMLProcessor getInstance()
	{
		return processor;
	}
	/**
		* Returns a table of URIs v/s URIMapping objects, which are
		* read from the requestmap.xml file
		* @return HashMap table of URIs v/s URIMapping objects
		*/
	public HashMap<?, ?> getRequestMapping()
	{
		RequestMapHandler handler = null;
		try
		(
			InputStream is = getClass().getClassLoader().getResourceAsStream("requestmap.xml");
			BufferedInputStream bis = new BufferedInputStream(is);
		)
		{
			XMLReader reader = XMLReaderFactory.createXMLReader(DEFAULT_PARSER_NAME);
			handler = new RequestMapHandler();
			reader.setContentHandler(handler);
			InputSource iSource = new InputSource(bis);
			reader.parse(iSource);
		}
		catch (Exception ex)
		{
			Logger.getLogger(lname).error("XMLProcessor Error: "+ ExceptionUtils.getFullStackTrace(ex));			
			throw new IllegalArgumentException(ex.getMessage());
		}
		finally 
		{
			//empty
		}
		return handler.getRequestMapping();
	}
}
