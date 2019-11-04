package com.acs.oas.waf.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.acs.oas.components.valueobject.SessionVO;
/**
 * This class represents the user session. This internally uses HttpSession
 * for storing key-value pairs.
 */
public class UserSession1 
{
	private HttpSession userSession;
	private HttpServletRequest userRequest;
	{}
	/**
	* Constructor which takes HttpSession as the parameter.
	*/
	public UserSession1(HttpServletRequest request)
	{	
		
		this.userSession.invalidate();		
	    this.userSession = request.getSession(true);
	    String requestUrl = request.getRequestURL().toString();
		int endLocation = requestUrl.lastIndexOf("/");
		String uri = requestUrl.substring(endLocation + 1);	
	    endLocation = requestUrl.lastIndexOf(uri);
		String newUrl = requestUrl.substring(0, endLocation);
		SessionVO sessionVO = new SessionVO(uri,newUrl);
		sessionVO.setNewUrl(newUrl);
		sessionVO.setUri(uri.toLowerCase());
		
		userSession.setAttribute("sessionVO", sessionVO);		
		
		userSession.setAttribute("ipAddress", request.getRemoteAddr());
	}
	/**
	* This method maps the specified key to the specified value in this session.
	* @param key The session key.
	* @param val The value object to be set in the session.
	*/
	public void setAttribute(String key, Object val)
	{		
		userSession.setAttribute(key, val);
	}
	/**
	* This method maps the specified key to the specified value in this session.
	* @param key The object key.
	* @return ObjectThe object from the session for the given key.
	*/
	public Object getAttribute(String key)
	{
		return userSession.getAttribute(key);
	}
	/**
	* This method is used to invalidate the session. Invalidating the session is
	* done only if the method in the controller has permission to invalidate.
	* @throws InvalidURIException Exception thrown if the invalidate
	* permission is denied.
	*/
	public void invalidateSession() throws InvalidURIException
	{
		RequestMap requestMap = RequestMap.getInstance();
		 SessionVO sessionVO = (SessionVO) userSession.getAttribute("sessionVO");
		 String uri = sessionVO.getUri();
		if (requestMap.isSessionInvalidate(uri))
		{
			userSession.invalidate();
		}
		else
		{
			throw new InvalidURIException("Session invalidating " + "permission denied for URI = " + uri);
		}
	}
	/**
	* This method is used to remove a value from the session.
	* @param key The key to be removed
	*/
	public void removeAttribute(String key)
	{
		if (userSession.getAttribute(key) != null)
		{
			userSession.removeAttribute(key);
		}
	}

	/**
	 * This method will return wheither a user is logged in.
	 * @return boolean
	 */
	public boolean isLoggedIn()
	{
		Boolean value = (Boolean) userSession.getAttribute("isLoggedIn");
		if (value == null)
		{
			value = new Boolean(false);
			userSession.setAttribute("isLoggedIn", value);
		}
		return value.booleanValue();
	}
	/**
	 * This method sets wheither a user is logged in.
	 */
	public void setLogin(boolean value)
	{
		userSession.setAttribute("isLoggedIn", new Boolean(value));
	}
	
	public HttpServletRequest getUserRequest()
	{
		return userRequest;
	}
	
	private boolean isValid(String str)
	{
		return str != null ? true : false;
	}
	private boolean isValid(Object obj)
	{
		return obj != null ? true : false;
	}
}
