package com.acs.oas.waf.controller;
// Java Utility classes
import java.util.Enumeration;
import java.util.Hashtable;
/**
 * This class is used to return values from the controller classes
 * to the servlet controller, which then reads from this object
 * and puts the  values in the HTTPRequest.
 */
public class UserResponse extends Hashtable
{
	/**
		* Default Constructor. Takes no arguments
		*/
	public UserResponse()
	{}
	/**
		* Returns object from the hashtable for the given key.
		* @param key The value in the hashtable.
		* @return Object Response for the given key.
		*/
	public Object getResponse(String key)
	{
		return get(key);
	}
	/**
		* Sets the key value pair in the hashtable.
		* @param  key  The key in the hashtable.
		* @return ObjectValue to be set for the given key.
		*/
	public void setResponse(String key, Object value)
	{
		put(key, value);
	}
	/**
		* Returns an int value representing the number of objects in the response.
		* @return int The size of the response object.
		*/
	public int getResponseSize()
	{
		return size();
	}
	/**
		* Returns an Enumeration value representing the keys in the response.
		* @return Enumeration Parameter Names in the response object.
		*/
	public Enumeration getResponseKeys()
	{
		return keys();
	}
	/**
		* Returns an Enumeration value representing the key values in the response.
		* @return Enumeration Parameter Values in the response object.
		*/
	public Enumeration getResponseValues()
	{
		return elements();
	}
}
