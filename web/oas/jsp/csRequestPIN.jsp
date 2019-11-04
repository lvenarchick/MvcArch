<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@ page import="java.util.Collection, java.util.List"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>		
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>		 
<%
	//Logger.getLogger("oasweb").debug("Enter csRequestPIN.jsp");


    
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");

	CustomerInfoVO custInfo = (CustomerInfoVO) session.getAttribute(OASConstants.CUSTOMERINFO_VO);
    String accNumber = custInfo.getSelectedAccount();
   	List accList = custInfo.getAccountList();
   	
   	/* SRF 2008 0486 PPP Open Enrollment*/
   	//get pppEligiblity VO for account# and expiration date - required for pre-populating pppEnrollmentPage
   	PPPEligiblityVO pppEligiblityVO =(PPPEligiblityVO)session.getAttribute(OASConstants.PPPELIGIBLE_VO);
   	if(pppEligiblityVO != null)
   	{
   		String pppEligibility = pppEligiblityVO.getEligibility().trim();
   		String pppAccountNumber = pppEligiblityVO.getAccountNumber().trim();
   		String pppExpDate	= pppEligiblityVO.getExpireDt().trim();
   		//Logger.getLogger("oas").debug("accountSummary.jsp::["+pppEligibility+"],["+pppAccountNumber+"],["+pppExpDate+"]");
   	}
%>
<html>
<head>
<title>Applied Bank - Request PIN </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Your Personal Identification Number (PIN) allows you to access funds at over 800,000 ATM's Nationwide. A new randomly generated PIN will be sent to your billing address on file. This will replace any existing PIN you may have.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank - Request PIN">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<script language="JavaScript" src="menu1.js"></script>
<script language="JavaScript" src="navigation.js"></script>
<script language="JavaScript">
function SubmitSearch()
{
	if (document.forms[1].searchText.value != "")
	{
		window.location.href = "search.do?searchText=" + document.forms[1].searchText.value;
	}
}
function confirmMessage(){
	var agree	= confirm("You are requesting a new randomly generated PIN be sent to your billing address. Please click OK to continue.");
		if (agree)
			return true ;
		else
			return false ;

}

function requestPIN(){
		var agree	= confirm("You are requesting a new randomly generated PIN be sent to your billing address. Please click OK to continue.");
		if (agree){
			this.document.forms[0].method = 'post';
 			this.document.forms[0].action = 'csRequest.do?type=pin';
  			this.document.forms[0].submit();
			
	} 
		

}

function logoff()
{
	document.getElementById("requestPinForm").action="logoff.do";
	document.getElementById("requestPinForm").submit();
}

function accountSummary()
{
	document.getElementById("requestPinForm").action="accountSummary.do";
	document.getElementById("requestPinForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("requestPinForm").action="pppEnrollmentInt.do";
	document.getElementById("requestPinForm").submit();
}	

function doPayOnlineNow()
{
	document.getElementById("requestPinForm").action="oaspay.do";
	document.getElementById("requestPinForm").submit();
}

function doCustomerService()
{
	document.getElementById("requestPinForm").action="customerService.do";
	document.getElementById("requestPinForm").submit();
}
</script>
<link href="css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form name="requestPinForm" id="requestPinForm" autocomplete="nope" method="post">
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
                      <td width="60%" valign="top"><h1>Request a PIN <br> (Personal Identification Number) <span class="data"><strong> </strong></span></h1></td>
                      <td width="40%" valign="top"><div align="right"> <a onClick="logoff();" class="logoff acslink"><strong>Sign Out</strong></a> </div></td>
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
								<select name="AccountList" class="note" onChange="accountSummary();">
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
                <TR>
                  <TD height="5" valign="top"><img src="images/blank.gif" width="1" height="1"></TD>
                  </TR>
                <tr>
                  <td height="3" valign="top" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                </tr>
                <tr>
                  <td height="10" valign="top"><img src="images/blank.gif" width="1" height="1"></td>
                </tr>
                <tr>
                  <td height="20" valign="top">
                    <p align="left"><p align="left">Your Personal Identification Number (PIN) allows you to access funds* at over 800,000 ATM's Nationwide. </p><br>
                    <p align="left"><a href="javascript:requestPIN()" class="formtextred" ><strong>Click here</strong></a> for a new <strong>randomly generated PIN</strong> that will be sent to your billing address on file. This will replace any existing PIN you may have active on your account. <em><strong>Please allow 7-10 business days for arrival. </strong></em></p>
                    <p align="left">&nbsp;</p>
                    <p align="center"><span class="note"><strong>*</strong>When accessing funds from your account, <br>
                        you will be subject to Cash Advance Fees as disclosed 
                        in your Credit Card Agreement.<br>
<br>
                    </span></p>
                    </td>
                </tr>
                <TR align="left" valign="middle" bgcolor="#FFFFFF">
                  <TD valign="top" class="exciting">                    
				  <!-- End footer content -->
					<%@ include file="footer.jsp" %>	
					<!-- End footer content -->
					</TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			<!-- Start welcome box content -->
					<%@ include file="welcome.jsp" %>	
					<!-- End welcome box content -->
					
			  <!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
       		<!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="CSREQPIN" pageLocation="a1"/>    
			<!-- End Dynamic Content -->
			<!-- 2008 0486 PPP Enrollment image start -->
                    <% 
                     if (pppEligiblityVO.getEligibility().trim().equals("eligible"))
                      {
                     %>
	                     <TABLE align=center>
				         	<TR>
				         		<TD>
				         			<a onClick="submitPPPEnrollment();" class="acslink" onmouseover="Tip('<b>Protect Yourself and Your Family!<\/b> With Payment Protection Plus you may have your minimum monthly payments made for you during difficult times such as Disability, Hospitalization, and Unemployment. Click here to learn more.',
		         																	BALLOON, true, WIDTH ,'220',   ABOVE, true,  OFFSETX, -17)" onmouseout="UnTip()"> <img src="images/PPP-Logo.gif" border="0"></a>
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
</table>
<input type="hidden" name="pageGuid" value="${guid}">
</form>
</center>
</body>
</html>
<%
	//Logger.getLogger("oasweb").debug("Exit csRequestPIN.jsp");
%>