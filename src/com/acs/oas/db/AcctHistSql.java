package com.acs.oas.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.components.servicelocator.web.ServiceLocator;
import com.acs.oas.util.JNDINames;
import com.acs.oas.util.OASProperties;
import com.acs.util.Common;

/**
 * @author B0028202 TODO To change the template for this generated type comment
 *         go to Window - Preferences - Java - Code Style - Code Templates
 */
public class AcctHistSql
{
    private OASProperties oasProperties = new OASProperties();

    private String LIB = oasProperties.getProperty("server.library.name");

    private String[] columnNamesFromLastQuery = new String[0];

    /** Creates a new instance of AcctHistSql */
    public AcctHistSql()
    {
    }

    public Object[][] getAcctHistInfo(long ssn)
    {

        String getPayHistSql = "Select date(a.ACTDATE), b.CODDESC from " + a, " + LIB
                + ".chpwebcdd b where   a.ACTCODEI=b.codid  and b.codtype in('AH','PAYSGL','PAYMTL','PAYMOD','PAYCAN') and a.ACTSSN=? order by a.ACTDATE desc";

        //Connection con = null;
        //PreparedStatement ps = null;
        //ResultSet rs = null;
        
        Object[][] resultsArray = new Object[0][0];
        ArrayList resultList = new ArrayList();
        try
        {
            ServiceLocator serviceLocator = ServiceLocator.getInstance();
            DataSource ds = serviceLocator.getDataSource(JNDINames.DEFAULT_DB2DS);
            try
            ( 
            	Connection con = ds.getConnection();
            	PreparedStatement ps = con.prepareStatement(getPayHistSql);
            )
            {

            	ps.setLong(1, ssn);

	            try( ResultSet rs =ps.executeQuery();)
	            {
		            ResultSetMetaData rsmd = rs.getMetaData();
		            int columnCount = rsmd.getColumnCount();
		            this.columnNamesFromLastQuery = new String[columnCount];
		            for (int i = 0; i < columnCount; ++i)
		            {
		                columnNamesFromLastQuery[i] = rsmd.getColumnName(i + 1);
		            }
		            while (rs.next())
		            {
		                Object[] temp = new Object[columnCount];
		                for (int i = 1; i <= columnCount; ++i)
		                {
		                    temp[i - 1] = rs.getObject(i);
		                }
		                resultList.add(temp);
		            }
		            resultsArray = new Object[resultList.size()][];
		            for (int i = 0; i < resultList.size(); ++i)
		            {
		                resultsArray[i] = (Object[]) resultList.get(i);
		            }
	            }
            }

        }
        catch (SQLException sqle)
        {
            Logger.getLogger("oas").error("getPayHistInfo SQL Exception: "+ ExceptionUtils.getFullStackTrace(sqle));
        }
        catch (Exception e)
        {
            Logger.getLogger("oas").error("getPayHistInfo SQL Exception: "+ ExceptionUtils.getFullStackTrace(e));
        }
        finally
        {

        }
        return resultsArray;
    }

    public void insertNewLog(String logType, String acct, long ssn, String ip, String notes)
    {

        String values = " ? , ?, ? ,?, ?, ?, ?";
        String tableName = "";
        String columnList = " ACTLOGID, ACTDATE, ACTIP, ACTCODEI, ACTSSN, ACTACT, ACTNOTES ";
        String newUserInsertQuery = "Insert into " + tableName + "(" + columnList + ")" + "  Values (" + values + ")";
        Logger.getLogger("oas").debug("insertNewUser nmtriInsertQuery :" + newUserInsertQuery);
        if (acct == null)
        {
        	Logger.getLogger("oas").debug("insertNewUser nmtriInsertQuery : null error" + newUserInsertQuery);
            
        }
        //Connection con = null;
        //PreparedStatement ps = null;
        

        try
        {
        	
            ServiceLocator serviceLocator = ServiceLocator.getInstance();
            DataSource ds = serviceLocator.getDataSource(JNDINames.DEFAULT_DB2DS);
            
            try
            ( 
            	Connection con = ds.getConnection();
            	PreparedStatement ps = con.prepareStatement(newUserInsertQuery);
            )
            {
	            ps.setString(1, Common.getAGuid());
	            java.sql.Date now = new java.sql.Date(new java.util.Date().getTime());
	            ps.setDate(2, now);
	            ps.setString(3, ip);
	            ps.setString(4, logType);
	            ps.setLong(5, ssn);
	            ps.setString(6, acct);
	            ps.setString(7, notes);
	
	            int count = ps.executeUpdate();
	            if (count < 0)
	            {
	                Logger.getLogger("oas").error("insertNewLog Exception:could not insert into CHPWEBLOG table");
	            }

            }

        }
        catch (SQLException sqle)
        {
            Logger.getLogger("oas").error("insertNewLog Exception: "+ ExceptionUtils.getFullStackTrace(sqle));
        }
        catch (Exception e)
        {
            Logger.getLogger("oas").error("insertNewLog Exception: "+ ExceptionUtils.getFullStackTrace(e));
        }
        finally
        {

        }
    }

    /** Check if the specified NonMon Transaction already exists in the database. */
    public String getLastLogin(long ssn)
    {

        String lastLogin = "";
        //String lookUpQuery = "Select date(MAX(ACTDATE)) from " + LIB + ".chpweblog where ACTCODEI=1 and ACTSSN=? ";
        String lookUpQuery = "Select date(MAX(LOGIN_TIME)) from  where OAS_CUSTOMER_SSN = ?";
        try
        {
            ServiceLocator serviceLocator = ServiceLocator.getInstance();
            DataSource ds = serviceLocator.getDataSource(JNDINames.DEFAULT_DB2DS);
            
            try
            ( 
            	Connection con = ds.getConnection();
            	PreparedStatement ps = con.prepareStatement(lookUpQuery);
            )
            {

            	ps.setLong(1, ssn);
            	
            	try( ResultSet rs = ps.executeQuery();)
            	{
		            while (rs.next())
		            {
		                lastLogin = rs.getString(1);
		            }
            	}
            }

        }
        catch (SQLException sqle)
        {
            Logger.getLogger("oas").error("getLastLogin SQL Exception: "+ ExceptionUtils.getFullStackTrace(sqle));
        }
        catch (Exception e)
        {
            Logger.getLogger("oas").error("getLastLogin Exception: "+ ExceptionUtils.getFullStackTrace(e));
        }
        finally
        {

        }
        //Logger.getLogger("oas").debug("lastLogin:" + lastLogin);
        return lastLogin;
    }


}
