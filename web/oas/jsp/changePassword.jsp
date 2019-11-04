<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>				 
<%
	//Logger.getLogger("oasweb").debug("Enter changePassword.jsp");

	response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
	response.addHeader("X-Frame-Options", "DENY");
	
	CustomerInfoVO custInfo = (CustomerInfoVO) session.getAttribute(OASConstants.CUSTOMERINFO_VO);
    String accNumber = custInfo.getSelectedAccount();
   	List accList = custInfo.getAccountList();
	
	
	String cPass 	= "";
	String newPass 	= "";
	String confirmPass 	= "";
	
	String errorMsg	= (String) request.getAttribute("errorMsg");
	
	if (errorMsg== null){
		errorMsg = "";
	} 
	
	String username2 = custInfo.getUserName();	
	
	/* SRF 2008 0486 PPP Open Enrollment*/
   	//get pppEligiblity VO for account# and expiration date - required for pre-populating pppEnrollmentPage
   	PPPEligiblityVO pppEligiblityVO =(PPPEligiblityVO)session.getAttribute(OASConstants.PPPELIGIBLE_VO);
   	if(pppEligiblityVO != null)
   	{
   		String pppEligibility = pppEligiblityVO.getEligibility().trim();
   		String pppAccountNumber = pppEligiblityVO.getAccountNumber().trim();
   		String pppExpDate	= pppEligiblityVO.getExpireDt().trim();
   		//Logger.getLogger("oas").debug("changePassword.jsp::["+pppEligibility+"],["+pppAccountNumber+"],["+pppExpDate+"]");
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
<script language="JavaScript" src="oas.js"></script>
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
	document.getElementById("updatePassForm").action="logoff.do";
	document.getElementById("updatePassForm").submit();
}

function accountSummary()
{
	document.getElementById("updatePassForm").action="accountSummary.do";
	document.getElementById("updatePassForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("updatePassForm").action="pppEnrollmentInt.do";
	document.getElementById("updatePassForm").submit();
}

function validateAndSubmitPassForm()
{
	var passwordsOk = submitUpdatePassForm();
	if (passwordsOk === false) {
		document.getElementById("updatePassForm").action="displayUpdatePassword.do";
		document.getElementById("updatePassForm").submit();
	}
	if (passwordsOk === true) {
		document.getElementById("updatePassForm").action="updatePassword.do";
		document.getElementById("updatePassForm").submit();
	}
}

function checkLength(fieldName) {
	console.log("document.getElementById(fieldName).value: " + document.getElementById(fieldName).value);
	if (document.getElementById(fieldName).value.length >= 16) {
		alert("Passwords can not be longer than 16 characters.");
	}
}

function doPayOnlineNow()
{
	document.getElementById("updatePassForm").action="oaspay.do";
	document.getElementById("updatePassForm").submit();
}

function doCustomerService()
{
	document.getElementById("updatePassForm").action="customerService.do";
	document.getElementById("updatePassForm").submit();
}
</script>
<link href="css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form name="updatePassForm" id="updatePassForm" autocomplete="nope" method="post">
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
                      <td width="60%" valign="top"><h1>Change Password<span class="data"><strong></strong></span></h1></td>
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
                  <TD height="5" valign="top"><img src="images/blank.gif" width="1" height="1">
				  </TD>
                  </TR>
                <tr>
                  <td height="3" valign="top" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                </tr>
                <tr>
                  <td height="5" valign="top"><img src="images/blank.gif" width="1" height="1">
				   <% if (!errorMsg.equalsIgnoreCase("") && errorMsg!=null){
				  	
					out.print(errorMsg);
					cPass = "";
					newPass = "";
					confirmPass = "";
				  }
				  %>
				  </td>
                </tr>
                <tr>
                  <td height="20" valign="top">
                      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                          <td height="25" colspan="2" class="data">To change your 
                            password, please enter a new password in the space 
                            below and click update. </td>
                        </tr>
                        <tr class="data"> 
                          <td height="25">Current 
                            Password: </td>
                          <td height="25" valign="middle" class="warning">
                            <input name="currentPassword" id="currentPassword" type="password" autocomplete="nope"  class="form" maxlength="16" onkeypress="checkLength('currentPassword');" >
                          </td>
                        </tr>
                        <tr class="data"> 
                          <td height="25">New 
                            Password :</td>
                          <td height="25">
                            <input name="newPassword" id="newPassword" type="password" autocomplete="nope"  class="form" maxlength="16" onkeypress="checkLength('newPassword');">
                            <span class="warning">8-16 characters (alphanumeric, and at least 1 special character required.)</span></td>
                        </tr>
                        <tr class="data"> 
                          <td height="25">Confirm 
                            Password:</td>
                          <td height="25">
                            <input name="confirmPassword" id="confirmPassword" type="password" autocomplete="nope"  class="form" maxlength="16" onkeypress="checkLength('confirmPassword');" />
                            <span class="warning"> (Passwords are case sensitive.) 
                            </span></td>
                        </tr>
                        <tr class="data"> 
                          <td height="10" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
                        </tr>
                        <tr class="data"> 
                          <td height="20">
                            <div align="center"> </div>
                          </td>
                          <td height="20">
						  <input type="image" src="images/buttons/update.gif" name="Image43" id="Image35" width="72" height="20" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image42','','images/buttons/update-h.gif',1)" onclick="validateAndSubmitPassForm();">
						  </td>
                        </tr>
                        <tr class="data"> 
                          <td height="20" colspan="2"> 
                            <!-- End footer content -->
                            <%@ include file="footer.jsp" %>
                            <!-- End footer content -->
                          </td>
                        </tr>
                      </table>                  
                  </td>
                </tr>
               </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			<!-- Start welcome box content -->
					<%@ include file="welcome.jsp" %>	
					<!-- End welcome box content -->
					<!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
 			<!--  Password Hints -->

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
	//Logger.getLogger("oasweb").debug("Exit changePassword.jsp");
%>