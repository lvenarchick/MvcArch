<%@ page errorPage="jspErrorHandler.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.acs.oas.util.OASConstants"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@ page import="com.acs.oas.components.valueobject.*,
				 com.acs.oas.components.valueobject.CustomerInfoVO.AccountInfo"%>
<%@taglib prefix="oasjsp" uri="oas-taglib" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%

response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
response.addHeader("X-Frame-Options", "DENY");
	//Logger.getLogger("oasweb").debug("Enter changeChlgQuestionAndPicPass.jsp");
  	//Collection chlQuestionsData = (Collection) application.getAttribute("challengeQuestions");   
	
	CustomerInfoVO custInfo = (CustomerInfoVO) session.getAttribute(OASConstants.CUSTOMERINFO_VO);
    String accNumber = custInfo.getSelectedAccount();
   	List accList = custInfo.getAccountList();
	
	QuestionsAndPassChangeVO updatepassVO = (QuestionsAndPassChangeVO) session.getAttribute(OASConstants.UPDATEPASS_VO);
	String picName 		= null;
	String categoryName = null;
	String picPhrase 	= null;
	if (updatepassVO != null)
	{
		Logger.getLogger("oasweb").debug("Enter changeChlgQuestionAndPicPass.jsp,updatepassVO is NOT null");
		
		Boolean updatePassImage  = new Boolean (false);
		if (updatepassVO.getChangeImage() != null){
			updatePassImage = updatepassVO.getChangeImage();
		}
		picName 		= updatepassVO.getNewPassImageName();
		categoryName 	= picName.substring(0,2).toLowerCase();
		picPhrase 		= updatepassVO.getNewPhrase();
	}
	else
	{
			//Logger.getLogger("oasweb").debug("Enter changeChlgQuestionAndPicPass.jsp,updatepassVO is null");
			picName 		= (String) request.getAttribute("imageName");
			categoryName 	= picName.substring(0,2).toLowerCase();
			picPhrase 		= (String) request.getAttribute("picphrase");
	}
	
	// Replace double-quotes with HTML quote character code
	picPhrase 		= picPhrase.replaceAll("\"", "&quot;");
	ArrayList aList = (ArrayList) request.getAttribute("returnErrorMsgs");
	if(aList == null){
		aList =  new ArrayList();
	}
	
	/* SRF 2008 0486 PPP Open Enrollment*/
   	//get pppEligiblity VO for account# and expiration date - required for pre-populating pppEnrollmentPage
   	PPPEligiblityVO pppEligiblityVO =(PPPEligiblityVO)session.getAttribute(OASConstants.PPPELIGIBLE_VO);
   	if(pppEligiblityVO != null)
   	{
   		String pppEligibility = pppEligiblityVO.getEligibility().trim();
   		String pppAccountNumber = pppEligiblityVO.getAccountNumber().trim();
   		String pppExpDate	= pppEligiblityVO.getExpireDt().trim();
   		//Logger.getLogger("oas").debug("changeChlgQuestionAnswer.jsp::["+pppEligibility+"],["+pppAccountNumber+"],["+pppExpDate+"]");
   	}
%>
<html>
<title>Applied Bank's Online Account Services</title>
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
<script language="JavaScript" src="oas.js"></script>
<script language="JavaScript" src="navigation.js"></script>
<script language="JavaScript" src="DisableRightClick.js"></script>
<script language="JavaScript">disablerightclick()</script>
<script language="JavaScript">
function SubmitSearch()
{
	if (document.forms[1].searchText.value != "")
	{
		window.location.href = "search.do?searchText=" + document.forms[1].searchText.value;
	}
}

function changePicture(){
	document.getElementById("reviewChangeForm").picchange.value= "true";
	document.getElementById("reviewChangeForm").submit();
}

function logoff()
{
	document.getElementById("reviewChangeForm").action="logoff.do";
	document.getElementById("reviewChangeForm").submit();
}

