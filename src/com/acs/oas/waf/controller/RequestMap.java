package com.acs.oas.waf.controller;
// Java Utility classes.
import java.util.Hashtable;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
/**
 * This class loads the property file and builds the mapping object using
 * URIMapping class and then puts into the cache.
 */
public class RequestMap
{
	// RequestMap object
	private static RequestMap requestMap = null;
	// URI mapping hash table
	private static Hashtable mappingTable = new Hashtable();
	/**
	 * Default private constructor, takes no arguments.
	 */
	private RequestMap()
	{}
	public Hashtable getTable()
	{
		return mappingTable;
	}
	/**
	 * Returns name of the jsp page, from the hashtable coresponding
	 * to the key(uri) passed as the parameter to the method.
	 * @param uri key for which jsp page to be returned.
	 * @return StringThe jsp page name.
	 * @throws InvalidURIException for any invalid URI
	 */
	public String getJsp(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
			Logger.getLogger("oas").debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI: '" + uri + "' not found");
		}
		String jspPage = ((URIMapping) mappingTable.get(uri)).getJsp();
		//Logger.getLogger("oas").debug("JSP PAGE: " +jspPage);
		return jspPage;
	}
	/**
	 * Returns true the controller-method can invalidate the session
	 * for the uri passed as the parameter to the method.
	 * @param uri key for which sessionInvalidation infromation
	 * @return booleanThe value of SessionInvalidate flag for the uri
	 * @throws InvalidURIException for any invalid URI
	 */
	public boolean isSessionInvalidate(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
//			Logger.getLogger(RouterServlet.lname).debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI '" + uri + "' not found.");
		}
		return ((URIMapping) mappingTable.get(uri)).isSessionInvalidate();
	}
	/**
	 * Returns the complete property object for the given uri
	 * passed as the parameter to the method..
	 * @param uri key for which property object to be returned.
	 * @return URIMapping An object representation of the property file
	 * @throws InvalidURIException for any invalid URI
	 */
	public URIMapping getURIMapping(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
//			Logger.getLogger(RouterServlet.lname).debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI '" + uri + "' not found!");
		}
		return ((URIMapping) mappingTable.get(uri));
	}
	/**
		 * Returns name of the method from the hashtable coresponding to
		 * the key(uri) passed as the parameter to the method.
		 * @param uri name for which the method name to be returned.
		 * @return String The method name
		 * @throws InvalidURIException for any invalid URI
		 */
	public String getMethod(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
//			Logger.getLogger(RouterServlet.lname).debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI '" + uri + "' not found");
		}
		return ((URIMapping) mappingTable.get(uri)).getMethod();
	}
	/**
	 * Returns true if authentication is required for the given uri,
	 * else returns false.
	 * @param uri name for which authentication information to be returned.
	 * @return booleanThe value of authenticate flag for the uri
	 * @throws InvalidURIException for any invalid URI
	 */
	public boolean isAuthenticate(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
//			Logger.getLogger(RouterServlet.lname).debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI '" + uri + "' was not found");
		}
		return ((URIMapping) mappingTable.get(uri)).isAuthenticate();
	}
	/**
	 * Returns name of the controller from the hashtable coresponding to
	 * the key(uri) passed as the parameter to the method.
	 * @param uri The uri for which controller to be returned.
	 * @return String The controller name.
	 * @throws InvalidURIException for any invalid URI
	 */
	public String getController(String uri) throws InvalidURIException
	{
		if (!mappingTable.containsKey(uri))
		{
			StringBuffer sb = new StringBuffer();
			java.util.Enumeration e = mappingTable.keys();
			while (e.hasMoreElements())
			{
				sb.append(((String) e.nextElement()) + ", ");
			}
//			Logger.getLogger(RouterServlet.lname).debug("List of keys from mapping table: " + sb.toString());
			throw new InvalidURIException("Requested URI ::'" + uri + "' not found");
		}
		return ((URIMapping) mappingTable.get(uri)).getController();
	}
	/**
	 * Returns instance of RequestMap
	 * @return RequestMap  The instance of this singleton class
	 */
	public static RequestMap getInstance() throws InvalidURIException
	{
		if (requestMap == null)
		{
			requestMap = new RequestMap();
			try
			{
				mappingTable = new Hashtable(XMLProcessor.getInstance().getRequestMapping());
			}
			catch (Exception ex)
			{
//				Logger.getLogger(RouterServlet.lname).error("Error parsing requestmap."+ ExceptionUtils.getFullStackTrace(ex));
				throw new InvalidURIException(ex.getMessage());
			}
		}
		return requestMap;
	}
}