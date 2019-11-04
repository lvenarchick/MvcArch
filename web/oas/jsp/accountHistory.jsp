<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.*"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@ page import="com.acs.oas.components.valueobject.AcctHistVO"%>
<%@ page import="com.acs.oas.components.valueobject.AcctHistObj"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");

	//Logger.getLogger("oasweb").debug("Enter accountHistpry.jsp");

	CustomerInfoVO custInfo = (CustomerInfoVO) session.getAttribute(OASConstants.CUSTOMERINFO_VO);
    String accNumber = custInfo.getSelectedAccount();
   	List accList = custInfo.getAccountList();
	
	AcctHistVO  myAcctHistVO = (AcctHistVO)request.getAttribute(OASConstants.ACCTHIST_VO);
	
	List acctHistList= myAcctHistVO.getAcctHistDetail();
	//Logger.getLogger("oasweb").debug("myacctHistVO:"+acctHistList.size());
	
	/* SRF 2008 0486 PPP Open Enrollment*/
   	//get pppEligiblity VO for account# and expiration date - required for pre-populating pppEnrollmentPage
   	PPPEligiblityVO pppEligiblityVO =(PPPEligiblityVO)session.getAttribute(OASConstants.PPPELIGIBLE_VO);
	Logger.getLogger("oas").debug("accountHistory.jsp  pppEligiblityVO: " + pppEligiblityVO );

   	if(pppEligiblityVO != null)
   	{
   		String pppEligibility = pppEligiblityVO.getEligibility().trim();
   		String pppAccountNumber = pppEligiblityVO.getAccountNumber().trim();
   		String pppExpDate	= pppEligiblityVO.getExpireDt().trim();
   		//Logger.getLogger("oas").debug("accountHistory.jsp  pppEligibility: " + pppEligibility + ", pppAccountNumber: " + pppAccountNumber + ", pppExpDate: "+pppExpDate+"]");
   	}
%>
<html>
<head>
<title>Applied Bank - Online History</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="View requests made within Online Account Services since 10/23/05. Requests made by mail or by speaking to a representative may not show in your online account history.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank - Online History">
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
	document.getElementById("mForm").action="logoff.do";
	document.getElementById("mForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("mForm").action="pppEnrollmentInt.do";
	document.getElementById("mForm").submit();
}

function doPayOnlineNow()
{
	document.getElementById("mForm").action="oaspay.do";
	document.getElementById("mForm").submit();
}

function doCustomerService()
{
	document.getElementById("mForm").action="customerService.do";
	document.getElementById("mForm").submit();
}
</script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form autocomplete="nope" name="mForm" id="mForm" method="POST" >
<input type="hidden" name="action" value="">
<input type="hidden" name="pageGuid" value="${guid}">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header1.jsp" %>

	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR valign="top">
                  <TD width="37%" valign="top"><span class="formtext"></TD>
                  </TR>
                <TR align="left">
                  <TD valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60%" valign="top"><h1>Online  History<span class="data"><strong> </strong></span></h1></td>
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
								<select name="AccountList" class="note" onChange="javascript:submitForm('accountSummary.do','changeAccount')">
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
                <TR align="left" valign="middle">
                  <TD height="3" bgcolor="#CCCCCC" class="data"><img src="images/blank.gif" width="1" height="1"></TD>
                </TR>
                <TR align="left" valign="middle">
                  <TD height="10" class="data"><img src="images/blank.gif" width="1" height="1"></TD>
                </TR>
                <TR align="left" valign="middle">
                  <TD class="data"><p>The information below reflects requests made within Online Account Services. Requests made by mail or by speaking to a representative may not show in your online account history.</p>
                    <p>&nbsp;                    </p>
                    <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr bgcolor="#D6EFFC" class="formtext">
                      <td height="20"><div align="center"><strong>Date</strong></div></td>
                      <td height="20" bgcolor="#D6EFFC"><div align="left"><strong>Action Completed </strong></div></td>
                    </tr>
						   <c:choose>
							<c:when test="${fn:length(acctHistVO.acctHistDetail) > 0}">
						   	<c:forEach items="${acctHistVO.acctHistDetail}" var="myAcctHistObj" varStatus="loop">
							   <tr bgcolor="#e2e4e5" class="formtext">
								   <td height="20"><div align="center">${myAcctHistObj.actionDate}</div></td>
		                           <td height="20"><div align="left">${myAcctHistObj.actionDescriptions}</div></td>
		                        </tr>		
	                        </c:forEach>
	                        </c:when>
	                        <c:otherwise>
	                        	<tr class="formtext">
							   		<td height="20" colspan="3"><div align="left">&nbsp;&nbsp;&nbsp;&nbsp;No Online History Data</div></td>                            
                          		</tr>	
	                        </c:otherwise>
	                        </c:choose>

					
                    
					 <tr class="formtext">
                      <td colspan="2">
					  	<%@ include file="footer.jsp" %>	
                        </td>
                    </tr>
                    </table></TD></TR>

            </TABLE>
            </td>
            <td width="26%" align="right" valign="top">
			<!-- Start welcome box content -->
			<%@ include file="welcome.jsp" %>	
					<!-- End welcome box content -->
					
			  <!-- Start Quick Links Content -->
            <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
           <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="ACCTHIST" pageLocation="a1"/>   
			 <!-- End Dynamic Content -->
			 <!-- 2008 0486 PPP Enrollment image start -->

                     <c:if test="${PPPEligiblityVO.eligibility eq 'eligible'}">
	                     <TABLE align=center>
				         	<TR>
				         		<TD>
				         			<a onclick="submitPPPEnrollment();" class="acslink" onmouseover="Tip('<b>Protect Yourself and Your Family!<\/b> With Payment Protection Plus you may have your minimum monthly payments made for you during difficult times such as Disability, Hospitalization, and Unemployment. Click here to learn more.', BALLOON, true, WIDTH ,'220',   ABOVE, true,  OFFSETX, -17)" onmouseout="UnTip()"> <img src="images/PPP-Logo.gif" border="0"></a>
				         		</TD>	         	
				         	</TR>	         	
				         </TABLE>
					</c:if>
          		<!-- 2008 0486 PPP Enrollment image end -->
           </td>
          </tr>
        </table></td>
	</tr>
</table>

</form>
</center>
</body>
</html>
<%
	//Logger.getLogger("oasweb").debug("Exit accountHistory.jsp");
%>