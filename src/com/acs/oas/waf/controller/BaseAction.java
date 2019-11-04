package com.acs.oas.waf.controller;
// Java utility class
import java.util.Hashtable;

import javax.servlet.http.HttpSession;



/**
 * This class is the base class for all action classes.
 */
public class BaseAction
{
    private WafProperties waf = new WafProperties();
	public String lname = waf.getProperty("waf.logger.name");
	/**
	* Default constructor, takes no arguments.
		*/
	public BaseAction()
	{}
	/**
		* This method will be used by the subclasses to call the methods of other
	* controllers, by passing a uri pattern. But the responsibility of sending
	* the user session and user data lies with the calling controller.
	* @param uri the URI pattern
	* @param data the user data relevant to the called method
	* @param session the user session relevant to the method called
		* @return UserResponse User response object
		* @throws BusinessException if any error in the flow of execution
		* @throws InvalidURIException if any invalid URL
		*/
	public UserResponse getResponse(String uri, Hashtable data, HttpSession session) throws BusinessException, InvalidURIException
	{
		return CommandCache.getInstance().executeCommand(uri, data, session);
	}
	/**
	* This method is used as a noop to just display a jsp page.
	* @param userData User supplied data as a Hashtable
	* @param session User session
	* @return UserResponse Response from user as UserResponse object
	*/
	public UserResponse useDefault(Hashtable userData, HttpSession session) throws BusinessException
	{
		//Logger.getLogger(lname).debug("Enter useDefault.");
		UserResponse response = new UserResponse();
		//Logger.getLogger(lname).debug("Exit useDefault.");
		return response;
	}
	
	
}
