package com.acs.oas.waf.controller;
/**
 * This class is the object representation of the properties file.
 */
public class URIMapping
{
	private String controller;
	private String method;
	private String jsp;
	private String uri;
	// Stores the required roles for the URL
	private String[] roles;
	private boolean authenticate = false;
	private boolean sessionInvalidate = false;
	/**
		* Default Constructor. Takes no arguments
		*/
	public URIMapping()
	{}
	/**
		* Sets the method name for this object.
		* @param methodName The method name.
		*/
	public void setMethod(String methodName)
	{
		method = methodName;
	}
	/**
		* Sets the session invalidating property to true/false
		* @param invalidate Boolean value of the session invalidate flag
		*/
	public void setInvalidate(boolean invalidate)
	{
		sessionInvalidate = invalidate;
	}
	/**
		* Gets the  valid roles for this URI
		* @return  String[] Array of roles
		*/
	public String[] getRoles()
	{
		return roles;
	}
	/**
		* Checks if the supplied role is valid
		* @param role
		* @return boolean true if the role is valid, false otherwise
		*/
	public boolean isValidRole(String role)
	{
		// If no roles are specified for this URI, all roles are allowed
		if (roles == null || roles.length == 0)
		{
			return true;
		}
		for (int i = roles.length - 1; i >= 0; i--)
		{
			if (roles[i].equals(role))
			{
				return true;
			}
		}
		// Role does not match any of the set roles
		return false;
	}
	/**
		* Returns the name of the jsp.
		* @return String The name of the jsp.
		*/
	public String getJsp()
	{
		return jsp;
	}
	/**
		* Sets the request uri for this object.
		* @param uri The request uri.
		*/
	public void setUri(String uri)
	{
		this.uri = uri;
	}
	/**
		* Sets the controller class name.
		* @param controller The controller name.
		*/
	public void setController(String controller)
	{
		this.controller = controller;
	}
	/**
		* Sets the authentication property to  true/false
		* @param authenticate  Boolean value of the authenticate flag
		*/
	public void setAuthenticate(boolean authenticate)
	{
		this.authenticate = authenticate;
	}
	/**
		* Returns the requested uri.
		* @return StringThe request uri.
		*/
	public String getUri()
	{
		return uri;
	}
	/**
		* Sets the jsp property for this object,from the propery file.
		* @param jsp The jsp page.
		*/
	public void setJsp(String jsp)
	{
		this.jsp = jsp;
	}
	/**
		* Returns name of the controller class.
		* @return StringThe controller class name.
		*/
	public String getController()
	{
		return controller;
	}
	/**
		* sets the  valid roles for this URI
		* @param roles Array of roles
		*/
	public void setRoles(String[] roles)
	{
		this.roles = roles;
	}
	/**
		* Returns name of the method.
		* @return StringName of the method.
		*/
	public String getMethod()
	{
		return method;
	}
	/**
		* Overrriden method, returns a String object representing the property object.
		* @return String String Representation of the object.
		*/
	public String toString()
	{
		return "[ Uri=" + uri + " Controller=" + controller + " Method=" + method + " Authentication=" + authenticate + " Invalidate=" + sessionInvalidate + " Jsp=" + jsp + "  ]" + " Roles=" + (roles == null ? "0" : String.valueOf(roles.length));
	}
	/**
		* Returns true if authentication required against the requesting uri.
		* @return String Boolean value of the authenticate flag
		*/
	public boolean isAuthenticate()
	{
		return authenticate;
	}
	/**
		* Returns true if method-controller can invalidate the session for
		* the requested uri else false.
		* @return String Boolean value of the session invalidate flag
		*/
	public boolean isSessionInvalidate()
	{
		return sessionInvalidate;
	}
}