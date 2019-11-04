<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@ page import="java.util.Collection, java.util.List"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>				 
<%
	//Logger.getLogger("oasweb").debug("Enter csRequestDispute.jsp");
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
<title>Applied Bank - Dispute a Merchant Charge</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="All reasonable steps to resolve an issue with the Merchant must take place before you dispute a charge. If the Merchant has not resolved your issue to your satisfaction, there are four ways you can dispute charges on your account.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank - Dispute a Merchant Charge">
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
	document.getElementById("requestDisputeForm").action="logoff.do";
	document.getElementById("requestDisputeForm").submit();
}

function accountSummary()
{
	document.getElementById("requestDisputeForm").action="accountSummary.do";
	document.getElementById("requestDisputeForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("requestDisputeForm").action="pppEnrollmentInt.do";
	document.getElementById("requestDisputeForm").submit();
}

function doPayOnlineNow()
{
	document.getElementById("requestDisputeForm").action="oaspay.do";
	document.getElementById("requestDisputeForm").submit();
}

function doCustomerService()
{
	document.getElementById("requestDisputeForm").action="customerService.do";
	document.getElementById("requestDisputeForm").submit();
}

</script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form name="requestDisputeForm" id="requestDisputeForm" autocomplete="nope" method="post">
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
                      <td width="60%" valign="top"><h1>Dispute Merchant Charge<span class="data"><strong> </strong></span></h1></td>
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
                  <td height="20" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="10" colspan="2" valign="top" class="data">
                         <p>You must  take all reasonable steps to resolve billing issues with the Merchant before filing a dispute on a merchant charge. If the Merchant has not resolved the issue to your satisfaction, you can download the Merchant Dispute form by <a  target="_blank" href="dispute.createpdf" class="red">clicking 
                                            here</a>. (This form requires 
                                            the Free Acrobat Reader to view it. 
                                            <a href="https://content.appliedbank.com/acb/ar_sb.html" target="_blank" class="red">Click 
                                            here</a> to download Adobe&reg; Acrobat 
                                            Reader.)</p>
                        <p>&nbsp;</p>
                        </td>
                    </tr></table>                   
                     <p align="center"><span class="note"><em> Any Merchant dispute 
                      submitted will not change your monthly minimum payment due.</em></span></p>
                    <p class="data"><BR>
                    </p></td></tr>
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
			  <%@ include file="welcome.jsp" %>
             <!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
               <!-- Start Dynamic Content -->
               		<dynjsp:DynamicContent  page="CSREQDISP" pageLocation="a1"/>    
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
	//Logger.getLogger("oasweb").debug("Exit csRequestDispute.jsp");
%>