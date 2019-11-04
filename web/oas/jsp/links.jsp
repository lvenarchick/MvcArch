
<%@ page import="org.apache.log4j.Logger"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
<%
	//Logger.getLogger("oasweb").debug("Enter links.jsp");
%>

	<!-- <form name="linksForm" id="linksForm" action="" autocomplete="nope" method="post">-->
<!-- Start links content -->  
		<table width="190" border="0" cellpadding="0" cellspacing="0">
              <!--<tr bgcolor="#FFFFFF">
                <td height="8" colspan="3"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>-->
			  <tr>
                <td height="2px"></td>
              </tr>
              <tr bgcolor="#EF6B00">
                <td height="15" colspan="3" class="ql_header"><div align="center">Quick Links</div></td>
              </tr>
              <tr>
                <td rowspan="20" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
                <td bgcolor="#CCCCCC" height="2"><img src="images/blank.gif" width="1" height="1"></td>
                <td width="1" rowspan="20" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td width="1"><a href="https://payments.appliedbank.com/home.do" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('payment','','images/2ql_payment-hover.gif',1)"><img src="images/2ql_payment.gif" alt="Make a Payment" name="payment" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td><a href="https://cardcenter.appliedbank.com/chooseCardToday.jsp" target="_blank" onMouseOver="MM_swapImage('apply','','images/2ql_apply_online-hover.gif',1)" onMouseOut="MM_swapImgRestore()"><img src="images/2ql_apply_online.gif" alt="Accept your card" name="apply" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
               <tr>
                <td><a href="https://cardcenter.appliedbank.com/accountSecurity.jsp"  target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('security','','images/2ql_account_security-hover.gif',1)"><img src="images/2ql_account_security.gif" alt="Account Security" name="security" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
               <tr>
                <td><a href="https://cardcenter.appliedbank.com/myAccount.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('functions','','images/2ql_new_functions-hover.gif',1)"><img src="images/2ql_new_functions.gif" alt="Manage my Account" name="functions" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td><a onClick="displayAppStatus();" class="acslink" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('status','','images/2ql_status-hover.gif',1)"><img src="images/2ql_status.gif" alt="Credit Offer Status" name="status" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
               <tr>
                <td><a href="https://cardcenter.appliedbank.com/faq.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('faq','','images/ql_FAQs-hover.gif',1)"><img src="images/ql_FAQs.gif" alt="FAQ" name="faq" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
             <tr>
                <td><a href="https://cardcenter.appliedbank.com/creditBasics.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('credit','','images/2ql_credit-hover.gif',1)"><img src="images/2ql_credit.gif" alt="Credit Basics" name="credit" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td><a href="https://cardcenter.appliedbank.com/accountAgreement.jsp" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image46','','images/online_account-hover.gif',1)"><img src="images/online_account.gif" alt="Online Account Agreement" name="Image46" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
              </tr>
              <tr>
                <td><a href="https://cardcenter.appliedbank.com/cap.jsp" target="_blank" onMouseOver="MM_swapImage('ppp','','images/ql_PPP-hover.gif',1)" onMouseOut="MM_swapImgRestore()"><img src="images/ql_PPP.gif" alt="Payment Protection Plus" name="ppp" width="188" height="18" border="0"></a></td>
              </tr>
              <tr>
                <td height="1" colspan="3" bgcolor="#999999"><img src="images/blank.gif"></td>
              </tr>
             <!--  <tr>  
    			  <td><a href="https://content.appliedbank.com/acb/fcsquicklinksoas_sb.html" target="_blank" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FCR','','images/ql_CheckYourCreditScore-hover.gif',1)"><img src="images/ql_CheckYourCreditScore.gif" alt="Check Your Credit Score" title="Check Your Credit Score" name="FCR" width="188" height="18" border="0"></a></td>
              </tr>-->  
              <tr>
                  <td height="1" colspan="3" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
               </tr>
            </table>
           
        <!-- </form>-->
<!-- End links content -->
