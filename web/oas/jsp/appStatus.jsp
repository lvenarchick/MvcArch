<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants,java.util.Collection"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%

	//Logger.getLogger("oasweb").debug("Enter appStatus.jsp");
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, no-store, max-age=0"); // HTTP 1.1
	response.setHeader("Pragma","no-cache"); // HTTP 1.0
	response.setDateHeader ("Expires", 0); // Prevents caching at the proxy server
	response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
	response.addHeader("X-Frame-Options", "DENY");
    
	String errMsg = (String)request.getAttribute("emsg");
	
	Logger.getLogger("oas").debug("errMsg:"+errMsg);
	String errorMessage = "";
	if(errMsg != null && !errMsg.trim().equals(""))
	{  
		errorMessage="<tr><TD colspan=\"2\" height=\"30\" valign=\"top\" align=\"center\">"+
	   	"<p align=\"center\" class=\"formtextred\"><img src=\"images/alert.gif\" width=\"25\" height=\"25\">&nbsp;"+ errMsg+"</p></td></tr>";
	}
	else
	{
		errorMessage = "<tr><TD colspan=\"2\" height=\"10\" valign=\"top\" align=\"center\">"+
	   	"<p align=\"center\" class=\"formtextred\">&nbsp;</p></td></tr>";
	}
%>
<html>
<head>
<title>Check the status of your Applied Bank Credit Card offer</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="description" content="Customers can check the status of an Applied Bank credit offer online by simply entering in the requested data.">
<meta name="keywords" content="Applied Bank, Applied card, AB, applied bank, appliedbank, applied bank, credit offer status, application status">
<meta name="author" content="Applied Bank">
<meta name="title" content="Applied Bank - Credit Offer Status">
<meta name="robots" content="all, index, follow">
<meta name="revisit-after" content="1 days">
<meta name="version" content="<%=OASConstants.version%>">
<script language="JavaScript" src="menu1.js"></script>
<script language="JavaScript" src="oas.js"></script>
<script language="JavaScript" src="disputeFormValidation.js"></script>
<link href="css/styles.css" rel="stylesheet" type="text/css">
<script>function displayAppStatus(){document.getElementById("appStatusForm").action="appStatusInt.do";	document.getElementById("appStatusForm").submit();}</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form name="appStatusForm" id="appStatusForm" autocomplete="nope" action="appStatusResult.do" method="POST" onSubmit="javascript:return validateAppStatusForm()">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
<%@ include file="header.jsp" %>

	<tr>
	<tr>
					<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
			          <tr>
			            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
			              <TBODY>
			                <TR>
			                  <TD width="37%" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
			                    <tr>
			                      <td width="20%" valign="top"><h1>Credit Offer  Status</h1></td>
			                    </tr>
			                  </table></TD>
			                </TR>
			                 <TR align="left" valign="middle" bgcolor="#FFFFFF">
			                  <TD valign="top">
			                  	<p>Please enter the information below in order to check the status of your offer.</p>
			                  	<br>
			                    <TABLE cellspacing="1" cellpadding="0" border=0>
			                      <TBODY>					   
									<%=errorMessage%>
									<TR class="form">
			                          <TD height="20" colspan="2" class="formtext"><span class="formtextred"><strong>* Required Fields</strong></span><strong>&nbsp;</strong></TD>
			                         </TR>
								 <TR class="form">
			                          <TD height="20" class="formtext">Last Name:  <span class="formtextred">*</span></TD>
			                          <TD height="20"><input name="lastName" type=text class="form" onkeypress="return alphaNumericKey(event)" id="lastName"
			            size=15 maxlength=30 value="" >
			                            <span class="warning">(As entered on the application)</span><br></TD>
			                        </TR>
			                        <TR class="form">
			                          <TD width=147 height="20" class="formtext"><DIV align=left class=formtext> Social Security Number: <span class="formtextred">*</span></DIV></TD>
			                          <TD width=389 height="20"><INPUT
			            name="ss1" class="form" id="ss1" size=3 maxLength=3 value="" onkeypress="return numberKey(event)" onKeyDown="TabNext(this,'down',3)" onKeyUp="TabNext(this,'up',3,this.form.ss2)">
			-
			  <INPUT name="ss2" class="form" id="ss2" size=2 maxLength=2 value=""  onkeypress="return numberKey(event)" onKeyDown="TabNext(this,'down',2)" onKeyUp="TabNext(this,'up',2,this.form.ss3)">
			-
			<INPUT name="ss3" class="form" id="ss3" size=4 maxLength=4 value="" onkeypress="return numberKey(event)" ></TD>
			                        </TR>
									<TR>
                      				<TD height="5" colspan="2" valign="top"><img src="images/blank.gif" width="1" height="1"></td>
                    				</TR>
			                        <TR>
			                          <TD height="15" class=formtext>&nbsp;</TD>
			                         <TD height="15">
									   <input type="image" src="images/buttons/submit.gif" name="Image371" id="Image371" width="72" height="20" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image371','','images/buttons/submit-h.gif',1)" />
									</TD>
                        			</TR>
			                      </TBODY>
			                    </TABLE>
			                     	<%@ include file="footer.jsp" %></TD>
			                </TR>
			              </TBODY>
			            </TABLE></td>
			            <td width="26%" align="right" valign="top">
						 <!-- Start Quick Links Content -->
			           <%@ include file="links.jsp" %>
						<!-- End Quick Links Content -->
           	<dynjsp:DynamicContent  page="APPSTATS" pageLocation="a1"/>   
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
				//Logger.getLogger("oasweb").debug("Exit appStatus.jsp");
%>