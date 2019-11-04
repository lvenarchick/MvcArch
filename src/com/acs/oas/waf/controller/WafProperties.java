package com.acs.oas.waf.controller;
import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.util.Properties;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;
/**
 * Web Architecture Framework properties
 */
public class WafProperties implements Serializable
{
	private static final long serialVersionUID = 1L;
	private Properties p = new Properties();
	private String propFile = "./waf.properties";
	
	public WafProperties()
	{
		InputStream stream = null;
		try
		{
			stream = this.getClass().getClassLoader().getResourceAsStream(propFile);
			p.load(stream);
			stream.close();		    
		}
		catch (Exception e)
		{
			Logger.getLogger("waf").error("Exception in WafProperties: "+ ExceptionUtils.getFullStackTrace(e));
		}
		finally
        {
            try
            {
                if(stream != null) 
                	stream.close();
            }
            catch (IOException ie)
            {
            	Logger.getLogger("waf").error("IOException in WafProperties: "+ ExceptionUtils.getFullStackTrace(ie));
            }
        }    
	}
	
	/**
	 * Gets a value from the properties file
	 * @param propName property name
	 * @return String property value
	 */
	public String getProperty(String propName)
	{
		return p.getProperty(propName);
	}
}
