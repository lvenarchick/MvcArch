
<%@ page import="org.apache.log4j.Logger,java.util.Collection"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="java.util.Collection"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<c:set var="devMode" value="<%=OASConstants.DEV_MODE%>" />
<%
	//Logger.getLogger("oasweb").debug("Enter login.jsp");
response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server
	
	Cookie c = new Cookie("dakdak", "true"); 
	c.setSecure(true);
	c.setMaxAge(240);
	response.addCookie(c);
	
	String username = (String) request.getAttribute("username");
	if(username == null)
		username = "";

	//String userAgentHeader = request.getHeader("user-agent");
	//if(userAgentHeader.matches("[0-9a-zA-Z_]+")) session.setAttribute("userAgent", userAgentHeader);
	
	//String acceptHeader = request.getHeader("accept");
	//if(acceptHeader.matches("[0-9a-zA-Z_]+")) 	session.setAttribute("accept", acceptHeader);
	
%>

<html>

<head>
<title>Applied Bank's Online Account Services</title>
<link rel="shortcut icon" href="images/icons/AB_icon.ico" type="image/x-icon"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="By signing into Applied Bank’s Online Account Services you can take advantage of 24-hour access to information such as your balance, available credit, payment history, transactions, and online statements. Enter your username and password to sign in.">
<meta name="keywords" content="Applied Bank, Applied card, AB, cross country bank, cross country, credit cards, Online Account Services, payment history, transactions, online statements, on-line, transactions, account information, OAS, customer service, payment center, contact information, update, change, email, request a pin, order cash advance checks, change password, address, phone number">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<c:if test="${devMode}">
<meta name="version" content="<%=OASConstants.QA_VERSION%>">
</c:if>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV=Expires CONTENT="now">
<link href="css/styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="menu1.js"></script>
<script language="JavaScript" src="oas.js"></script>
<script language="javascript" src="AC_OETags.js" ></script>
<script type="text/javascript" src="https://content.appliedbank.com/jquery/jquery-latest.min.js"></script>
<script type="text/javascript" src="preventDblClick.js"></script> 
<script type="text/javascript" src="jquery-impromptu.3.2.min.js"></script>
<script type="text/javascript" src="PluginDetect.js"></script>
<script type="text/javascript" src="BrowserTests.js"></script>
<script type="text/javascript" src="fingerprint.js"></script> 
<script type="text/javascript" src="fontdetect.js"></script> 
<script language="JavaScript">

function displayEnrollment()
{
	document.getElementById("loginForm").action="displayEnrollmentInt.do";
	document.getElementById("loginForm").submit();
}

function forgotUsername()
{
	document.getElementById("loginForm").action="forgotUserOrPasswordInt.do";
	document.getElementById("loginForm").submit();
}

function displayAppStatus()
{
	document.getElementById("loginForm").action="appStatusInt.do";
	document.getElementById("loginForm").submit();
}
function resetPasswordInt()
{
	document.getElementById("loginForm").action="resetPasswordInt.do";	document.getElementById("loginForm").submit();
}
</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif'); fingerprint1('${guid}');" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form id="loginForm" name="loginForm" method="POST" autocomplete="nope" action='login.do' >
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header.jsp" %>


<!-- Start main content -->
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>				  	
                  <TD width="37%" valign="top"><h1>Sign in to Online Account Services </h1>
                    <p></p></TD>
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
                  <td height="20" align="center" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td height="25" colspan="2" class="data">By signing into Applied Bank's<sup>&reg;</sup> Online Account Services, you can take advantage of 24-hour access to information such as your balance, available credit, payment history, transactions, and online statements. </td>
                      </tr>
                    <tr>
                          <td height="25" colspan="2" class="data">Enter Username 
                            below. Not a member? <a onClick="displayEnrollment();" class="formtextred acslink">Click 
                            here</a> to enroll. </td>
                      </tr>
                    <tr>
                      <td width="94" height="25"><div align="right" class="formtext">
                          <div align="left">Username:&nbsp;&nbsp;</div>
                      </div></td>
                      <td height="25" align="center"><div align="left"> 						  
                          <input name="username" type="text" autocomplete="nope"  size="16" value="<%=username %>">
                      </div></td>
                    </tr>
                    <tr>
                      <td colspan="2" >&nbsp;&nbsp;
                          </td>
                    </tr>
                    <tr>
                      <td height="5" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
                      </tr>
                    <tr>
                      <td width="94"><div align="left"></div></td>
                      <td width="450" height="25" align="left" valign="middle">
                 		
						<input type="image" src="images/buttons/signin.gif" name="Image36" id="Image36" width="72" height="20" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image36','','images/buttons/signin-h.gif',1)" onclick="javascript:return submitLoginForm()">
					</td>
					</tr>
                    <tr>
                      <td height="5" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
                      </tr>					
                    <tr>
                      <td><div align="center" class="exciting"></div></td>
                      <td valign="top"><p class="exciting"><a onClick="forgotUsername();" class="formtextred acslink">Forgot Username/Password? </a> </p></td>
                    </tr>
					
                    <tr>
                      <td colspan="2"><div>
                          <p><img src="images/goldlock.gif" width="11" height="14">&nbsp; Your login information is protected using Secure Sockets Layer (SSL) technology.&nbsp;<A 
href="https://cardcenter.appliedbank.com/privacy.jsp#onlines"  target="_blank" class="formtextred">Learn more.</A></p>
                          <BR>
                      </div></td>
                    </tr>
                  </table>                    
                    <div align="left"></div>
                  </td>
                </tr>
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
           <%@ include file="links.jsp" %>
		   <!-- End Quick Links Content -->
             <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="OASLOGIN" pageLocation="a1"/>   
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
<input  name="flashInstalled" type="Hidden" value="">

<input type="hidden" name="pageGuid" value="${guid}"/>
</form>
</center>
<noscript>
	<meta http-equiv="refresh" content="0;URL=jscriptDisabled.jsp">
</noscript>
<div id="plugindetect"></div>
</body>
</html>
<%
	//Logger.getLogger("oasweb").debug("Exit login.jsp");
%>