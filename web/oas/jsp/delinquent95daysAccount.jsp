<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger,java.util.*"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="com.acs.oas.util.*,com.acs.oas.components.valueobject.*,com.acs.drapi.*"%>
<%@ page import="java.util.Collection"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<%
	//Logger.getLogger("oasweb").debug("Enter delinquent95daysAccount.jsp");
	   

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	Long accNo = (Long) request.getAttribute(OASConstants.DEQ_ACCNT);
    String accNumber = accNo.toString();
    accNumber = accNumber.substring(accNumber.length()-4,accNumber.length());
	
	String paymentMissed = (String) request.getAttribute("bucket");
	if (paymentMissed == null) {
		paymentMissed= "";
	}
	
%>
<html>
<title>Applied Bank</title>
<head>
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
<script language="JavaScript">

function payNow()
{
	document.getElementById("delinquent95DaysForm").action="oaspay.do";
	document.getElementById("delinquent95DaysForm").submit();
}

function doPayOnlineNow()
{
	document.getElementById("delinquent95DaysForm").action="oaspay.do";
	document.getElementById("delinquent95DaysForm").submit();
}

function doCustomerService()
{
	document.getElementById("delinquent95DaysForm").action="customerService.do";
	document.getElementById("delinquent95DaysForm").submit();
}
</script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form name="delinquent95DaysForm" id="delinquent95DaysForm" autocomplete="nope" method="post">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header.jsp" %>
	
	<tr>
		<td valign="top">
		
		<table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>
                  <TD width="37%" valign="top"><h1>Welcome to Online Account Services </h1>
                    <p></p></TD>
                </TR>
                <TR>
                  <TD height="10" valign="top"><img src="images/blank.gif" width="1" height="1"></TD>
                  </TR>
                <tr>
                  <td height="20" align="center" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td width="544"><div>
                          <h2 align="center"> Access to online services is prohibited on your past due account. <br> </h2>
                          <div align="center">
                            <p><span class="data">Your account <strong>xxxx-xxxx-xxxx-<%=accNumber %> </strong> is <strong> <%=paymentMissed %> payments </strong> past due and an immediate payment is required now.  Click the link below to make a payment and restore access to online services.  Use of online services is prohibited until a sufficient payment is received.<br>
                                  <br> 
                                <a onClick="payNow();" class="logoff acslink">Make a Payment Now</a></span></p>
                            <p>Return <a href="https://cardcenter.appliedbank.com" class="red">Home</a> </p>
                            <p>To make payment arrangements call <%=OASConstants.CUSTOMER_SERVICE_PHONE%>.</p>
                            <p> <BR>
                                              </p>
                          </div>
                      </div></td>
                    </tr>
                  </table>                    
                    <div align="left"></div>
                  </td>
                </tr>
                <TR align="left" valign="middle" bgcolor="#FFFFFF">
                  <TD valign="top" class="exciting">                    
				  <!--Start footer content -->
					<%@ include file="footer.jsp" %>	
					<!-- End footer content -->
					</TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			 <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
              <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="DELQAC95D" pageLocation="a1"/>    
			<!-- End Dynamic Content -->
           </td>
          </tr>
        </table></td>
	</tr>
	<input type="hidden" name="action" value="changeAccount">
	<input type="hidden" name="pageGuid" value="${guid}">
	</form>
</table>
</center>
</body>
</html>
<%
	//Logger.getLogger("oasweb").debug("Exit delinquent95daysAccount.jsp");
%>