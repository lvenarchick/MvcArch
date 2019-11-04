<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Collection"%>
<%@ taglib uri="dyn-taglib" prefix="dynjsp"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%
	//Logger.getLogger("oasweb").debug("Enter agreement.jsp");

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	
%>
<html>
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
<link href="css/styles.css" rel="stylesheet" type="text/css">
<script language="JavaScript">
function doPayOnlineNow()
{
	document.getElementById("agreementForm").action="oaspay.do";
	document.getElementById("agreementForm").submit();
}

function doCustomerService()
{
	document.getElementById("agreementForm").action="customerService.do";
	document.getElementById("agreementForm").submit();
}
</script>
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<center>
<form autocomplete="nope" name="agreementForm" id="agreementForm" method="POST" >
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header1.jsp" %>
	<tr>
		<td height="4"><img src="images/blank.gif" height="4"></td>
    <tr>
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>
                  <TD valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="1">
                    <tr>
                      <td width="88%" valign="top"><h1>Applied Bank On-Line Account Services Agreement </h1></td>
                      <td width="12%" valign="top">&nbsp;&nbsp;</td>
                    </tr>
                    <tr>
                      <td height="10" colspan="2" valign="top"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
                    <tr>
                      <td colspan="2" valign="top"><p>We suggest you read this document carefully and print a copy for your reference. You may refer back to it at any time by accessing the Online Account Agreement button located in the Quick Links section within the Web site.
                        </p>
                        <h2>General Terms Applicable To All Users</h2>
                        <p> In addition to the Terms of Use that govern this Web site, this Online Service Agreement (&ldquo;Agreement&rdquo;) states the terms and conditions that govern your use of Applied Bank Online Account Services (the &ldquo;Online Service&rdquo;). As used herein, the terms &quot;Bank&quot;, &quot;us,&quot; &quot;we,&quot; or &quot;our&quot; means Applied Bank, or the affiliate of such entity that holds your accounts or provides you services and any agent, independent contractor, designee, or assignee the we may, at our sole discretion, involve in the provision of the Online Service; &quot;you&quot; or &quot;your&quot; means (1) an individual that is the owner of an account or or (2) an individual authorized by an account owner to view account information and/or effect transactions in an account; and &quot;Card&quot; refers to the credit card issued by us. </p>
                        <h2>Agreement; Online Service</h2>
                        <p> When you use or access, or permit any other person(s) or entity to use or access the Online Service, you agree to the terms and conditions of this Agreement. We may amend or change this Agreement (including applicable fees and service charges) from time to time, in our sole discretion, by sending you written notice by electronic mail or by regular mail or by posting the updated terms on the sites within the Online Service (the &quot;Site(s)&quot;). Please access and review this Agreement regularly. If you find the Agreement unacceptable to you at any time, please discontinue your use of the Online Service. Your use of the Online Service after we have made such changes available will be considered your agreement to the change. </p>
                        <p>The Online Service is an online financial services Web site offering a variety of content, products and services. We grant to you, for your personal purposes only, a nonexclusive, limited and revocable right to access and use the Online Service. You agree not to use the Online Service for any other purpose, including commercial purposes, such as co-branding, framing linking, or reselling any portion of the Online Service without our prior written consent. </p>
                        <h2>Computer Equipment; Browser Access and Internet Services
                          Installation, Maintenance and Operation of Equipment</h2>
                        <p> You are responsible for obtaining, installing, maintaining and operating all equipment necessary for you to access the Online Service, in accordance with such requirements as may be (i) provided by the equipment manufacturers and (ii) any other documentation we provide to you in connection with your accounts and services. You agree that you will utilize a reputable antivirus software program on your equipment and that you will update such antivirus software periodically in accordance with a commercially reasonable schedule. We are not responsible for any errors or problems that arise from the malfunction or failure of your equipment. </p>
                        <h2>Browser Access and Internet Services</h2>
                        <p> By utilizing an encrypted browser, you may access the Online Service. You are responsible for obtaining a browser capable of a sufficiently high level of encryption to meet the systems requirements we establish from time to time. If we make browser software available to you, you may use such browser or any other browser of your choice to access the Online Service via the Internet so long as it meets our encryption standards. You acknowledge that we are not responsible for notifying you of any upgrades, fixes, or enhancements to, or for providing technical or other support for, any browser or for any compromise of data transmitted across computer networks or telecommunications facilities, including, but not limited to, the Internet. Although we may make browser software available to you or facilitate a link to a third party site where you may download such browser software, we make no endorsement of any specific browser software. Your use of any browser may also be subject to the license agreements of the browser manufacturer, in addition to the terms and conditions of this Agreement. </p>
                        <p>You are additionally responsible for obtaining Internet services via the Internet service provider of your choice, for any and all fees imposed by such Internet service provider and any associated communications service provider charges. You acknowledge that there are certain security, corruption, transmission error, and access availability risks associated with using open networks such as the Internet and you hereby expressly assume such risks (to the extent the law allows you to do so). You acknowledge that you have requested the service for your convenience, have made your own independent assessment of the adequacy of the Internet as a delivery mechanism for accessing information and initiating instructions and that you are satisfied with that assessment. We are not responsible for any Internet access services. </p>
                        <h2>Passwords</h2>
                        <p> We may at our option change the parameters for the password used to access the Online Service (&ldquo;Password&rdquo;) without prior notice to you, and if we do so, you will be required to change your password the next time you access the Online Service. To prevent unauthorized access to your accounts and to prevent unauthorized use of the Online Service, you agree to protect and keep confidential your Card number, account number, PIN, User ID, Password, or other means of accessing your accounts via the Online Service. The loss, theft, or unauthorized use of your Card numbers, account numbers, PINs, User IDs, and Passwords could cause unauthorized draws on your credit card account. It could also permit unauthorized persons to gain access to your sensitive personal and account information and to use that information for fraudulent purposes, including identity theft. If you disclose your Card numbers, account numbers, PINs, User IDs, and/or Passwords to any person(s) or entity, you assume all risks and losses associated with such disclosure. If you permit any other person(s) or entity to use the Online Service or to access or use your Card numbers, account numbers, PINs, User IDs, Passwords, or other means to access your accounts, you are responsible for any transactions and activities performed from your accounts and for any use of your personal and account information by such person(s) or entity. If you believe someone may attempt to use or has used the Online Service without your permission, or that any other unauthorized use or security breach has occurred, you agree to immediately notify us at ___________________. </p>
                        <h2>Notices</h2>
                        <p> You agree that by using the Online Service, all notices or other communications which we may be required to give you arising from our obligations under this Agreement or the Online Service may be sent to you electronically to any e-mail address we have for you, or at our option, another e-mail address you provide to us or in any other manner permitted by law. </p>
                        <h2>New Features</h2>
                        <p> We may, from time to time, introduce new features to the Online Service or modify or delete existing features in our sole discretion. We shall notify you of any of these changes to features if we are legally required to do so. By using any new or modified features when they become available, you agree to be bound by the rules concerning these features. </p>
                        <h2>Online Service Fees</h2>
                        <p> General access to the Online Service is currently provided to you at no additional cost. However, you may incur fees if you use or obtain some of the products or services available through the Online Service. To learn more about such fees, please refer to the specific terms and conditions applicable to each product or service. We reserve the right from time to time to add or modify charges and will notify you when we do so. </p>
                        <h2>Limitation of Liability; No Warranties</h2>
                        <p> EXCEPT AS SPECIFICALLY SET FORTH HEREIN OR WHERE THE LAW REQUIRES A DIFFERENT STANDARD, WE SHALL NOT BE RESPONSIBLE FOR ANY LOSS, DAMAGE OR INJURY OR FOR ANY DIRECT, INDIRECT, SPECIAL, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING FROM OR RELATED TO THE EQUIPMENT, BROWSER AND/OR THE INSTALLATION OR MAINTENANCE THEREOF, ACCESS TO OR USE OF THE ONLINE SERVICE, FAILURE OF ELECTRONIC OR MECHANICAL EQUIPMENT OR COMMUNICATION LINES, TELEPHONE OR OTHER INTERCONNECT PROBLEMS, BUGS, ERRORS, CONFIGURATION PROBLEMS OR INCOMPATIBILITY OF COMPUTER HARDWARE OR SOFTWARE, FAILURE OR UNAVAILABILITY OF INTERNET ACCESS, PROBLEMS WITH INTERNET SERVICE PROVIDERS, PROBLEMS OR DELAYS WITH INTERMEDIATE COMPUTER OR COMMUNICATIONS NETWORKS OR FACILITIES, PROBLEMS WITH DATA TRANSMISSION FACILITIES OR ANY OTHER PROBLEMS YOU EXPERIENCE DUE TO CAUSES BEYOND OUR CONTROL. EXCEPT AS OTHERWISE EXPRESSLY PROVIDED IN ANY APPLICABLE AGREEMENT, YOU UNDERSTAND AND AGREE THAT YOUR USE OF THE ONLINE SERVICE IS AT YOUR SOLE RISK AND THAT THE ONLINE SERVICE AND ALL INFORMATION, PRODUCTS AND OTHER CONTENT (INCLUDING THIRD PARTY INFORMATION, PRODUCTS AND CONTENT) INCLUDED IN OR ACCESSIBLE FROM THE SITES, ARE PROVIDED ON AN &quot;AS IS&quot; &quot;WHERE-IS&quot; AND &quot;WHERE AVAILABLE&quot; BASIS, AND ARE SUBJECT TO CHANGE AT ANY TIME WITHOUT NOTICE TO YOU. YOU ACKNOWLEDGE THAT WE MAKE NO WARRANTY THAT THE ONLINE SERVICE WILL BE UNINTERRUPTED, TIMELY, SECURE OR ERROR-FREE UNLESS OTHERWISE STATED ON THE SITE OR IN ANY APPLICABLE AGREEMENT. TO THE FULLEST EXTENT PERMITTED BY LAW, WE DISCLAIM ALL REPRESENTATIONS, WARRANTIES AND CONDITIONS OF ANY KIND (EXPRESS, IMPLIED, STATUTORY OR OTHERWISE, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT OF PROPRIETARY RIGHTS) AS TO THE ONLINE SERVICE AND ALL INFORMATION, PRODUCTS AND OTHER CONTENT (INCLUDING THIRD PARTY INFORMATION, PRODUCTS AND CONTENT) INCLUDED IN OR ACCESSIBLE FROM THE SITES. NO LICENSE TO YOU IS IMPLIED IN THESE DISCLAIMERS. </p>
                        <h2>Other Agreements</h2>
                        <p> In addition to this Agreement, you agree to be bound by and comply with such other written requirements as we may furnish to you in connection with either this service or products which may be accessed via this service, including, but not limited to, all account agreements, and with all applicable State and Federal laws and regulations. In the event of a conflict between the terms of this Agreement and your applicable account agreements with us, the terms of your account agreement will control except as may be otherwise stated herein.</p>
                        <h2>Termination; Availability </h2>
                        <p> We may terminate or suspend this Agreement, or terminate, suspend or limit your access privileges to the Online Service, in whole or part, at any time for any reason without prior notice. The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this Agreement for all purposes. </p>
                        <p>Not all of the products or services described on the Site(s) are available in all geographic areas. Therefore, you may not be eligible for all the products or services described. We reserve the right to determine your eligibility for any product or service. </p>
                        <h2>Disputes</h2>
                        <p> In the event of a dispute arising under or relating in any way to this Agreement or to the Online Service provided under this Agreement, you and we agree to resolve this dispute by looking to the terms of this Agreement. If there is a conflict between what one of our employees says and the terms of this Agreement, the terms of this Agreement shall control. </p>
                        <h2>Arbitration </h2>
                        <p> YOU HEREBY AGREE THAT ANY DISPUTE, CLAIM OR CONTROVERSY ARISING NOW OR IN THE FUTURE UNDER OR RELATING IN ANY WAY TO THIS AGREEMENT, OR TO THE ONLINE SERVICE (&ldquo;CLAIM&rdquo;), REGARDLESS OF THE NATURE OF THE CAUSE(S) OF ACTION ASSERTED (INCLUDING CLAIMS FOR INJUNCTIVE, DECLARATORY, OR EQUITABLE RELIEF), SHALL BE RESOLVED BY BINDING ARBITRATION UNDER THE TERMS SET FORTH IN THE AGREEMENT GOVERNING YOUR ACCOUNT RELATIONSHIP WITH APPLIED BANK.</p>
                        <h2>Indemnity </h2>
                        <p> You acknowledge and agree that you are personally responsible for your conduct while using the Online Service and agree to indemnify and hold us and our officers, directors, employees and agents harmless from and against any loss, damage, liability, cost or expense of any kind (including, but not limited to, reasonable attorneys' fees) that we may incur in connection with a third party claim or otherwise, in relation to your use of the Online Service or the use of the Online Service by anyone using your Card number, account number, PIN, User ID or Password or your violation of this Agreement or the rights of any third party (including, but not limited to, privacy rights). Your obligations under this paragraph shall survive termination of this Agreement. </p>
                        <h2>Records; Communications</h2>
                        <p> Our records, kept in the regular course of business, shall be presumed to accurately reflect the contents of your instructions to us and, in the absence of manifest error, will be binding and conclusive. </p>
                        <p>Unless otherwise prohibited by law, any communication or material you transmit to us via the Applied Bank Web site or e-mail is on a non-confidential basis and we may use such communication or material for any purpose consistent with our Privacy Policy, including reproduction, publication, broadcast and posting. You agree to provide a valid phone number, e-mail address or other delivery location so that we may send you information about your applicable account. Any notice of a changed phone number, e-mail address or delivery location provided in response to an attempt to contact you at phone number, e-mail address or delivery location provided by you will be deemed to be a phone number, e-mail address or delivery location provided by you. You agree that we may send information to your e-mail address that contains information about your account, including information about the status of your applicable account. Additionally, you agree to indemnify, defend and hold us harmless from and against any and all claims, losses, liability, cost and expenses (including reasonable attorneys&rsquo; fees) arising from your provision of a phone number, e-mail address, or other delivery location that is not your own, for any access to information transmitted to you via a phone number, e-mail address, or other delivery location that is accessed by a third party or your violation of applicable federal, state or local law, regulation or ordinance. Your obligation under this paragraph shall survive termination of the Agreement. Account notices are provided for your convenience and do not replace your monthly account statement(s), which are the official record of your accounts. You understand information sent to any e-mail address you provide may not be encrypted and may include personal or confidential information about you such as your name and account activity or status. Receipt of each Alert may be delayed or impacted by factor(s) pertaining to your Internet service provider(s), phone carriers, or other parties. We will not be liable for (a) losses or damages arising from any non-delivery, delayed delivery, or misdirected delivery of the Alerts, or (b) inaccurate content in the Alerts</p>
                        <h2>Risk Of Loss </h2>
                        <p> In the event of a system failure or interruption, your data may be lost or destroyed. Any transaction(s) that you initiated, were in the process of completing, or completed shortly before a system failure or interruption should be verified by you through means other than online to ensure the accuracy and completeness of such transaction(s). You assume the risk of loss of your data during any system failure or interruption and the responsibility to verify the accuracy and completeness of any transaction(s) so affected. </p>
                        <h2>Account Information </h2>
                        <p> Account information provided to you as part of the Online Service is not the official record of your account or its activity. Your account statement, furnished to you by us in a paper format will remain the official record. The Online Service information is generally updated regularly, but is subject to adjustment and correction and therefore should not be relied upon by you for taking, or forbearing to take, any action.</p>
                        <p>This Applied Bank On-Line Account Services Agreement was last updated October 1, 2005. Please check back periodically for updates and changes.</p>
                        <p></p></td>
                      </tr>
                  </table></TD>
                </TR>
                <TR>
                  <TD valign="top">
				  <%@ include file="footer.jsp" %>                  
                    <p align="center">&nbsp;                    </p>
                    <p><br>
                    </p>
                    <p></p></TD>
                </TR>
              </TBODY>
            </TABLE></td>
            <td width="26%" align="right" valign="top">
			 <!-- Start Quick Links Content -->
           <%@ include file="links1.jsp" %>
			<!-- End Quick Links Content -->
              <table width="190" border="0" cellpadding="0" cellspacing="0">
                <tr bgcolor="#FFFFFF">
                  <td height="5" colspan="4" class="ql_header"><img src="images/blank.gif"></td>
                </tr>
                <tr bgcolor="096599">
                  <td height="25" colspan="4" class="ql_header"><div align="center"><img src="images/excite.gif" width="175" height="30"></div></td>
                </tr>
                <tr>
                  <td width="1" rowspan="4" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
                  <td height="2" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                  <td width="1" rowspan="4" bgcolor="#999999"><img src="images/blank.gif" width="1" height="1"></td>
                </tr>
                <tr>
                  <td height="5"><img src="images/blank.gif" width="1" height="5"></td>
                </tr>
                <tr>
                  <td>
				  <!-- Start Dynamic Content -->
					<dynjsp:DynamicContent  page="SPECOFFER" pageLocation="a1"/>                      
	                <!-- End Dynamic Content -->
					  </td>
                </tr>
                <tr>
                  <td height="1" colspan="3" bgcolor="#999999"><img src="images/blank.gif"></td>
                </tr>
              </table>
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
	//Logger.getLogger("oasweb").debug("Exit agreement.jsp");
%>