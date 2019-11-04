<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="java.util.*"%>
<%@ page import="com.acs.oas.components.valueobject.AuthenticationSetupVO"%>
<%@ taglib prefix="oasjsp" uri="oas-taglib" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server
response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
%>

<html>
<head>
<title>Applied Bank's Online Account Services</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="By signing into Applied Bank’s Online Account Services you can take advantage of 24-hour access to information such as your balance, available credit, payment history, transactions, and online statements. Enter your username and password to sign in.">
<meta name="keywords" content="Applied Bank, Applied card, AB, cross country bank, cross country, credit cards, Online Account Services, payment history, transactions, online statements, on-line, transactions, account information, OAS, customer service, payment center, contact information, update, change, email, request a pin, order cash advance checks, change password, address, phone number">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<script language="JavaScript" src="menu1.js"></script>
<script language="JavaScript" src="oba.js"></script>
<script language="JavaScript" src="DisableRightClick.js"></script>
<script language="JavaScript">disablerightclick()</script>
<link href="css/styles.css" rel="stylesheet" type="text/css">
<script>
	var disableContinue = false;


	function checkLength(fieldName) {
		if (document.getElementById(fieldName).value.length == 16) {
			alert("Passwords can not be longer than 16 characters.");
		}
	}
</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/2ql_apply_online-hover.gif','images/2ql_new_functions-hover.gif','images/2ql_status-hover.gif','images/2ql_payment-hover.gif','images/buttons/signin-h.gif','images/online_account-hover.gif','images/buttons/continue-h.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form name="obForm" method="POST" autocomplete="nope" action="userReqResetPassWord.do">
<input type="hidden" name="pageGuid" value="${guid}"/>
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header_auth.jsp" %>

<!-- Start main content -->
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top">
			 <TABLE width=544 border=0 cellpadding="2" cellspacing="2">
              <TBODY>
                <TR>				  	
                    <TD colspan="2" valign="top"> 
                      <h1>Reset Password</h1>
                      </TD>
                </TR>
			   	<TR>
	                <td><img src="images/blank.gif" width="1" height="5"></td>
	            </TR>	

                <TR>
                  <TD colspan="2" height="10" valign="top">
                  <c:forEach items="${errorMsgList}" var="errorMessage">
					<div align="center" class="formtextred"><img src="images/alert.gif" width="25" height="25">${errorMessage}</div>
                  </c:forEach> 
				  </TD>
				</TR>
                 <TR>
                   <TD width=135 height="20"><span class="formtextred"><strong>* Required Fields</strong></span><strong>&nbsp;</strong></TD>
                   <TD width=410 height="20">&nbsp;</TD>
                 </TR>				
				<tr>
					<td class="formtext">Your username:</td>
					<td class="formtext"><strong>${oasLoginUserName}</strong></td>
				</tr>
				<tr>
					<td width="200" class="formtext">Enter a new password: <span class="formtextred">*</span></td>
					<td class="formtext"><input type="password" name="newpass" id="newpass" maxlength="16" onkeypress="checkLength('newpass');"/></td>
				</tr>

				<tr>
					<td colspan="2" class="warning">Minimum of 8 characters( alphanumeric and at least 1 special character required)</td>
				</tr>
				<tr>
					<td class="formtext">Confirm your password: <span class="formtextred">*</span></td>
					<td class="formtext"><input type="password" name="confnewpass" id="confnewpass" maxlength="16" onkeypress="checkLength('confnewpass');"/></td>
				</tr>
          		<TR>
					<TD colspan="2">
						<table width="100%"  border="0" cellspacing="2" cellpadding="2">
	                    <tr>
	                      	<td colspan="2" align="center"></td>
	                    </tr>
	                    <tr>
	                    	<td colspan="2" align="center"></td>
					    </tr>
	                    <tr>
	                      <td colspan="2" align="center">
	                      	<span class="data">
						  		<input type="image" src="images/buttons/submit.gif" name="submitBtn"  id="submitBtn" onMouseOut="MM_swapImgRestore()" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('submitBtn','','images/buttons/submit-h.gif',1)">
						  		<input type="image" src="images/buttons/cancel.gif" name="cancelBtn"  id="cancelBtn" onMouseOut="MM_swapImgRestore()" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('cancelBtn','','images/buttons/cancel-h.gif',1)" >
	                      	</span>
	                      </td>
	                  	</tr>
	                  	</table>
					</TD>
				</TR>
</form>
				
               <TR align="left" valign="middle" bgcolor="#FFFFFF">
        			<TD colspan="2" valign="top" class="exciting">                   
					<%@ include file="footer.jsp" %>	
					</TD>
     			</TR>
				<!-- End footer content -->     
              </TBODY>
            </TABLE></td>

			<td width="26%" align="right" valign="top">
			<!-- Start Quick Links Content -->
        <%@ include file="links_authenticationSetup.jsp" %>

		   <!-- End Quick Links Content -->
             <!-- Start Dynamic Content -->

			<!-- End Dynamic Content -->
    			
           </td>
          </tr>
        </table></td>
	</tr>
</table>
</center>
</body>
</html>
<%
//Logger.getLogger("oasweb").debug("Exit enroll_ob_entry.jsp");
%>