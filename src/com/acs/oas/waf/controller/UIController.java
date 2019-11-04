package com.acs.oas.waf.controller;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * This class maintains info about roles v/s URIs and JSP pages,
 * to provide a simple role based access control to JSPs and URIs
 */
public class UIController
{
	// Holds the user interface controlls
	private ResourceBundle uicontrols = null;
	// Singleton class
	private static UIController uiController = new UIController();
	/**
		* Default private constructor.
		* Instantiates the role v/s UI mapping, which is stored
		* in uiaccesscontroller.properties file
		*/
	private UIController()
	{
		try
		{
			uicontrols = ResourceBundle.getBundle("uiaccesscontroller");
		}
		catch (Exception ex)
		{
			
		}
	}
	/**
		* The method returns a UI resource for a given role and UI ID.
		* @param role
		* @param id
		* @return String The UI resource
		* @throws UINotFoundException  if the rol/id combination is not found
		*/
	public String getUI(String role, String id) throws UINotFoundException
	{
		try
		{
			return uicontrols.getString(role + "." + id);
		}
		catch (MissingResourceException ex)
		{
			throw new UINotFoundException("No UI Mapping present for " + role + "." + id);
		}
	}
	/**
		* Singleton access method
		* @return UIController Singleton instance of UIController
		*/
	public static UIController getInstance()
	{
		return uiController;
	}
}
