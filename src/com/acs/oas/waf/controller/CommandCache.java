package com.acs.oas.waf.controller;
// Java Utility class
import java.util.Hashtable;

import javax.servlet.http.HttpSession;

/**
 * CommandCache calls the RequestMap to get the name of the ControllerClass to
 * be invoked. The Request Map returns the class name corresponding to the URI
 * to the CommandCache. The CommandCache then looks up its Hashtable to check
 * if a Command object exists for the URI passed to it from the RouterServlet.
 * If none exist it instantiates the Command class and adds the object to its
 * Hashtable for processing future requests. The execute method on the
 * Command is then invoked with the URI, Hashmap corresponding to the
 * request from the client, and a UserSession Object.
 */
public class CommandCache
{
	// Static variable to maintain reference to the instance of this class
	// implements the singleton pattern
	private static CommandCache commandCache = new CommandCache();
	// A cache with Controller Name as key and Command object as value
	private static Hashtable controllerCommandMap = new Hashtable();
	
	/**
		* Default private constructor, takes no arguments.
		*/
	private CommandCache()
	{}
	/**
		* This method invokes the command object and returns an UserResponse object to
		* to the controller class
		* @param uri The uri of the request
		* @param request A Hashtable of the submitted form values
		* @param session An instance of the UserSession object
		* @return UserResponse from the Controller Class.
		* @throws InvalidURIException
		* @throws BusinessException Exception this method can throw
		*/
	public UserResponse executeCommand(String uri, Hashtable request, HttpSession session) throws InvalidURIException, BusinessException
	{
		// Get the class name for the uri from the RequestMap
		RequestMap rm = RequestMap.getInstance();
		if (rm.isAuthenticate(uri))
		{
			Boolean value = (Boolean) session.getAttribute("isLoggedIn");
			if (!value.booleanValue())
			{
				uri = "login.do"; // use default login page if login is incorrect
				session.setAttribute("uri", uri);
			}
		}
		String controller = rm.getController(uri);
		Command cmd = this.getCommand(controller);
		UserResponse response = cmd.execute(uri, request, session, controller);
		return response;
	}
	/**
		* Returns a handle to CommandCache object
		* @return CommandCache instance.
		*/
	public static CommandCache getInstance()
	{
		return commandCache;
	}
	/**
		* This method maintains a cache of command objects mapped against
		* the Controller name.
		* @param controller Name of the Controller class
		* @return Command  object
		*/
	private Command getCommand(String controller)
	{
		Command cmd = null;
		// Check if the command object already exists in the cache
		if (controllerCommandMap.containsKey(controller))
		{
			cmd = (Command) controllerCommandMap.get(controller);
		}
		else
		{
			// Create a new command object and add it to the hashtable
			cmd = new Command();
			controllerCommandMap.put(controller, cmd);
		}
		// Return the command object
		return cmd;
	}
}
