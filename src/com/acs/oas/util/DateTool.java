package com.acs.oas.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;


public class DateTool {
	public static SimpleDateFormat dateFormat = new SimpleDateFormat();
	//public static SimpleDateFormat dateTimeFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
	public static Date returnDate = null;
	public static SimpleDateFormat dateTimeFormat = new SimpleDateFormat("MM/dd/yyyy");


	  /**
	  * Adds the No. of days to the given date and returns the Date.
	  * @param inDate Date
	  * @param int daysToAdd
	  * @return Date
	  */
	  public static Date addDays(Date inDate,int daysToAdd){
	        long dateMillisecs = inDate.getTime();
	        long daysMillisecs = daysToAdd*24*60*60*1000;
	        long addedMillisecs = dateMillisecs+daysMillisecs;
	        
	        return new Date(addedMillisecs);
	  }
	/**
		  * Adds the No. of days to current and returns the Date.
		  * @param inDate Date
		  * @param int daysToAdd
		  * @return Date
		  */
		  public static Date addDays(int daysToAdd){
				Date startDate = new Date();
				long dateMillisecs = startDate.getTime();
				long daysMillisecs = daysToAdd*24*60*60*1000;
				long addedMillisecs = dateMillisecs+daysMillisecs;
	        
				return new Date(addedMillisecs);
		  }
	/**
	* return the Date for a String Date default representation MM/dd/yyyy
	* returns null if the the string representation is not in valid date format.
	* @param  inSDate String
	* @return Date
	*/
	public static Date getDate(String inSDate){
		if (inSDate == null)
			return null;

	    dateFormat.applyLocalizedPattern("MM/dd/yyyy");
		try{
			returnDate = dateFormat.parse(inSDate);
		}catch(java.text.ParseException ex){
			returnDate = null;    
		}
		return returnDate;
	}
	/**
	* return the Date for a String Date representation with the Format specified by format.
	* returns null if the the string representation is not in valid date format.
	* @param  inSDate String
	* @param  format String
	* @return Date
	*/
	public static Date getDate(String inSDate,String format){
	    
	    dateFormat.applyLocalizedPattern(format);
		try{
			returnDate = dateFormat.parse(inSDate);
		}catch(java.text.ParseException ex){
			returnDate = null;    
		}
		return returnDate;
	}
	/**
	* Combines date and time 
	* return the Date for a String Date representation with the Format specified by format.
	* returns null if the the string representation is not in valid date format.
	* @param Date
	* @param String time
	* @return Date
	*/
	public static Date getDate(Date inDate,String inSTime){
		try {
			dateFormat.applyLocalizedPattern("MM/dd/yyyy");
			returnDate = dateTimeFormat.parse(dateFormat.format(inDate)+" "+inSTime);
		} catch (Exception ex)
		{
			returnDate = null;
		}

		return returnDate;
	}
	/**
	* return the default MM/dd/yyyy dateformat.
	* @param Date
	* @return String formatted date 
	*/
	public static String getDateFormat(Date inDate){
		if (inDate == null) return "";
	    dateFormat.applyLocalizedPattern("MM/dd/yyyy");
		return dateFormat.format(inDate);
	}
	/**
	* to strip of the time portion and return the date
	* @param Date inDate
	* @return String time
	*/
	public static Date getDateNoTime(Date inDate){
		if (inDate == null) return null;
	    dateFormat.applyLocalizedPattern("MM/dd/yyyy");
		return getDate(dateFormat.format(inDate));
	}
	
