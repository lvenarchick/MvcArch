
<%@ page import="org.apache.log4j.Logger,java.util.*,java.math.*"%>
<%@ page import="com.acs.oas.util.*,
				 com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo,
				 com.acs.oas.components.dataobject.*, 
				 com.acs.drapi.*,java.util.Calendar"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	
	Logger.getLogger("oasweb").debug("Enter accountSummary.jsp - enter");
   	CustomerInfoVO custInfo =(CustomerInfoVO)session.getAttribute(OASConstants.CUSTOMERINFO_VO);
   	
   	String accNumber = custInfo.getSelectedAccount();
   	//Logger.getLogger("oasweb").debug("Enter accountSummary.jsp - custInfo.getSelectedAccount(): " + accNumber);
   //get DataObject set in session
   	DataObject dataObj = (DataObject)session.getAttribute(OASConstants.DATA_OBJECT);
   	Account account = dataObj.getAccount(accNumber);
   	//Logger.getLogger("oasweb").debug("Enter accountSummary.jsp - accountObj: " + account);
   AccountSummaryVO summaryVO =(AccountSummaryVO) account.get(OASConstants.ACCT_SUMMARY_VO);
   
   AccountDetailsVO accountVO = summaryVO.getAccDetailsVO(); 
   
   List pendingTransList = summaryVO.getPendingTrans();
   
   List recentTransList = summaryVO.getRecentTrans();
   
   
   
   if (accountVO==null){
		throw new Exception("Account Information is not available"); 		
   }
	
   List accList = custInfo.getAccountList();
   
   
   
   	/* SRF 2008 0486 PPP Open Enrollment*/
   	//get pppEligiblity VO for account# and expiration date - required for pre-populating pppEnrollmentPage
   	PPPEligiblityVO pppEligiblityVO =(PPPEligiblityVO)session.getAttribute(OASConstants.PPPELIGIBLE_VO);
	//Logger.getLogger("oas").debug("accountSummary.jsp  pppEligiblityVO: " + pppEligiblityVO );
   	if(pppEligiblityVO != null)
   	{
   		String pppEligibility = pppEligiblityVO.getEligibility().trim();
   		String pppAccountNumber = pppEligiblityVO.getAccountNumber().trim();
   		String pppExpDate	= pppEligiblityVO.getExpireDt().trim();
   		//Logger.getLogger("oas").debug("accountSummary.jsp  pppEligibility: " + pppEligibility + ", pppAccountNumber: " + pppAccountNumber + ", pppExpDate: "+pppExpDate+"]");
   	}
   	
   	/* SRF 2009 0470 Min Pay Due */
   	String minPayVerbiage = ((String)session.getAttribute("minPayVerbiage")).trim();
   	
   	
%>

<html>
<head>
<title>Applied Bank -- Account Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Preview your account information at a glance, recent transaction and transactions since your last statement as well as your Online Statement Summary.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank -- Account Summary">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<script language="JavaScript" src="menu1.js"></script>
<script language="JavaScript" src="navigation.js"></script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript">  
// submit the form to action URL
function submitForm(formAction) {
	var frm = document.accountSummaryForm;
	if(formAction=='gp')
	{
		var w = window.open('about:blank','Popup_Window','height=600,width=600,status=no,toolbar=no,menubar=no,location=no,resizable=yes,scrollbars=yes');
		frm.action = formAction;
		frm.target = 'Popup_Window';
	} else {
		frm.action = 'accountSummary.do';
	}
	frm.submit();
}

function SubmitSearch()
{
	if (document.accountSummaryForm.searchText.value != "")
	{
		window.location.href = "search.do?searchText=" + document.accountSummaryForm.searchText.value;
	}
}

function logoff()
{
	document.getElementById("accountSummaryForm").action="logoff.do";
	document.getElementById("accountSummaryForm").submit();
}

