<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>


<%
	//Logger.getLogger("oasweb").debug("Enter appConfStatus.jsp");

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");	
String errMessage	 = (String) request.getAttribute("emsg");
	Logger.getLogger("oasweb").debug("Application Status Message"+errMessage);
	if (errMessage == null)
		errMessage = "";
%>
<HTML>
<HEAD>
<TITLE> Error Page </TITLE>
</HEAD>
<BODY>
<FORM autocomplete="nope">
<p>Message from server</p>
<strong><%= errMessage %></strong>
</FORM>
</BODY>
</HTML>