	/**
	* return Date with Specified Format.
	* @param inDate Date 
	* @param format String 
	* @return String date
	*/
	public static String getDateFormat(Date inDate,String format){
	    if (inDate == null) return "";
		if(dateFormat == null)
			return inDate.toString();
		else
		{
			dateFormat.applyLocalizedPattern(format);
			return dateFormat.format(inDate);
		}
	}
	/**
	* Returns the day of the week
	* @param inDate Date 
	* @return String day
	*/
	public static String getDay(Date inDate)
	{
		if(inDate != null){
		    dateFormat.applyLocalizedPattern("EEEEE");//E for breif -: Thu
		    return dateFormat.format(inDate);
		}
		return "";
	}
	/**
	*  Returns the day of the month
	* @param Date
	* @return int - the day of the month
	*/
	public static int getDayNum(Date inDate)
	{
		if(inDate != null){
		   	dateFormat.applyLocalizedPattern("dd");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
	* returns day of week in month- 2nd thursday of month  == 2    
	* @param inDate Date
	* @return int day of the week
	*/
	public static int getDayOfWeek(Date inDate)
	{
		if(inDate != null){
		   	dateFormat.applyLocalizedPattern("F");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
	* returns week in month               
	* @param inDate Date
	* @return int day of the week
	*/
	public static int getWeekInMonth(Date inDate)
	{
		if(inDate != null){
		   	dateFormat.applyLocalizedPattern("W");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
	* returns day of year    
	* @param inDate Date
	* @return int day of tyear
	*/
	public static int getDayOfYear(Date inDate)
	{
		if(inDate != null){
		   	dateFormat.applyLocalizedPattern("D");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
	* returns week in year            
	* @param inDate Date
	* @return int day of tyear
	*/
	public static int getWeekInYear(Date inDate)
	{
		if(inDate != null){
		   	dateFormat.applyLocalizedPattern("w");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
	*  getDaysBetween returns no of days between two Dates.
	*  It always returns positive value.
	* @param inFirstDate Date
	* @param inSecondDate Date 
	* @return long 
	*/
	public static long getDaysBetween(Date inFirstDate,Date inSecondDate)
	{
			long numberOfMilliSecs;
		
			if (inFirstDate == null || inSecondDate == null)
			    return 0L;
			/* Check to see which of the two Date arguments is greater */
			if (inSecondDate.after(inFirstDate))
				numberOfMilliSecs = inSecondDate.getTime() - inFirstDate.getTime();
			else
				numberOfMilliSecs = inFirstDate.getTime() - inSecondDate.getTime();
				
			/* Convert the MilliSeconds to days and return*/
			return (numberOfMilliSecs/86400000);
			
	  }
	/**
	* Returns the month for a Date
	* @param Date
	* @return int month
	*/
	public static int getMonth(Date inDate)
	{
		if(inDate != null){
		    dateFormat.applyLocalizedPattern("MM");
			return Integer.parseInt(dateFormat.format(inDate));
		}
		return 0;
	}
	/**
		* Returns the month for a Date
		* @param Date
		* @return int month
		*/
		public static int getYear(Date inDate)
		{
			if(inDate != null){
				dateFormat.applyLocalizedPattern("yy");
				return Integer.parseInt(dateFormat.format(inDate));
			}
			return 0;
		}
	/**
	* returns the current time in a formatted string HH:mm:ss:SSS
	* @return String time
	*/
	public static String getCurrentTimeString() 
	{
		return	getDateFormat(new java.util.Date(),"HH:mm:ss:SSS");
	}
	/**
	* returns the current time in a formatted string HH:mm:ss:SSS
	* @return String time
	*/
	public static String getCurrentDateTimeString() 
	{
		return	getDateFormat(new java.util.Date(),"MM/dd/yyyy HH:mm:ss:SSS");
	}
	/**
	* returns the current date in a formatted string YYYYMMDD
	* @return String date
	*/
	public static String getCurrentDateString() 
	{
		return	getDateFormat(new java.util.Date(),"yyyyMMdd");
	}
	/**
	* returns the datetime in the specified format
	* @param format String
	* @return String formatted date string
	*/
	public static String getCurrentTimeString(String format) 
	{
		return	getDateFormat(new java.util.Date(),format);
	}
	/**
	* returns the datetime in a formatted string HH:mm:ss:SSS
	* @param dt Date
	* @return String time HH:mm:ss:SSS
	*/
	public static String getTimeString(Date dt) 
	{
		return	getDateFormat(dt,"HH:mm:ss:SSS");
	}
	/**
	* returns the datetime in a formatted string MM/dd/yyyy HH:mm:ss:SSS
	* @param Date
	* @return String formatted date MM/dd/yyyy HH:mm:ss:SSS
	*/
	public static String getDateTimeString(Date dt) 
	{
		return	getDateFormat(dt,"MM/dd/yyyy HH:mm:ss:SSS");
	}
	
	/**
	* returns the datetime bsed on Date and Time
	* @param Date
	* @param java.sql.Time
	* @return Date
	*/
	public static Date getDateTime(Date dt, java.sql.Time time) 
	{
		java.util.Date sysDateTime = null;

		SimpleDateFormat sdft = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		try 
		{
		sysDateTime = sdft.parse(sdf.format(dt)+" "+time);
		} catch (Exception e)
		{
		}
		
		return	sysDateTime;
	}
	
	/**
	* returns the datetime in the specified format
	* @param dt Date
	* @param format String
	* @return String formatted date string
	*/
	public static String getDateTimeString(Date dt,String format) 
	{
		return	getDateFormat(dt,format);
	}
	/**
	*  It always returns positive value.
	* @param Date inDate
	* @return float time
	*/
	public static float getTime(Date inDate)
	{
		if(inDate == null)
			return 0L;
			
		long numberOfMilliSecs;
		float time;

		returnDate = getDate(getDateFormat(inDate));
		numberOfMilliSecs = inDate.getTime() - returnDate.getTime();

		time = numberOfMilliSecs/3600000;
		return time;
	}
	
	public static String getDefaultFormatDate (String rawDate){
		String returnDate="";
		
		returnDate=rawDate.subSequence(4,6)+"/"+rawDate.subSequence(6,8)+"/"+rawDate.subSequence(0,4);
				
		return returnDate;
		
		
	}
	public static String convertDate(String appmainDob)
	{
		String newDate = new String();
		try
		{
			/* If the APPMAIN Date of Birth is 1011960 */
			if (appmainDob.length() < 8)
				appmainDob = "0" + appmainDob;
			
			SimpleDateFormat sdf = new SimpleDateFormat("MMddyyyy");

			/* Creating a Date object */
			Date d = sdf.parse(appmainDob);

			/* The new format yyyy-MM-dd */
			String pattern = "yyyy-MM-dd";

			/* Creating a new pattern */
			sdf = new SimpleDateFormat(pattern);

			newDate = sdf.format(d);
			Logger.getLogger("oas").debug("APPMAIN DOB :"+newDate);
		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").debug("Exception in convertDate :"+ex);
		}

		return newDate;
	}
	
	public  static String convertJulianDate (String input) {
        Calendar cal = Calendar.getInstance();
       cal.set(Calendar.YEAR, Integer.parseInt(input.substring(0, 4)));
        cal.set(Calendar.DAY_OF_YEAR, Integer.parseInt(input.substring(4)));
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
            return sdf.format(cal.getTime());
   }
	public static void main(String[] args) 	{
		//String res= getCurrentTimeString("HHmmssSSSMMddyyyy");//1242pm08302002
		int yr = getYear(new Date());

		//String res1 = DateTool.getDay(dt);

	
	}
}