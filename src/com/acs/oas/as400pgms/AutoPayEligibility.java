package com.acs.oas.as400pgms;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.util.OASConstants;
import com.acs.oas.waf.controller.BaseAction;
import com.acs.oas.waf.controller.RouterServlet;
import com.ibm.as400.access.AS400;
import com.ibm.as400.access.AS400Message;
import com.ibm.as400.access.AS400Text;
import com.ibm.as400.access.ProgramCall;
import com.ibm.as400.access.ProgramParameter;
import com.ibm.as400.access.QSYSObjectPathName;
import com.ibm.as400.access.SecureAS400;

public class AutoPayEligibility extends BaseAction{
/*
 * Calls AS400 FDE762
 * Input Parameter: Account Number
 * Output: Flag(X = Error, N = Not eligible, Y = Eligible, E = Already Enrolled)
 */
	public String checkAutoPayEligibility(String acctNo)
	{
		String eligibilityFlag = null;
		AS400 system400 = null;

		try
		{
	
			system400.connectService(AS400.COMMAND);
			String pgmName = QSYSObjectPathName.toPath();
			ProgramCall pgmObj = new ProgramCall(system400);
			ProgramParameter[] params = new ProgramParameter[2];
	
			// input parameters
			AS400Text account = new AS400Text(16, system400);
			params[0] = new ProgramParameter(account.toBytes(acctNo));
			
			// output parameter: Eligibility Flag
			AS400Text flag = new AS400Text(1, system400);
			params[1] = new ProgramParameter(1);
			
			boolean pgmOk = pgmObj.run(pgmName, params);
			AS400Message msgs[] = pgmObj.getMessageList();
			//Logger.getLogger(lname).debug("AutoPayEligibility.checkAutoPayEligibility point 1.");
			if (!pgmOk)
			{
				//Logger.getLogger(lname).debug("AutoPayEligibility.checkAutoPayEligibility point 2.");
				for (AS400Message msg: msgs)
				{
					Logger.getLogger(lname).debug("AutoPayEligibility.checkAutoPayEligibility.Message" + msg.getText());
				}
			}
			else
			{
				//Logger.getLogger(lname).debug("AutoPayEligibility.checkAutoPayEligibility point 3.");
				eligibilityFlag = (String) flag.toObject(params[1].getOutputData());
				//Logger.getLogger(lname).debug("AutoPayEligibility.checkAutoPayEligibility Flag: " + eligibilityFlag);
			}			
			system400.disconnectAllServices();
		}
		catch(Exception ex)
		{
			Logger.getLogger(lname).error("AutoPayEligibility.checkAutoPayEligibility Error calling : "+ ExceptionUtils.getFullStackTrace(ex));
			
		}
		finally
		{
			if (system400 != null) {
				system400.disconnectAllServices();
	     	}
		}		
		return eligibilityFlag;
	}
}
