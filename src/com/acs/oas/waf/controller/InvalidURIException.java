package com.acs.oas.waf.controller;
/**
 * This class represents the Exception, which is thrown whenever there is an
 * improper entry in the properties file.
 */
public class InvalidURIException extends Exception
{
	private String message;
	/**
		* Default constructor. Takes no argument. Gets the exception message
		* from the super class.
		*/
	public InvalidURIException()
	{
		message = super.getMessage();
	}
	/**
		* Constructor takes exception message as the parameter and
		* builds the exception object.
		* @param message String represents the exception message
		*/
	public InvalidURIException(String message)
	{
		super(message);
		this.message = message;
	}
	/**
		* Overidden toString method to print the proper exception message.
		* @return String The exception message
		*/
	public String toString()
	{
		return message;
	}
}