function payNow()
{
	document.getElementById("accountSummaryForm").action="oaspay.do";
	document.getElementById("accountSummaryForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("accountSummaryForm").action="pppEnrollmentInt.do";
	document.getElementById("accountSummaryForm").submit();
}

function doPayOnlineNow()
{
	document.getElementById("accountSummaryForm").action="oaspay.do";
	document.getElementById("accountSummaryForm").submit();
}

function doCustomerService()
{
	document.getElementById("accountSummaryForm").action="customerService.do";
	document.getElementById("accountSummaryForm").submit();
}

</script> 
<script src="AC_OETags.js" language="javascript"></script>
<script language="JavaScript" type="text/javascript">
<!--
// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 6;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 0;
// -----------------------------------------------------------------------------
// -->

function openFlashWin()
{

	var flashWindow;
	var options = "x=0,y=0, width=670, height=510,status=no,resizable=yes";
	
	if (flashWindow!= null) {
	   	flashWindow.close();
	}
	flashWindow = window.open("4stepAuth.jsp","FlashWin", options);
	flashWindow.blur;
	flashWindow.focus();

}
</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form name="accountSummaryForm" id="accountSummaryForm" autocomplete="nope" method="POST" >
<input type="hidden" name="currentAcct" value=''>
<input type="hidden" name="pageGuid" value="${guid}">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header1.jsp" %>
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>
                  <TD width="37%" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60%" valign="top"><h1>Account Summary</h1></td>
                      <td width="40%" valign="top"><div align="right"> <a onClick="logoff();" class="logoff acslink"><strong>Sign Out</strong></a></div></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="2" valign="top"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr>
                     <td valign="top"><div align="left"><span class="warning"><strong><span class="data"><strong>
        
						<c:choose>
							<c:when test="${fn:length(CustomerInfoVO.accountList) == 1}">
								<c:out value="${CustomerInfoVO.accountList[0].formattedAccountNumber}"/>
							</c:when>
							<c:otherwise>
								<select name="AccountList" class="note" onChange="javascript:submitForm()">
									<c:forEach items="${CustomerInfoVO.accountList}" var="account" varStatus="loop">
										<option value="${loop.index}" ${account.accountNumber eq CustomerInfoVO.selectedAccount ? 'selected' : ''} >${account.formattedAccountNumber}</option>
									</c:forEach>
								</select>		
								</strong>
								</span>
								<strong><strong> &nbsp;</strong></strong>(select another AB account)</strong>							
							</c:otherwise>
						</c:choose>
                      </span></div></td>
                      <td valign="top"><div class="excitinghead" align="right">
						  <%@ include file="navigation.jsp" %>
                      </div></td>
                    </tr>
                  </table></TD>
                </TR>
                <TR class="data">
                  <TD height="45" valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
                    <tr class="data">
                      <td height="3" colspan="5"><img src="images/blank.gif" width="1" height="1"></td>
                      </tr>
                    <tr bgcolor="#CCCCCC" class="data">
                      <td height="3" colspan="5"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr class="data">
                      <td height="5" colspan="5"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr class="data">
                      <td colspan="2" valign="top"><h2 align="center">Account at a Glance </h2>
                        <p>&nbsp;</p></td>
                      <td width="1" height="18" rowspan="7" bgcolor="#CCCCCC"><img src="images/blank.gif"></td>
                      <td colspan="2" valign="top"><div align="center">
                        <p><span class="excitingbluebig"><strong>Authorization(s)** </strong></span></p>
                        <p><span class="warning"></span></p>
                      </div></td>
                      </tr>
                    <tr class="data">
                      <td width="141" height="18" valign="top"><strong>Current Balance:*</strong></td>
                      <td width="134" height="18" valign="top">
					    <%
					  		String cbalance =accountVO.getCurrentBalanceAmount();
					  		if (cbalance.startsWith("0") && cbalance.length() >= 5)
					  		{
					  			cbalance = cbalance.substring(1);
					  		}
					    %>
						$<%=cbalance%></td>
                      <td width="132" height="18" valign="top"><div align="center"><strong>Transaction Date </strong></div></td>
                      <td width="136" height="18" valign="top"><div align="center"><strong>Amount*</strong></div></td>
                    </tr>
                    <tr class="data">
                      <td width="141" height="18" valign="top"><strong>Credit Limit:</strong></td>
                      <td width="134" height="18" valign="top">$<%=accountVO.getCreditLimitAmount()%></td>
                      <td height="0" colspan="2" rowspan="5" valign="top"><div id="divScroll" style="position:relative;overflow:auto;width:263;height:92;">                        	
                        <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                           <%int size =pendingTransList.size();
							  String color="#CCCCCC";
							  if(size>0) {	
								String pendingDate=null;	
							      for( int i=0;i< size;i++)
							      {                         			
									Response pendingTransObj = (Response)pendingTransList.get(i);
									
							%>	
							<% 
							String tCode = (String)pendingTransObj.get("transactionCode");
							if (tCode != null && !tCode.equals("FL")){
							%>
							<tr class="data">
							<%
								pendingDate = (String)pendingTransObj.get("authorizationDate");
								if(pendingDate.trim().length()==6)
									pendingDate = FormatUtility.formatDate("yyMMdd",pendingDate);	
							%>							
							 <td width="158" height="18" valign="top"><div align="center"><%= pendingDate %></div></td>
							 <td width="105" height="18" valign="top"><div align="center">$<%=  FormatUtility.formatAmount((String)pendingTransObj.get("authorizationAmount")) %></div></td>
							 </tr>		
							 <% }  
							 	else { 
							 %>
							  <tr class="data">
							  <td height="18" valign="top"><div align="center">No Pending Transactions</div></td>                            
							  </tr>	
							  <% }
							  %>
							<%    }//end for loop
							   }else {
							%>  
							 <tr class="data">
							 <td height="18" valign="top"><div align="center">No Pending Transactions</div></td>                            
							 </tr>	
							 <% } %>  				    
                        </table>
                      </div></td>
                    </tr>
<% 
				//lmv Available Credit Logic 2012 0088
				String extStatus = accountVO.getExternalStatus().trim();
				if(!extStatus.equalsIgnoreCase("C") && !extStatus.equalsIgnoreCase("E"))
				{
%>   
                    <tr class="data">
                      
<%						String avlCredit = ""; 
					  	String cla = "";
					  	String label = "<strong>Available Credit:</strong>&#8224;";
                        String currentBal = accountVO.getCurrentBalanceAmount();
						String creditLimit = accountVO.getCreditLimitAmount();
						
						//Logger.getLogger("oasweb").debug("currentBal:"+currentBal+",creditLimit:"+creditLimit);
						
						double cb = new Double(currentBal).doubleValue();
						double cl = new Double(creditLimit).doubleValue();
						//Logger.getLogger("oasweb").debug("cb:"+cb+",cl:"+cl);
						
						//String extStatus = accountVO.getExternalStatus().trim();
						
						// lmv Available Credit Logic 2012 0088
						if(extStatus.equalsIgnoreCase("A"))
						{
							avlCredit = FormatUtility.formatAmount("00.00");
						}
						else
						{
							int diff =   new Double(cb).compareTo(new Double(cl));
							//Logger.getLogger("oasweb").debug("diff:"+diff);
							if (diff > 0){
								//BigDecimal n1	=	cb.subtract(cl);
								//Integer anInteger = new Integer(diff);
								//String n1 = anInteger.toString();
								 cla ="logoff";
								 BigDecimal n1 = new BigDecimal(cb);
               					 BigDecimal n2 = new BigDecimal(cl);
								 BigDecimal n3= n1.subtract(n2);
								
								//Logger.getLogger("oasweb").debug("n1:"+n1+",n2:"+n2+",n3:"+n3+",toString:"+n3.toString());
								label = "<span class=\"logoff\"><strong>Overlimit Amount:</strong></span>&#8224;";
								avlCredit = FormatUtility.formatAmount(n3.toString());
								
							}else{
								avlCredit = FormatUtility.formatRoundAmount(accountVO.getAvailiableCreditLine());
							}
							//Logger.getLogger("oasweb").debug("avlCredit :"+avlCredit );
						}
%>
                      <td width="141" height="18" valign="top" ><%=label %></td>
                      <td width="134" height="18" valign="top" class="<%=cla%>">
<%
					  		if (avlCredit.startsWith("0") && avlCredit.length() >= 5)
					  		{
					  			avlCredit = avlCredit.substring(1);
					  		}
%>
                      $<%=avlCredit %></td>
                      </tr>
<% 			}%>                      
                    <tr class="data">
                      <td width="141" height="18" valign="top"><strong><%=minPayVerbiage %> </strong></td>
                      <td width="134" height="18" valign="top">
					    <%
					 		// lmv 4/11/13 Ticket#2013041110000063 
					 		String minPayDue = accountVO.getMinimumPaymentDueAmount();
			 		    	Calendar c = Calendar.getInstance();
					    	String cycleCode = accountVO.getBillingCycleCode();
					    	int intCycleCode = Integer.parseInt(cycleCode);
					    	if(c.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY && c.get(Calendar.DATE) == intCycleCode)
					    	{
					    		minPayDue = "Temporarily Unavailable - Refer to Statement";
					    	}
					    	else
					    	{
						  		if (minPayDue.startsWith("0") && minPayDue.length() >= 5)
						  		{
						  			minPayDue = "$" + minPayDue.substring(1);
						  		}
						  		else
						  		{
						  			minPayDue = "$" + minPayDue;
						  		}
						  	}
					    %>
                      <%=minPayDue%></td>
                      </tr>
                    <tr class="data">
                      <td height="18" valign="top"><strong>Payment Due Date: </strong></td>
                      <td height="18" valign="top">
					  <%  String dueDate ="";
					  	  String delDays = accountVO.getDaysOfDelq();
						  Double aDouble = new Double(delDays);
						  int anInteger = 0;

						  if (!aDouble.isNaN())
						  {
								anInteger = aDouble.intValue();
						  }
						  else
						  {
								anInteger =0;
						  }
						  //Logger.getLogger("oasweb").debug("anInteger :"+anInteger);
						 
						  	// lmv 4/11/13 Ticket#2013041110000063 
						  	Calendar c1 = Calendar.getInstance();
					      	String dueDateCycleCode = accountVO.getBillingCycleCode();
					    	int intDueDateCycleCode = Integer.parseInt(dueDateCycleCode);
					    	if(c1.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY && c1.get(Calendar.DATE) == intDueDateCycleCode)
					    	{
					    		dueDate = "Temporarily Unavailable - Refer to Statement";
					    	}
					    	else
					    	{
					    		if (anInteger>0)
					    		{
						  			dueDate = "<span class=\"logoff\">Past Due</span>" + 
						  			"&nbsp;&nbsp;&nbsp;<strong><a onClick=\"payNow();\" class=\"formtextred\" style=\"text-decoration: underline;cursor: pointer;\">Pay Now</a></strong>";
								}
								else
								{
								  	dueDate = accountVO.getPaymentDueDate() + 
								  	"&nbsp;&nbsp;&nbsp;<strong><a onClick=\"payNow();\" class=\"formtextred\" style=\"text-decoration: underline;cursor: pointer;\">Pay Now</a></strong>";
								}
						  	}
					  %>
					  <%=dueDate%>
                      </tr>
                    <tr class="data">
                      <td height="18" valign="top"><strong>Last Payment: </strong></td>
					  <% String amount = accountVO.getLastPaymentAmount();
						 if(new Double(amount).doubleValue()<= 0.00){ %>
							<td height="18" valign="top"></td>
					  <% }else { %>	
							<td height="18" valign="top">$<%=amount%> on <%=accountVO.getLastPaymentDate()%></td>
                      <% } %>
                      </tr>
                     </table></TD>
                  </TR>
                <TR align="left" valign="middle" bgcolor="#D6EFFC">
                  <TD height="5" bgcolor="#FFFFFF" class="exciting"><img src="images/blank.gif" width="1" height="1"></TD>
                </TR>
                <TR align="left" valign="middle" bgcolor="#D6EFFC">
                  <TD height="3" bgcolor="#CCCCCC" class="exciting"><img src="images/blank.gif" width="1" height="1"></TD>
                </TR>
                <TR align="left" valign="middle" bgcolor="#D6EFFC">
                  <TD height="5" bgcolor="#FFFFFF" class="exciting"><img src="images/blank.gif" width="1" height="1"></TD>
                </TR>
                <TR align="left" valign="middle" bgcolor="#D6EFFC">
                  <TD height="25" bgcolor="#FFFFFF" class="exciting"><div align="center" class="excitingbluebig"><strong>Transaction(s) Since Your Last Statement</strong></div></TD>
                </TR>
                <TR align="left" valign="middle" bgcolor="#FFFFFF">
                  <TD class="exciting"><table width="100%"  border="0" cellspacing="1" cellpadding="1">
                    <tr bgcolor="#D6EFFC" class="data">
                      <td height="25" class="data"><div align="center"><strong>Transaction Date </strong></div></td>
                      <td height="25" class="data"><div align="center"><strong>Post Date </strong></div></td>
                      <td><div align="center"><strong>Reference Number </strong></div></td>
                      <td height="25" class="data"><div align="center"><strong>Description of transaction</strong></div></td>
                      <td height="25" class="data"><div align="center"><strong>Amount*</strong></div></td>
                    </tr>

					<% size =recentTransList.size();
                       color="#CCCCCC";
					   if(size>0) {	
                       		for( int i=0;i< size;i++){
                         		color = i%2==0? "#FFFFFF" :"#CCCCCC";
						 		Response recentTransObj = (Response)recentTransList.get(i);
					%>		
                    <tr bgcolor="<%=color %>"class="formtext">
                      <td height="25" class="formtext"><div align="center">
							<%String transDate = (String)recentTransObj.get("transactionDate");
							 	if(transDate.trim().length()==6)
									transDate = FormatUtility.formatDate("yyMMdd",transDate);	
						 	%>
						 	<%= transDate %>
					  </div></td>
                      <td height="25" class="formtext"><div align="center">
							<%  String postDate = (String)recentTransObj.get("postDate");
								if(postDate.trim().length()==6)
									postDate=FormatUtility.formatDate("yyMMdd",postDate);
							%>
							<%= postDate %>
					  </div></td>

                      <td><div align="center"><%=(String)recentTransObj.get("referenceNumber") %></div></td>

                      <td height="25" class="formtext"><div align="center">
							<%=(String) recentTransObj.get("descriptionOfTransaction") %>
					  </div></td>

                      <td height="25" class="formtext"><div align="center">$<%= FormatUtility.formatAmount((String)recentTransObj.get("transactionAmount")) %>
                      </div></td>
                    </tr>
					<%  	}//end for loop
                       	}else {
                   	%>  
					<tr bgcolor="#FFFFFF"class="formtext">
 						<td height="25" class="formtext"><div align="center">No Recent Transactions </div></td>
 					</tr>
					<%  }//end of else  	%> 

                    <tr class="formtext">
                      <td height="10" colspan="5" class="formtext"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
					
					 <tr class="formtext">
                      <td height="20" colspan="5" class="formtext"><div align="center">
                        <table width="100%"  border="0" cellspacing="0" cellpadding="1">
                          <tr>
                            <td width="90%"><div align="center" class="data">
								  <div align="left">I would like to see my Online Statement for billing cycle ending
								  <select  name="monthYear" id="monthYear" class="form">
								  <%
								  		Calendar c2 = Calendar.getInstance();
								  		int intCurrentMonth = c2.get(Calendar.MONTH);
							        	intCurrentMonth += 1;
							        	int intCurrentYear = c2.get(Calendar.YEAR);
							        	for( int i=0;i<6;i++)
							        	{
							        		String month=new Integer(intCurrentMonth).toString();
							        		if(intCurrentMonth<10) month="0"+month;
							        		String year=new Integer(intCurrentYear).toString();
							      %>
							      			<option value="<%=year%>-<%=month%>" ><%=month%>/<%=year%> </option>
							      <%
							      			intCurrentMonth--;
							        		if(intCurrentMonth==0)
							        		{
							        			intCurrentMonth=12;
							        			intCurrentYear--;
							        		}
							        	}
								  %>
								  </select></div></div></td>
									<td width="10%"><a href="javascript:submitForm('gp')" ><img src="images/buttons/go.gif" name="Image39" width="30" height="20" border="0" alt="It may take up to 30 seconds to access your online statement." title="It may take up to 30 seconds to access your online statement."></a></td>                     
                          </tr>
                        </table>
                      </div></td>
                      </tr>
					<tr class="formtext">
                      <td height="20" colspan="5" class="formtext"><p><I><span class="note"><I>*An amount followed by a minus sign (-) is a credit or a credit balance unless otherwise indicated.<br>
                      </I></span></I><I><span class="note">**Authorizations will reduce your available credit and may be different than the transaction amount posted to your account. <br>
                      <span class="style1">&#8224;</span>This amount does not reflect any fees, interest charges, or other charges that may be assessed on the last day of your billing cycle.</span></I></p><BR>
                        </td>
                    </tr>
                    
                    <tr><td colspan="5">
                     <!-- 2008_0584 visa reward, thestreet.com image start -->
                     <!--  
	         		  //HDT 20101013-115400 Remove visa reward, thestreet.com image start
                     <TABLE align=center>
			         	<TR>
			         		<TD>
			         			<img src="images/visa_award.gif" onmouseover="Tip('The Visa Service Quality Performance Awards acknowledge consistent, superior performance and continued service quality improvement in key areas that directly affect Visa cardholders and merchants.',
																			BALLOON,true,WIDTH ,'220',ABOVE, true,OFFSETX,-17)" onmouseout="UnTip()" >
							</TD>	         	
			             	<TD>&nbsp;</TD>
			             	<TD>&nbsp;</TD>
			            	<TD><a href="#" onClick="window.open('https://content.appliedbank.com/acb/streetreport.html','streetreport','toolbar=no,location=no,menubar=no,scrollbars=yes,width=900'); return false;" ><img src="images/street.gif" border="0"></a></TD>
			         	</TR>	 			               	
			         </TABLE>		         
			         //HDT 20101013-115400 Remove visa reward, thestreet.com image end
	         		 -->
          			 <!-- 2008_0584 visa reward, thestreet.com image end -->                      
                    </td></tr>
                    
                  </table>
				  <!-- End main content -->
                    <!-- End footer content -->
					<%@ include file="footer.jsp" %>	
					<!-- End footer content -->
					</TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			<!--
			<table width="190" border="0" cellpadding="0" cellspacing="0">
              <tr bgcolor="CC0000">
                <td height="15" colspan="4" class="ql_header"><div align="center">Welcome&nbsp;<%=FormatUtility.formatName(custInfo.getFirstName())%>  </div></td>
              </tr>
              <tr>
                <td width="1" rowspan="4" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
                <td height="2" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                <td width="1" rowspan="4" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td height="5"><img src="images/blank.gif" width="1" height="5"></td>
              </tr>
              <tr>
                <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="5"><img src="images/blank.gif" width="1" height="1"></td>
                      <td class="formtext">Username: <strong>SuperDave</strong>                        <br>
                        Account: xxxx-xxxx-xxxx-9684                      
                        <BR>
                        Email: <a href="OASupdateEMail.htm" class="formtextred">dave123@bellsouth.net</a><BR>
                        Last signed in on: 01/31/2005<BR>
                        Special Offers: <a href="" class="red">Credit Limit Increase</a></td>
                      </tr>
                    <tr>
                      <td height="5" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
                      </tr>
                  </table>
                 </td>
              </tr>
              <tr>
                <td height="1" colspan="3" bgcolor="#999999"><img src="images/blank.gif"></td>
              </tr>
            </table> -->
			<!-- Start Welcome Content -->
           <%@ include file="welcome.jsp" %>
			<!-- End Welcome Links Content -->
			<!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
            <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="ACCTSUMM" pageLocation="a1"/>   
			<!-- End Dynamic Content -->
			<!-- 2008 0486 PPP Enrollment image start -->
                    <% 
                     if (pppEligiblityVO.getEligibility().trim().equals("eligible"))
                      {
                     %>
	                     <TABLE align=center>
				         	<TR>
				         		<TD>
				         			<table width="100%"  cellspacing="0" cellpadding="0">
               <tr>
                 <td> 						
 						<script language="JavaScript" type="text/javascript">
							<!--
							// Version check based upon the values entered above in "Globals"
							var hasReqestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
							
							if (hasReqestedVersion) 
							{
								document.write('<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
								document.write('  codebase="https://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" ');
								document.write(' id="script" width="200" height="150" align="center">');
								document.write(' <param name="movie" value="images/PPP logo.swf"> <param name="quality" value="high"> '); 
								document.write(' <embed src="images/PPP logo.swf" quality="high"  ');
								document.write(' swLiveConnect="false" width="200" height="150" align="center"');
								document.write(' type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">');
								document.write(' </embed>');
								document.write(' </object>');
							} 
							else
							{
								document.write('<a onClick="submitPPPEnrollment();" onmouseover="Tip(\'<b>Protect Yourself and Your Family!<\/b> With Payment Protection Plus you may have your minimum monthly payments made for you during difficult times such as Disability, Hospitalization, and Unemployment. Click here to learn more.\',	BALLOON, true, WIDTH ,\'220\',   ABOVE, true,  OFFSETX, -17)" onmouseout="UnTip()"> <img src="images/PPP-Logo.gif" border="0"></a>');
							}
							//-->
							</SCRIPT>
						
					
                 </td>
               </tr>
               
           </table>
				         		</TD>	         	
				         	</TR>	         	
				         </TABLE>
			          <%
			           }
			         %>
          		<!-- 2008 0486 PPP Enrollment image end -->
           </td>
          </tr>
        </table></td>
	</tr>
	<tr>
		<td>&nbsp;			</td>
	</tr>
	
</table></center>

</form>
</body>
</html>