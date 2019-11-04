package com.acs.oas.components.util;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.sql.DataSource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.components.servicelocator.web.ServiceLocator;
import com.acs.oas.components.valueobject.CustomerInfoVO;
import com.acs.oas.components.valueobject.OASLoginVO;
import com.acs.oas.components.valueobject.SpecialOffersVO;
import com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo;
import com.acs.oas.db.AcctHistSql;
import com.acs.oas.db.EmailSql;
import com.acs.oas.db.OffersSql;
import com.acs.oas.util.JNDINames;
import com.acs.oas.util.OASSQLQueryConstants;
import com.acs.util.Conversion;






/**
 * @author B0028202
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PopulateOASCustomerData 
{
    
    /**
	* Default Constructor. Takes no arguments
	*/
	public PopulateOASCustomerData()
	{
	}
	
	
	/**
	* This method
	* @param userData User supplied data as a Hashtable
	* @param session User session
	* @return UserResponse Response from user as UserResponse object
	*/
	public CustomerInfoVO populateCustomerVO (OASLoginVO oasLoginVO) 
	{
	    CustomerInfoVO customerInfo =  null;
		
	    try
		{

	        boolean isPropSet 				= false;
	        boolean isSelectedActSet		= false;
	        List accList 					= new ArrayList();
	        
	        customerInfo  =	new CustomerInfoVO ();
	         String ssnFormatted = StringUtils.leftPad(oasLoginVO.getCustSSN().trim().substring(5), 9, "*");
	         
	        try
	        {
	            ServiceLocator serviceLocator = ServiceLocator.getInstance();
	            DataSource datasource = serviceLocator.getDataSource(JNDINames.DEFAULT_DB2DS);
	            
	            try
	            (
	            	Connection con	=  datasource.getConnection();
	            	PreparedStatement ps  = con.prepareStatement(OASSQLQueryConstants.GET_CHPBLIN_ACCOUNT_INFO);
	            )
	            {		           
		            String query = OASSQLQueryConstants.GET_CHPBLIN_ACCOUNT_INFO;
		            

		            Logger.getLogger("oas").debug("query:" + query+",oasLoginVO.getCustSSN():"+ ssnFormatted);
		            
		            ps.setInt(1, Conversion.stringToInt(oasLoginVO.getCustSSN()));
		            
		            try(  ResultSet rs = ps.executeQuery();)
		            {
			            String extStaus=null;
			            while (rs.next())
			            {
			                if (!isPropSet)
			                {
			                    customerInfo.setFirstName(rs.getString("CHPFNM"));
			                    customerInfo.setLastName(rs.getString("CHPLNM"));
			                    customerInfo.setSsn(rs.getInt("CHSSN#"));
			                    //customerInfo.setSelectedAccount(Long.toString(rs.getLong("CHACT#")));
			                    String paddedSSN = String.format("%09d", customerInfo.getSsn());
			                    Logger.getLogger("oas").debug(String.format("customerInfo CUSID: %s, SSNn: %s", oasLoginVO.getCustId(), StringUtils.leftPad(paddedSSN.substring(5), 9, "*")));
			                    isPropSet = true;
			                }  
			                extStaus =rs.getString("CHESTS");
			                if (extStaus.equalsIgnoreCase("B") || extStaus.equalsIgnoreCase("L") || 
			                	extStaus.equalsIgnoreCase("I") || extStaus.equalsIgnoreCase("U") ||
			                	extStaus.equalsIgnoreCase("F") || extStaus.equalsIgnoreCase("Z")){
			                	customerInfo.setHasInvalidAccount(true);
			                	
			                }else{
				                accList.add(customerInfo.new AccountInfo(rs.getString("CHACT#"), rs.getInt("CHDDEQ"), rs.getString("CHISTS").trim(), rs.getString("CHESTS").trim(), rs
				                        .getInt("CHPLA#"), rs.getInt("CHADCD"), rs.getString("CH58SF"), rs.getString("CHCURP"), rs.getString("CHADD1"), rs.getString("CHADD2"), rs
				                        .getString("CHCITY"), rs.getString("CHZIP1"), rs.getString("CHSTAT"), rs.getString("CHHPHN"), rs.getString("CHBPHN"), rs.getString("CHHOLD"), rs.getString("CHRPT1"),rs.getString("CHAUTH")));
				                if(!isSelectedActSet){
				                	customerInfo.setSelectedAccount(Long.toString(rs.getLong("CHACT#")));
				                	isSelectedActSet=true;
				                }
				                
			                }
		
			            }  
		            }
		            customerInfo.setAccountList(accList);
	            
	            }
	        }
	        catch (SQLException sqle)
	        {
	            Logger.getLogger("oas").error("SQLException in PopulateOASCustomerData: "+ ExceptionUtils.getFullStackTrace(sqle));
	        }
	        catch (Exception e)
	        {
	            Logger.getLogger("oas").error("Exception in  PopulateOASCustomerData: "+ ExceptionUtils.getFullStackTrace(e));
	        }
	        finally
	        {

	        }
	        
	        EmailSql dao = new EmailSql();
	        Logger.getLogger("oas").debug("before loginInfo.getUserName() :" + oasLoginVO.getUserName());

	        customerInfo.setUserName(oasLoginVO.getUserName());
	        customerInfo.setPassword(oasLoginVO.getPassword());
	        customerInfo.setCustId(Conversion.stringToInt(oasLoginVO.getCustId()));

	        //	  email
	        String primaryEmail = "";
	        primaryEmail = dao.getPrimaryEmail(Conversion.stringToInt(oasLoginVO.getCustSSN()));
			if (primaryEmail.isEmpty()) {
				Logger.getLogger("oas").warn("WARNING - No Email designated as Primary.");
				Object[][] allEmails = dao.getAllEmails(Conversion.stringToInt(oasLoginVO.getCustSSN()));
				if (allEmails.length > 0) {
					if (!((String)allEmails[0][0]).isEmpty()) {
						primaryEmail = (String)allEmails[0][0];
					} else if (!((String)allEmails[1][0]).isEmpty()) {
						primaryEmail = (String)allEmails[1][0];
					} else if (!((String)allEmails[2][0]).isEmpty()) {
						primaryEmail = (String)allEmails[2][0];
					}
				} else {
					Logger.getLogger("oas").warn("WARNING - No Emails available for this account.");
				}
			}

	        customerInfo.setPrimaryEmail(primaryEmail);

	        AcctHistSql dao2 = new AcctHistSql();
	        String lastLogin = dao2.getLastLogin(customerInfo.getSsn());
	        customerInfo.setLastVisit(lastLogin);

	        //get offers
	        OffersSql dao3 = new OffersSql();
	        List acccountList = customerInfo.getAccountList();
	        List <SpecialOffersVO> accountOffers = new ArrayList<SpecialOffersVO>();
	        
	        for (int i = 0; i < acccountList.size(); i++)
	        {
	            AccountInfo acctInfo = (AccountInfo) acccountList.get(i);
	            SpecialOffersVO offers = new SpecialOffersVO();
	            // Special Offers
	            Vector offerInfo = dao3.cliOfferExists(acctInfo.getAccountNumber());

	            if (offerInfo.size() > 0)
	            {
	            	String offerDesc = (String) offerInfo.get(0);
	            	String offerDescCode = (String) offerInfo.get(1);
	            	offerDescCode = offerDescCode.trim();
	            	Logger.getLogger("oas").debug("LoginActionHelper in VO :" + offerDesc + " Code: " + offerDescCode);
	   
		            // A= Credit Line Increase + Upgrade
		            // C= Credit Line Increase
		            // U= Upgrade My Account
		            if ( (offerDescCode.equals("A"))  || (offerDescCode.equals("C")) || (offerDescCode.equals("U")) )
		            {
		            	offers.setAccountNumber(acctInfo.getAccountNumber());
		            	offers.setOfferDesc(offerDesc);
		            	offers.setOfferCode(offerDescCode);
		            	
		            	accountOffers.add(offers);
		            	
		            	customerInfo.setOffers(true);
		                customerInfo.setOfferDescCode(offerDescCode);
		                customerInfo.setOfferDesc(offerDesc);
		                //break;
		            }
	        	}
	            customerInfo.setAccountOffers(accountOffers);
	    
	        }
	        Logger.getLogger("oas").debug("customerInfo.isOffers() in VO :" + customerInfo.isOffers());
	        Logger.getLogger("oas").debug("in populate customerInfo.getAccountList():" + customerInfo.getAccountList().size());
	        
	        customerInfo.setPicturepassImagename(oasLoginVO.getPicturepassImagename());
	        customerInfo.setPicturePhrase(oasLoginVO.getPicturePhrase());
		}
		catch (Exception ex)
		{
			Logger.getLogger("oas").error("Exception in PopulateOASCustomerData/populateCustomerVO: "+ ExceptionUtils.getFullStackTrace(ex));
			
		}
		finally
		{
			//Logger.getLogger(lname).debug("Exit PopulateOASCustomerData/populateCustomerVO.");
		}
		return customerInfo;
	}
	
	
	
}
