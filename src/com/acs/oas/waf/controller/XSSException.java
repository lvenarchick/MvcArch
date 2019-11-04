package com.acs.oas.waf.controller;
/**
 * This exception class will be thrown when there is an error in MVC framework.
 */
public class XSSException extends Exception
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
		* Default Constructor. Takes no arguments
		*/
	public XSSException()
	{}
	/**
		* Constructor
		* @param message String containing the exception detail message.
		*/
	public XSSException(String message)
	{
		super(message);
	}

	/**
		* Constructor
		* @param message String containing the exception detail message.
		* @param e Exception.
		*/
	public XSSException(String message, Exception e)
	{
		super(message, e);
	}
}
