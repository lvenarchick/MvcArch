package com.acs.oas.util;


import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

import org.jboss.logging.Logger;

public class DataSecurityViolationDetection
{
	public static final Logger logger = Logger.getLogger("*** " + DataSecurityViolationDetection.class);

	public boolean detect(String value)
	{
		boolean detectedSecurityIssue = false;
		try
		{
			detectedSecurityIssue = detectXSS(value);
			if (detectedSecurityIssue)
			{
				logger.error("Detected XSS Intrusion. "); // inputValue: " + value);
			}
			else
			{
				detectedSecurityIssue = detectHTML(value);
				if (detectedSecurityIssue)
				{
					logger.error("Detected HTML Intrusion. "); // inputValue: " + value);
				}
				else
				{
					detectedSecurityIssue = detectSQL(value);
					if (detectedSecurityIssue)
					{
						logger.error("Detected SQL Intrusion. "); // inputValue: " + value);
					}
				}
			}
		}
		catch (Exception ex)
		{
			logger.error("Exception in value: " + value + ", Exception message: " + ex.getMessage());
			detectedSecurityIssue = true;
		}
		finally
		{
		}

		return detectedSecurityIssue;
	}

	// This method will detect an XSS value in a string
	private boolean detectXSS(String value) throws Exception
	{
		if (value == null || value.equals(""))
			return false;

		String cleanedText = cleanText(value);

		boolean detectedXSS = false;
		String blackList[] = { "onabort=",
				"onafterprint=",
				"animationend\"",
				"animationiteration\"",
				"animationstart\"",
				"onbeforeprint=",
				"onbeforeunload=",
				"onblur=",
				"oncanplay=",
				"oncanplaythrough=",
				"onchange=",
				"onclick=",
				"oncontextmenu=",
				"oncopy=",
				"oncut=",
				"ondblclick=",
				"ondrag=",
				"ondragend=",
				"ondragenter=",
				"ondragleave=",
				"ondragover=",
				"ondragstart=",
				"ondrop=",
				"ondurationchange=",
				"onended=",
				"onerror=",
				"onfocus=",
				"onfocusin=",
				"onfocusout=",
				"onfullscreenchange=",
				"onfullscreenerror=",
				"onhashchange=",
				"oninput=",
				"oninvalid=",
				"onkeydown=",
				"onkeypress=",
				"onkeyup=",
				"onload=",
				"onloadeddata=",
				"onloadedmetadata=",
				"onloadstart=",
				"onmessage=",
				"onmousedown=",
				"onmouseenter=",
				"onmouseleave=",
				"onmousemove=",
				"onmouseover=",
				"onmouseout=",
				"onmouseup=",
				"onoffline=",
				"ononline=",
				"onopen=",
				"onpagehide=",
				"onpageshow=",
				"onpaste=",
				"onpause=",
				"onplay=",
				"onplaying=",
				"onpopstate=",
				"onprogress=",
				"onratechange=",
				"onresize=",
				"onreset=",
				"onscroll=",
				"onsearch=",
				"onseeked=",
				"onseeking=",
				"onselect=",
				"onshow=",
				"onstalled=",
				"confirm\\(",
				"prompt\\(",
				"onstorage=",
				"onsubmit=",
				"onsuspend=",
				"ontimeupdate=",
				"ontoggle=",
				"ontouchcancel=",
				"ontouchend=",
				"ontouchmove=",
				"ontouchstart=",
				"ontransitionend=",
				"onunload=",
				"onvolumechange=",
				"onwaiting=",
				"onwheel=",
				"javascipt",
				"eval\\(",
				"vbscript",
				"alert\\(",
				"accesskey=",
				"document.location",
				"document.close",
				"document.createattribute",
				"document.createcomment",
				"document.createelement",
				"document.createevent",
				"document.getelementbyid",
				"document.getelementsbyname",
				"document.getelementsbytagname",
				"document.open",
				"document.write",
				"document.scripts",
				"document.title" };
		Pattern scriptPattern;
		for (int i = 0; i < blackList.length; i++)
		{
			// logger.debug("Word: " + words[i]);
			scriptPattern = Pattern.compile(blackList[i], Pattern.CASE_INSENSITIVE);
			detectedXSS = scriptPattern.matcher(cleanedText).find();
			if (detectedXSS)
			{
				break;
			}
		}
		return detectedXSS;
	}

	// This method will detect an SQL value in a string
	private boolean detectSQL(String value) throws Exception
	{
		if (value == null || value.equals(""))
			return false;

		value = decodeText(value);
		value = stripNonPrintableText(value);

		boolean detectedSQL = false;
		if (
			value.toUpperCase().contains("DELETE ") || value.toUpperCase().contains("INSERT ") ||
					value.toUpperCase().contains("UPDATE ") || value.toUpperCase().contains("SELECT ")
		)
		{
			detectedSQL = true;
		}

		// untested may not work
		// String sqlPatternString = "\b(ALTER|CREATE|DELETE|DROP|EXEC(UTE){0,1}|INSERT( +INTO){0,1}|MERGE|SELECT|UPDATE|UNION( +ALL){0,1})\b";
		// Pattern sqlPattern = Pattern.compile(sqlPatternString, Pattern.CASE_INSENSITIVE);
		// boolean detectedSQL = sqlPattern.matcher(value).find();
		return detectedSQL;
	}

	// This method will detect an HTML value in a string
	private boolean detectHTML(String value) throws Exception
	{
		if (value == null || value.equals(""))
			return false;

		String cleanedText = cleanText(value);

		String htmlPatternString = "<(\"[^\"]*\"|'[^']*'|[^'\">])*>";
		Pattern htmlPattern = Pattern.compile(htmlPatternString, Pattern.CASE_INSENSITIVE);
		boolean detectedHtml = htmlPattern.matcher(cleanedText).find();
		return detectedHtml;
	}

	// This method will clean up this type of string
	private String cleanText(String text) throws Exception
	{
		if (text == null || text.equals(""))
			return "";

		text = decodeText(text);
		// logger.debug("Decode: " + text + "\n");

		// strip white space
		text = text.replaceAll(" ", "");
		// logger.debug("Strip White Space: " + text + "\n");

		text = stripNonPrintableText(text);
		// logger.debug("strip non-printable: " + text + "\n");

		return text.trim();
	}

	private String stripNonPrintableText(String text) throws Exception
	{
		text = text.replaceAll("\\P{Print}", "");
		return text;
	}

	private String decodeText(String text) throws Exception
	{
		text = URLDecoder.decode(text, StandardCharsets.UTF_8.toString());
		return text;
	}

}