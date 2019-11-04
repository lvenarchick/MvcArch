<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@ page import="java.util.Collection, java.util.List"%>
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
%>		 
<%
	//Logger.getLogger("oasweb").debug("Enter csRequestChecksNotEligible.jsp");
	
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
<title>Applied Bank</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Cross Country Bank works with people to re-establish credit.  Find out about credit card offers and sign up for Cross Country Bank's Online Account Services.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="category" content="home page" >
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank">
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

function logoff()
{
	document.getElementById("requestChecksNotEligible").action="logoff.do";
	document.getElementById("requestChecksNotEligible").submit();
}

function accountSummary()
{
	document.getElementById("requestChecksNotEligible").action="accountSummary.do";
	document.getElementById("requestChecksNotEligible").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("requestChecksNotEligible").action="pppEnrollmentInt.do";
	document.getElementById("requestChecksNotEligible").submit();
}

function doPayOnlineNow()
{
	document.getElementById("requestChecksNotEligible").action="oaspay.do";
	document.getElementById("requestChecksNotEligible").submit();
}

function doCustomerService()
{
	document.getElementById("requestChecksNotEligible").action="customerService.do";
	document.getElementById("requestChecksNotEligible").submit();
}
</script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form name="requestChecksNotEligible" id="requestChecksNotEligible" autocomplete="nope" method="post">
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
                      <td width="60%" valign="top"><h1>Order Cash Advance Checks<span class="data"><strong> </strong></span></h1></td>
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
                  <td height="20" valign="top"><h2 align="center">Need Cash Advance Checks?</h2>
                      <p align="left"> Please call Customer Service at <%=OASConstants.CUSTOMER_SERVICE_PHONE%> 
                        for information about ordering Cash Advance Checks. <span class="note"><br>
                        <br>
                        </span></p>
                    <div align="center"></div></td>
                </tr>
                <TR align="left" valign="middle" bgcolor="#FFFFFF">
                  <TD valign="top" class="exciting">                    
				   <!-- End footer content -->
					<%@ include file="footer.jsp" %>	
					<!-- End footer content --></TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
  <%@ include file="welcome.jsp" %>
             <!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
              <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="CSRQCKNEL" pageLocation="a1"/>    
			<!-- End Dynamic Content -->
			<!-- 2008 0486 PPP Enrollment image start -->
                    <% 
                     if (pppEligiblityVO.getEligibility().trim().equals("eligible"))
                      {
                     %>
	                     <TABLE align=center>
				         	<TR>
				         		<TD>
				         			<a onClick="submitPPPEnrollment();" class="acslink" onmouseover="Tip('<b>Protect Yourself and Your Family!<\/b><br> With Payment Protection Plus you may have your minimum monthly payments made for you during difficult times such as Disability, Hospitalization, and Unemployment. Click here to learn more.',
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
	//Logger.getLogger("oasweb").debug("Exit csRequestChecksNotEligible.jsp");
%>