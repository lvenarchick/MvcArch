<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="org.apache.log4j.Logger,java.util.*"%>
<%@ page import="com.acs.oas.util.*,
				 com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo,
				 com.acs.oas.components.dataobject.*,
				 com.acs.drapi.*"%>
<%@ page import="java.util.Collection"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>		
<%
	//Logger.getLogger("oasweb").debug("Enter delinquentAccount65days.jsp");

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	CustomerInfoVO custInfo =(CustomerInfoVO)session.getAttribute(OASConstants.CUSTOMERINFO_VO);
   	String accNumber = custInfo.getSelectedAccount();
	
	//get DataObject set in session
   	DataObject dataObj = (DataObject)session.getAttribute(OASConstants.DATA_OBJECT);
   	Account account = dataObj.getAccount(accNumber);
   
   AccountSummaryVO summaryVO =(AccountSummaryVO) account.get(OASConstants.ACCT_SUMMARY_VO);
   AccountDetailsVO accountVO = summaryVO.getAccDetailsVO(); 
  
   String delqDays= (String) request.getAttribute("delqDays");
   
   String paymentMissed = (String) request.getAttribute("bucket");
	if (paymentMissed == null) {
		paymentMissed= "";
	}
   
   if (accountVO==null){
		throw new Exception("Account Information is not available"); 		
   }
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
<script language="JavaScript">

function payNow()
{
	document.getElementById("delinquent65DaysForm").action="oaspay.do";
	document.getElementById("delinquent65DaysForm").submit();
}

function accountSummary()
{
	document.getElementById("delinquent65DaysForm").action="accountSummary.do";
	document.getElementById("delinquent65DaysForm").submit();
}

</script>
<link href="/css/styles.css" rel="stylesheet" type="text/css">
<script>function displayAppStatus(){document.getElementById("delinquent65DaysForm").action="appStatusInt.do";	document.getElementById("delinquent65DaysForm").submit();}</script>

</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form name="delinquent65DaysForm" id="delinquent65DaysForm" autocomplete="nope" method="post">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header.jsp" %>

<!-- Start main content -->
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
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
                          <h2 align="center"> Did you forget? </h2>
                          <div align="center">
                              <p>Our records indicate that your account is currently 
                                <strong> <%=paymentMissed %> payment(s) </strong> 
                                past due. <br>
                              If payment is not received by <%=accountVO.getPaymentDueDate()%>, your online account services may be suspended.<br>
                            </p>
                            <p><span class="data"><a onClick="payNow();" class="logoff acslink">Make a Payment Now</a></span></p>
                            <p>Continue to <a onClick="accountSummary();" class="red acslink">Online Account Services</a></p>
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
				   <%@ include file="footer.jsp" %>
				                    </TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
		<!-- Start Quick Links Content -->
           <%@ include file="links.jsp" %>
		   <!-- End Quick Links Content -->
             <!-- Start Dynamic Content -->
           	<dynjsp:DynamicContent  page="DELQAC65D" pageLocation="a1"/>    
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
	//Logger.getLogger("oasweb").debug("Exit delinquentAccount65days.jsp");
%>