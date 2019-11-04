package com.acs.oas.waf.controller;

import java.util.HashMap;

import org.xml.sax.Attributes;
import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;

/**
 * The class implements the ContentHandler interface of SAX. As SAX events
 * are generated, the corresponding methods in this implementation are called.
 * The implementaion knows how to handle individual tags, attributes etc.
 * This class creates a URIMapping object for every <uri-mapping> tag it
 * encounters and populates this object with the children of this tag
 * The class also has a method to return all these objects as a table, placed
 * against the URIs.
 */
class RequestMapHandler implements ContentHandler
{
	// Table of URIs v/s URIMapping objects
	private HashMap mappings = new HashMap();

	// Current map
	private URIMapping currentMap = null;

	private String classAttr = "";
	private String methodAttr = "";
	private String uri = "";
	private String jsp = "";
	private String auth = "";
	private String inval = "";
	private String currentTag = "";

	// List of roles specified for the current <uri-mapping>
//	private List roles = new ArrayList();

	/**
		* The method handles the PCData part of an element.This is called
		* when the parser encounters PCData for an element.
		* @param ch Array of parsed characters
		* @param start Starting point in the character array
		* @param length Length of PCData for the current element
		*/
	public void characters(char[] ch, int start, int length)
	{
		String charString = new String(ch, start, length);
		if (!charString.trim().equals(""))
		{
//			Logger.getLogger(RouterServlet.lname).debug("characters: currentTag= " + currentTag + " char=" + charString);
			if (currentTag.equals("uri"))
			{
				uri += charString.toLowerCase();
			}
			else if (currentTag.equals("jsp-template"))
			{
				jsp += charString;
			}
			else if (currentTag.equals("authenticate"))
			{
				auth += charString;
			}
			else if (currentTag.equals("invalidate-session"))
			{
				inval += charString;
			}
			else if (currentTag.equals("role"))
			{
				//uri += new String(ch, start, length);
				// If element is <role>, add this to current role list
				//roles.add(new String(ch, start, length));
			}
		}
	}
	/**
		* The method is called when the parser encounters start of an element.
		* @param namespaceURI The namespace URI of the element
		* @param localName localname of the element
		* @param qName SAX 1.0 qualified name of the element
		* @param atts Attribute list for the element
		*/
	public void startElement(String namespaceURI, String localName, String qName, Attributes atts)
	{
//		Logger.getLogger(RouterServlet.lname).debug("startElement - currentTag: " + localName);
		currentTag = localName;
		if (localName.equals("uri-mapping"))
		{
			// Create a URIMapping instance if the current tag is <uri>
			currentMap = new URIMapping();
//			Logger.getLogger(RouterServlet.lname).debug("startElement - currentTag=uri-mapping: Created currentMap object.");
		}
		else if (localName.equals("controller"))
		{
			String tmpClassAttr = atts.getValue("class");
			String tmpMethodAttr = atts.getValue("method");
			if (tmpClassAttr != null)
			{
				classAttr = atts.getValue("class");
//				Logger.getLogger(RouterServlet.lname).debug("startElement - currentTag=controller: classAttr=" + classAttr);
			}
			if (tmpClassAttr != null)
			{
				methodAttr = atts.getValue("method");
//				Logger.getLogger(RouterServlet.lname).debug("startElement - currentTag=controller: methodAttr=" + methodAttr);
			}
		}
		else
		{
//			Logger.getLogger(RouterServlet.lname).debug("startElement - currentTag=" + currentTag);
		}
	}
	/**
		* The method is called when the parser encounters end of an element.
		* @param namespaceURI The namespace URI of the element
		* @param localName localname of the element
		* @param qName SAX 1.0 qualified name of the element
		*/
	public void endElement(String namespaceURI, String localName, String qName)
	{
//		Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=" + localName);
		if (localName.equals("controller"))
		{
			currentMap.setController(classAttr);
			currentMap.setMethod(methodAttr);
//			Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=controller: classAttr=" + classAttr + " methodAttr=" + methodAttr);
		}
		else if (localName.equals("uri"))
		{
			currentMap.setUri(uri);
//			Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=controller: uri=" + uri);
		}
		else if (localName.equals("jsp-template"))
		{
			currentMap.setJsp(jsp);
//			Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=controller: jsp=" + jsp);
		}
		else if (localName.equals("authenticate"))
		{
			if (auth.equalsIgnoreCase("TRUE"))
			{
				currentMap.setAuthenticate(true);
			}
//			Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=controller: authenticate=" + auth);
		}
		else if (localName.equals("invalidate-session"))
		{
			if (inval.equalsIgnoreCase("TRUE"))
			{
				currentMap.setInvalidate(true);
			}
//			Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=controller: invalidate-session=" + inval);
		}
		// If the tag ending is </security> set the roles
		else if (localName.equals("role"))
		{
//			currentMap.setRoles((String[]) roles.toArray(new String[0]));
//			roles.clear();
		}
		else if (localName.equals("uri-mapping"))
		{
			if (currentMap.getJsp() == null || currentMap.getJsp().equals(""))
			{
				throw new RuntimeException("JSP can't be null for uri=" + uri);
			}
			if (currentMap.getUri() == null || currentMap.getUri().equals(""))
			{
				throw new RuntimeException("Uri can't be null");
			}
			if (currentMap.getController() == null || currentMap.getController().equals(""))
			{
				throw new RuntimeException("Controller class can't be null for uri=" + uri);
			}
			if (currentMap.getMethod() == null || currentMap.getMethod().equals(""))
			{
				throw new RuntimeException("Controller method can't be null for uri=" + uri);
			}
			if (currentMap.getMethod() == null || currentMap.getMethod().equals(""))
			{
				throw new RuntimeException("Controller method can't be null for uri=" + uri);
			}

			mappings.put(uri, currentMap);
			classAttr = "";
			methodAttr = "";
			uri = "";
			jsp = "";
			auth = "";
			inval = "";

			//Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=uri-mapping: set mapping");
		}
		else
		{
			//Logger.getLogger(RouterServlet.lname).debug("endElement - currentTag=" + localName);
		}
	}
	/**
		* The method is called when the parser encounters end of scope prefix.
		* @param prefix The scope prefix
		*/
	public void endPrefixMapping(java.lang.String prefix)
	{}
	/**
		* The method is called when the parser encounters
		* ignorable whitespace in element content.
		* @param ch Array of parsed characters
		* @param start Starting point in the character array , for the
		* current element
		* @param length Length of PCData for the current element
		*/
	public void ignorableWhitespace(char[] ch, int start, int length)
	{}
	/**
		* The method is called when the parser encounters a processing instruction.
		* @param target Target of PI
		* @param data PI data
		*/
	public void processingInstruction(String target, String data)
	{}
	/**
		* The method is called when the parser encounters an object
		* for locating the origin of SAX document events.
		* @param locator Locator instance
		*/
	public void setDocumentLocator(Locator locator)
	{}
	/**
		* The method is called when the parser encounters a skipped entity.
		* @param name Entity name
		*/
	public void skippedEntity(java.lang.String name)
	{}
	/**
		* The method is called when the parser encounters the beginning of the doc
		*/
	public void startDocument()
	{}

	/**
		* The method is called when the parser begins the scope
		* of a prefix-URI Namespace mapping.
		* @param prefix The scope prefix
		* @param uri The scope prefix URI
		*/
	public void startPrefixMapping(String prefix, String uri)
	{}
	/**
		* The method is called when the parser encounters end of the document.
		*/
	public void endDocument()
	{}

	/**
		* The method returns a table of URIs v/s URIMapping objects
		* Returns an empty table if called before parsing
		* @return HashMap table of URIs v/s URIMapping objects
		*/
	public HashMap getRequestMapping()
	{
		return mappings;
	}
}