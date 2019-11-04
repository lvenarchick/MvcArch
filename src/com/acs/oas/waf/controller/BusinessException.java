package com.acs.oas.waf.controller;
/**
 * This exception class will be thrown when there is an error in MVC framework.
 */
public class BusinessException extends Exception
{
	/**
		* Default Constructor. Takes no arguments
		*/
	public BusinessException()
	{}
	/**
		* Constructor
		* @param message String containing the exception detail message.
		*/
	public BusinessException(String message)
	{
		super(message);
	}

	/**
		* Constructor
		* @param message String containing the exception detail message.
		* @param e Exception.
		*/
	public BusinessException(String message, Exception e)
	{
		super(message, e);
	}
}
