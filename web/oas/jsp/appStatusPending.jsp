<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger, java.util.Collection"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>

<%
	//Logger.getLogger("oasweb").debug("Enter appStatusPending2.jsp");

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	
	String fn = (String) request.getAttribute("fname");
	String ln = (String) request.getAttribute("lname");
	String ad = (String) request.getAttribute("adate");
	String StatusMessage = (String) request.getAttribute("Status");
	//Logger.getLogger("oasweb").debug("Application Status FirstName"+fn);
	//Logger.getLogger("oasweb").debug("Application Status LastName"+ln);
	//Logger.getLogger("oasweb").debug("Application Status Message"+StatusMessage);
	if (StatusMessage == null)
		StatusMessage = "";
%>
<html>
<head>
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
<link href="/css/styles.css" rel="stylesheet" type="text/css">
<script>function displayAppStatus(){document.getElementById("linksForm").action="appStatusInt.do";	document.getElementById("linksForm").submit();}</script>

</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form id="linksForm" autocomplete="nope" method="POST" action="">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
		 <%@ include file="header.jsp" %>

	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>
                  <TD width="37%" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60%" valign="top"><h1>Credit Offer Status</h1><br></td>
                    </tr>
                  </table></TD>
                </TR>
                 <TR align="left" valign="middle" bgcolor="#FFFFFF">
                  <TD valign="top"><TABLE cellSpacing=1 cellPadding=0 width=99% border=0>
                      <TBODY>
                        <TR class="form">
                          <TD width=536 valign="top" class="formtext"><p><strong><%= fn %>&nbsp;<%= ln %></strong> your application  received on <%= ad %> is currently <strong><%= StatusMessage %></strong>. </p>
                            <p>Your application is important to us. We are in the process of our final review and should have a decision shortly. </p><br></TD>
                          </TR>
                      </TBODY>
                    </TABLE>
                     <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                       <%@ include file="footer.jsp" %></TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			<!-- Start welcome box content -->
				<%@ include file="links.jsp" %>
				 	
             <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="APPSTPEN" pageLocation="a1"/>     
					 <!-- End Dynamic Content -->
                           </td>
          </tr>
        </table></td>
	</tr>
</table>
<input type="hidden" name="pageGuid" value="<%=(String)session.getAttribute("guid")%>">
</form>
</center>
</body>
</html>
<%
	//Logger.getLogger("oasweb").debug("Exit appStatusPending2.jsp");
%>