
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.Calendar" %>
<%
	//Logger.getLogger("oasweb").debug("Enter footer.jsp");
	response.setHeader("Cache-Control","no-cache"); // HTTP 1.1
	response.setHeader("Pragma","no-cache"); // HTTP 1.0
	response.setDateHeader ("Expires", -1); // Prevents caching at the proxy server
	response.addHeader("Strict-Transport-Security", "max-age=63072000; includeSubDomains; preload");
	response.addHeader("X-Frame-Options", "DENY");
	Calendar cal = Calendar.getInstance();
%>
<!-- Start footer content -->  
       	  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td height="10" colspan="2"><img src="images/blank.gif" width="1" height="1"></td>
               </tr>
               <tr>
                 <td valign="top"><img src="images/copyright_fdic.gif"  border="0" align="bottom"></td>
                 <td><div align="center">
                     <p>
					 	<a href="https://cardcenter.appliedbank.com/terms.jsp" target="_blank" class="exciting">Terms of Use</a> |
					 	<a href="https://cardcenter.appliedbank.com/privacy.jsp"  target="_blank" class="exciting">Privacy</a> |
						<a href="https://cardcenter.appliedbank.com/aboutUs.jsp"  target="_blank" class="exciting">About Us</a> | 
						<a href="https://cardcenter.appliedbank.com/contactUs.jsp"  target="_blank" class="exciting">Contact Us</a> | 
						<a href="https://cardcenter.appliedbank.com/siteMap.jsp"  target="_blank" class="exciting">Site Map</a>
					 <p>&copy; <%=cal.get(Calendar.YEAR) %><a href="https://cardcenter.appliedbank.com/home.do" class="footer" target="_blank"> Applied Bank</a></p>
                     <br>
                 </div></td>
               </tr>
           </table>
<!-- End footer content -->      		
<%
	//Logger.getLogger("oasweb").debug("Exit footer.jsp");
%>