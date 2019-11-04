<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="java.util.*"%>
<%@ page import="com.acs.oas.components.valueobject.AuthenticationSetupVO"%>
<%@taglib prefix="oasjsp" uri="oas-taglib" %>

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
</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/2ql_apply_online-hover.gif','images/2ql_new_functions-hover.gif','images/2ql_status-hover.gif','images/2ql_payment-hover.gif','images/buttons/signin-h.gif','images/online_account-hover.gif','images/buttons/continue-h.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form name="obForm" method="POST" autocomplete="nope" action="authPassReset.do">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header_auth.jsp" %>

<input type="hidden" name="pageGuid" value="${guid}"/>
<!-- Start main content -->
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top">
			 <TABLE width=544 border=0 cellpadding="2" cellspacing="2">
              <TBODY>
                <TR>				  	
                    <TD valign="top"> 
                      <h1>Retrieve Username</h1>
                      <p>Your username: <strong>${oasLoginUserName}</strong></p>
                      <br>
                      </TD>
                </TR>
			   	<TR>
	                <td><img src="images/blank.gif" width="1" height="5"></td>
	            </TR>	

                <TR>
                  <TD height="10" valign="top">
                  <% 
				  //String errMsg = (String)session.getAttribute(OASConstants.LOGIN_ERR);
				   	//Logger.getLogger("oasweb").debug("errMsg:"+errMsg);
					//session.removeAttribute(OASConstants.LOGIN_ERR);
					String errMsg = (String)request.getAttribute(OASConstants.LOGIN_ERR);
				   if(errMsg != null && !errMsg.trim().equals("")){  
				
                 	out.print("<p align=\"center\" class=\"formtextred\"><img src=\"images/alert.gif\" width=\"25\" height=\"25\">"+ errMsg+"</p><BR>");
				  }//end if %> 
				  </TD>
				</TR>
				<tr>
					<td class="data">Would you like to reset your password?<br></td>
				</tr>
				<tr>
					<td class="data">
					</td>
				</tr>
          		<TR>
					<TD>
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
					<input type="image" src="images/buttons/yes.gif" name="resetPwdYesBtn" id="resetPwdYesBtn" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image371','','images/buttons/yes-h.gif',1)" />
					<input type="image" src="images/buttons/no.gif" name="resetPwdNoBtn" id="resetPwdNoBtn" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image371','','images/buttons/no-h.gif',1)" />
	                      	</span>
	                      </td>
	                  	</tr>
	                  	</table>
					</TD>
				</TR>
				
               <TR align="left" valign="middle" bgcolor="#FFFFFF">
        			<TD valign="top" class="exciting">                   
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
			<div align="center">
	          <table width="175" border="0" cellspacing="0" cellpadding="0">
	            <tr>
	                <td height="5"><img src="images/blank.gif" width="1" height="1"></td>
	            </tr>
	          </table>               
	        
			</div>    			
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
//Logger.getLogger("oasweb").debug("Exit enroll_ob_entry.jsp");
%>