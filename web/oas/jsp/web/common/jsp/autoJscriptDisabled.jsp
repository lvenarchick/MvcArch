<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%
	//Logger.getLogger("acbweb").debug("Enter defaultErrorHandler.jsp");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server
response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
%>
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
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td height="87" align="right" background="images/abcc_color_version_header.gif"></td>
</tr>
<tr>
	<td height="7"><img src="images/newtop3_03.gif" width="750" height="7" alt=""></td>
</tr>
<tr>
	<td height="4"><img src="images/blank.gif" height="4"></td>
</tr>	
<tr>
	<td valign="top">
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>&nbsp;</td>
		</tr>
	    <tr>
			<td width="74%" valign="top">
				<table width="100%"  border="0" cellpadding="0" cellspacing="0">
				<tr align="center">
					<td >
				    	<p style="font-family: Arial, Helvetica, sans-serif;font-size: 10pt;color: #000000;font-weight: bold;">Your web browser does not currently support JavaScript. In order to view <br>this online page, you must enable your browser to run JavaScript.</p>
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2">&nbsp;</td></tr>
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
<%
	//Logger.getLogger("acbweb").debug("Exit defaultErrorHandler.jsp");
%>