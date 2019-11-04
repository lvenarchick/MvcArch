<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%  
	Exception exception =(Exception)request.getAttribute("Exception");
	if (exception == null)
    {
        exception = new Exception("Unknown error. No message available.");
    }
	String strMessage = exception.getMessage();
	if (strMessage == null)
	{
		strMessage = "No message available.";
	}
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
<meta name="description" content="Applied Bank works with people to re-establish credit.  Find out about credit card offers and sign up for Applied Bank's Online Account Services.">
<meta name="keywords" content="applied bank, cross country bank, cross country, credit cards, secured cards, unsecured cards, no credit, bad credit, establish credit, re-establish credit, visa gold, bankrupt, credit needy, crosscountry, credit problems, poor credit, rebuild credit history, cross country, credit cards, cross country bank, ccb, cross country, credit, cross-country">
<meta name="category" content="home page" >
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<link href="css/styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" SRC="submit.js"></script>
<script language="JavaScript" SRC="CommonFunctions.js"></script>
<script language="JavaScript" SRC="DisableRightClick.js"></script>
<script>disablerightclick();</script>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="MM_preloadImages('images/nav2_06.gif','images/nav2_07.gif','images/nav2_08.gif','images/nav2_09.gif','images/nav2_10.gif','images/submit-h.gif')">
<center>
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
<%@ include file="header.jsp" %>
<!-- Start page main conntent -->  
<tr>
	<td valign="top">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
			<td width="74%" valign="top">
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
		        <tr valign="top">
		        <td>
		        	<h1>Server Error!<span class="excitingbluebig"></span></h1>
		        	<BR><BR>
		        </td>
		        </tr>
		        </table>
				<table width="100%"  border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="45" valign="top">
						<img src="iExclamation.gif" height="19" width="16" align="left">
						<p class="excitingblue">We&rsquo;re sorry. A server error occurred.</p>
					</td>
				</tr>
				<tr><td height="20" valign="top"><blockquote><p class="excitingblue">Please contact our Customer Service Department at <%=OASConstants.CUSTOMER_SERVICE_PHONE%>.</p></blockquote></td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
				<tr><td>&nbsp;</td></tr>
				</table>
				<%@ include file="footer.jsp" %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</center>
</body>
</html>