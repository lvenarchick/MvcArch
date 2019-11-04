<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@page import="com.acs.util.Common" %>
<%
response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
String guid = Common.getAGuid();
session.setAttribute("guid", guid);
Logger.getLogger("oasweb").debug("index.jsp create new session guid: " + guid);
%>


<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="https://onlineaccountservices.appliedbank.com/favicon.ico">
<META HTTP-EQUIV="Refresh" CONTENT="0; URL=https://onlineaccountservices.appliedbank.com/home.do">
</head>
<BODY>
</body>
</html>
