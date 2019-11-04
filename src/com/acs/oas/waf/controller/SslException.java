package com.acs.oas.waf.controller;
/**
 * This exception class will be thrown when there is an error in MVC framework.
 */
public class SslException extends Exception
{
	/**
		* Default Constructor. Takes no arguments
		*/
	public SslException()
	{}
	/**
		* Constructor
		* @param message String containing the exception detail message.
		*/
	public SslException(String message)
	{
		super(message);
	}

	/**
		* Constructor
		* @param message String containing the exception detail message.
		* @param e Exception.
		*/
	public SslException(String message, Exception e)
	{
		super(message, e);
	}
}