function accountSummary()
{
	document.getElementById("reviewChangeForm").action="accountSummary.do";
	document.getElementById("reviewChangeForm").submit();
}

function submitPPPEnrollment()
{
	document.getElementById("reviewChangeForm").action="pppEnrollmentInt.do";
	document.getElementById("reviewChangeForm").submit();
}

function doPayOnlineNow()
{
	document.getElementById("reviewChangeForm").action="oaspay.do";
	document.getElementById("reviewChangeForm").submit();
}

function doCustomerService()
{
	document.getElementById("reviewChangeForm").action="customerService.do";
	document.getElementById("reviewChangeForm").submit();
}
</script>
<link href="css/styles.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="MM_preloadImages('images/2ql_payment-hover.gif','images/2ql_account_security-hover.gif','images/2ql_faq-hover.gif','images/2ql_credit-hover.gif','images/ql_cs-hover.gif','images/buttons/search-h.gif','images/buttons/download_trans-h.gif','images/buttons/go-h.gif','images/online_account-hover.gif')" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<script language="javascript" src="wz_tooltip.js"></script>
<script language="javascript" src="tip_balloon.js"></script>
<center>
<form action="reviewChangePass.do" name="reviewChangeForm" id="reviewChangeForm" autocomplete="nope" method="post">
<table id="Table_01" width="750" height="276" border="0" cellpadding="0" cellspacing="0">
	<%@ include file="header1.jsp" %>
	<tr>
		<td valign="top"><table width="100%"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="74%" valign="top"><TABLE width=544 border=0 cellpadding="0" cellspacing="0">
              <TBODY>
                <TR>
                  <TD width="37%" valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="60%" valign="top">
                            <h1>Update PicturePass<span class="smText">SM</span> and PicturePhrase<span class="smText">SM</span></h1>
                          </td>
                      <td width="40%" valign="top"><div align="right"> <a onClick="logoff();" class="logoff acslink"><strong>Sign Out</strong></a> </div></td>
                    </tr>
                    <tr>
                      <td height="5" colspan="2" valign="top"><img src="images/blank.gif" width="1" height="1"></td>
                    </tr>
                     <tr>
                        <td valign="top"><div align="left"><span class="warning"><strong><span class="data"><strong>
        
						<c:choose>
							<c:when test="${fn:length(CustomerInfoVO.accountList) == 1}">
								<c:out value="${CustomerInfoVO.accountList[0].formattedAccountNumber}"/>
							</c:when>
							<c:otherwise>
								<select name="AccountList" class="note" onChange="accountSummary();">
									<c:forEach items="${CustomerInfoVO.accountList}" var="account" varStatus="loop">
										<option value="${loop.index}" ${account.accountNumber eq CustomerInfoVO.selectedAccount ? 'selected' : ''} >${account.formattedAccountNumber}</option>
									</c:forEach>
								</select>		
								</strong>
								</span>
								<strong><strong> &nbsp;</strong></strong>(select another AB account)</strong>							
							</c:otherwise>
						</c:choose>
                      </span></div></td>
                      <td valign="top"><div class="excitinghead" align="right">
                           <%@ include file="navigation.jsp" %>
                      </div></td>
                    </tr>
                  </table></TD>
                </TR>
                <!--<tr>
                  <td height="3" valign="top" bgcolor="#CCCCCC"><img src="images/blank.gif" width="1" height="1"></td>
                </tr>-->
                <tr>
                  <td height="5" valign="top"><img src="images/blank.gif" width="1" height="1">
				  <%
			  	 	if (aList!=null && aList.size()>0){
				
				  %>
					  <p align="center"><img src="images/alert.gif" width="25" height="25">
					 <span class="formtextred">Please correct the error(s) listed below.</span></p>
				  <%
				  		for (int i=0; i<aList.size(); ++i) {
					      String errorMsg = (String)aList.get(i);
				   %>
					
					<p align="center" class="formtextred">
					<%=errorMsg%>
					</p>
				   <%
				        }
					%>
				 <br>
				 <%	
					} 
				  %>
				  </td>
                </tr>
                <tr>
                  <td height="20" valign="top">
           				  
                    <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td height="1" valign="top" colspan="2" ><img src="images/blank.gif" width="1" height="1"> 
                        </td>
                      </tr>
                      
                        <tr> 
                          <td height="25" colspan="2" class="data">You selected 
                            this image as your PicturePass and PicturePhrase. 
                            To change your PicturePass, click the image and select 
                            a new one. To change your PicturePhrase, simply enter 
                            the text below. Once you have selected your new PicturePass 
                            and PicturePhrase click update. </td>
                        </tr>
                        <tr class="data"> 
                          <td height="10" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
                        </tr>
                        <tr> 
                          <td colspan="2"> 
                            <table>
                              <tr> 
                                <td height="61" valign="top"> <span class="red">*</span><span class="formtext">Your 
                                  PicturePhrase:</span> 
                                  <input name="phrase" type="text" autocomplete="nope"  class="data" id="phrase" value="<%=picPhrase%>" size="30" maxlength="30">
                                  <span class="excitingred"> </span>
                                </td>
                                <input name="picturename" type="Hidden" value="<%=picName%>">
	                            <td width="38%" rowspan="2" align="center" valign="top"> 
		                            <img src="https://content.appliedbank.com/oas/images/picturepass/<%=categoryName%>/<%=picName%>" name="<%=picName%>" width="120" height="110" hspace="8" vspace="0" border="2" class="border acslink" onclick="changePicture()">
		                            <p><span class="formtextred acslink" onclick="changePicture()">Click here</span> to change<br><br></p>
	                            </td>
                              <tr> 
                                <td height="40" valign="top" nowrap>&nbsp; </td>
                            </table>
                          </td>
                        </tr>
                        <tr class="data"> 
                          <td height="20"> 
                            <div align="center"> </div>
                          </td>
                          <td height="20"> 
                            <input type="image" src="images/buttons/update.gif" name="Image43" id="Image35" width="72" height="20" border="0" onMouseUp="MM_swapImgRestore()" onMouseDown="MM_swapImage('Image42','','images/buttons/update-h.gif',1)" >
                          </td>
                        </tr>
                        <tr class="data"> 
                        <td height="20" colspan="2"> 
                     	<%@ include file="footer.jsp" %>
                        </td>
                      </tr>
                    </table>                  
                  </td>
                </tr>
               </TBODY>
            </TABLE></td>
              <td width="26%" align="right" valign="top"> 
                <!-- Start welcome box content -->
                <%@ include file="welcome.jsp" %>
                <!-- End welcome box content -->
                <!-- Start Quick Links Content -->
                <%@ include file="links1.jsp" %>
                <!-- End Quick Links Content -->
                <!-- 2008 0486 PPP Enrollment image start -->
                    <% 
                     if (pppEligiblityVO.getEligibility().trim().equals("eligible"))
                      {
                     %>
	                     <TABLE align=center>
				         	<TR>
				         		<TD>
				         			<a onClick="submitPPPEnrollment();" class="acslink" onmouseover="Tip('<b>Protect Yourself and Your Family!<\/b><br> With Payment Protection Plus you may have your minimum monthly payments made for you during difficult times such as Disability, Hospitalization, and Unemployment. Click here to learn more.',
		         																	BALLOON, true, WIDTH ,'220',   ABOVE, true,  OFFSETX, -17)" onmouseout="UnTip()"> <img src="images/PPP-Logo.gif" border="0"></a>
				         		</TD>	         	
				         	</TR>	         	
				         </TABLE>
			          <%
			           }
			         %>
          		<!-- 2008 0486 PPP Enrollment image end -->
              </td>
          </tr>
        </table></td>
	</tr>
</table>
<input type="hidden" name="picchange" value="">
<input type="hidden" name="pageGuid" value="${guid}">
</form>
</center>
</body>
</html>