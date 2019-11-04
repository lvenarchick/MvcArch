package com.acs.oas.waf.controller;
// Java Utility class
import java.lang.reflect.Method;
import java.util.Hashtable;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;


/**
 * The command class maintains a Hashtable which is a cache of method objects
 * mapped against the URI. The command class invokes the RequestMap to get the
 * method name for the URI passed to it. It then checks if the method object
 * exists within its cache else creates one and adds it to the Hashtable.
 * The method on the controller is then invoked using reflection.
 * The Controller invokes the appropriate class and gets back a Response
 * object which is ultimately returned to the RouterServlet.
 */
public class Command
{
	// A Generic Controller Object
	private BaseAction baseAction;
	// A cache of method objects mapped against the request uri
	private Hashtable uriMethodMap = new Hashtable();
	private WafProperties waf = new WafProperties();
	public String lname = waf.getProperty("waf.logger.name");
	
	/**
		* This method uses reflection to identify the Controller class and the method
		* in the class.  The response from the method is returned to CommandCache
		* @param uri The uri of the request
		* @param request The submitted form values
		* @param session A reference to the UserSession
		* @param controller The name of the controller to be invoked
		* @return UserResponse Response from the controller
		* @throws BusinessException if any error in the flow of execution
		*/
	public UserResponse execute(String uri, Hashtable request,HttpSession session, String controller) throws BusinessException
	{
		// Initialize Response object
		UserResponse response = null;
		String methodName = null;
		try
		{
			// This object will provides access to the required
			// method on the Controller Class
			Method methodObject = null;
			// Create the controller object only if not created previously
			if (baseAction == null)
			{
				baseAction = (BaseAction) Class.forName(controller).newInstance();
			}
			// Check the cache for method object
			if (uriMethodMap.containsKey(uri))
			{
				methodObject = (Method) uriMethodMap.get(uri);
			}
			else
			{
				// An array of Class objects that identify the method's formal
				// parameter types in declared order
				Class[] paramTypes = new Class[] { Hashtable.class, HttpSession.class };
				// Get the method name from the RequestMap and instantiate the method
				methodName = RequestMap.getInstance().getMethod(uri);
				methodObject = baseAction.getClass().getMethod(methodName, paramTypes);
				// Cache this method object
				uriMethodMap.put(uri, methodObject);
			}
			// Create an object array of the parameters to be passed to the method
			Object[] params = { request, session };
			// Execute the method on the specified controller object using reflection
			response = (UserResponse) methodObject.invoke(baseAction, params);
		}
		catch (Exception ex)
		{
			Logger.getLogger(lname).error("Exception in Command.execute: "+ ExceptionUtils.getFullStackTrace(ex));
			response = new UserResponse();
			response.setResponse("Exception", ex);
			response.setResponse("View", "displayError");
		}
		finally
		{}
		return response;
	}
}
