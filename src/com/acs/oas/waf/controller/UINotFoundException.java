package com.acs.oas.waf.controller;
/**
 * This class represents the Exception, which is thrown if there
 * is no role/id entry in the uiaccesscontrollers.properties file
 */
public class UINotFoundException extends RuntimeException
{
	private String message;
	private Exception e;
	/**
		* Default constructor. Takes no argument. Gets the exception
		* message from the super class.
		*/
	public UINotFoundException()
	{
		message = super.getMessage();
	}
	/**
		* Overidden toString method to print the proper exception message.
		* @return String The exception message
		*/
	public String toString()
	{
		return message;
	}
	/**
		* Constructor takes exception message as the parameter and
		* builds the exception object.
		* @param message String represents the exception message
		*/
	public UINotFoundException(String message)
	{
		super(message);
		this.message = message;
	}
	/**
		* Constructor takes exception message as the parameter and
		* builds the exception object.
		* @param message String represents the exception message
		*/
	public UINotFoundException(String message, Exception e)
	{
		super(message, e);
		this.message = message;
		this.e = e;
	}
}
