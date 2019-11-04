
<%@ page import="org.apache.log4j.Logger"%>

<%
	//Logger.getLogger("oasweb").debug("Enter header.jsp");
%>
<!-- Start header content -->                
	<tr>
		<td height="87" align="right" background="images/abcc_color_version_header.gif">
			<table width="100%" height="67"  border="0" cellpadding="0" cellspacing="4">
	          <tr>
	            <td align="right" valign="top">
	            	<span class="topnav">
	            <a href="https://cardcenter.appliedbank.com/aboutUs.jsp"  target="_blank" class="topnav">About Us</a> | 
	            <a href="https://cardcenter.appliedbank.com/siteMap.jsp"  target="_blank" class="topnav">Site Map</a> | 
	            <a href="https://cardcenter.appliedbank.com/contactUs.jsp"  target="_blank" class="topnav">Contact Us</a>&nbsp;
	            </span>
	            </td>
			  </tr>
	    <tr>
	    	<td align="right" valign="bottom">
	        	<table width="50%"  border="0" cellspacing="0" cellpadding="0">
	            <tr>
	            	<td align="right" valign="bottom">
					<form target="blank" id="cse-search-box" name="cse-search-box" action="https://content.appliedbank.com/acb/searchresults.html" autocomplete="nope">
						  <input type="hidden" name="cx" value="006280706724292160154:bxaww0gx_ly" />
						  <input type="hidden" name="cof" value="FORID:11" />
						  <input type="hidden" name="ie" value="UTF-8" />
						  <input type="text" id="searchText" autocomplete="nope"  name="q" size="25" />
						  <input type="button" onclick="searchSite();" name="sa" value="Search" height="25" />
						</form>
						</td>
	              </tr>
	            </table> </td>
	          </tr>
      		</table>
		</td>
	</tr>
	<tr>
	  <td height="23"><div align="right">
	        <script type="text/javascript" src="milonic_src.js"></script>	
          <script	type="text/javascript">
if(ns4)_d.write("<scr"+"ipt type=text/javascript src=mmenuns4.js><\/scr"+"ipt>");		
  else _d.write("<scr"+"ipt type=text/javascript src=mmenudom.js><\/scr"+"ipt>"); 
        </script>
          <script type="text/javascript" src="menu_data_home.js"></script>
        </div></td>
	</tr>
	<tr>
		<td height="7">
			<img src="images/newtop3_03.gif" width="750" height="7" alt=""></td>
	</tr>
	<tr>
		<td height="4"><img src="images/blank.gif" height="4"></td>
    </tr>
<!-- End header content -->  
<script language="JavaScript">

function launchMe()
{
	alert("Launch me was called!");
}

function searchSite()
{
	if(document.getElementById("cse-search-box") != null) {
		document.getElementById("cse-search-box").action = "https://content.appliedbank.com/acb/searchresults.html";
		document.getElementById("cse-search-box").submit();
	} else {
		var targetUrl = "https://content.appliedbank.com/acb/searchresults.html?";
		targetUrl += "cx=006280706724292160154%3Abxaww0gx_ly&cof=FORID%3A11&ie=UTF-8&";
		targetUrl += "q=" + document.getElementById("searchText").value;
		window.open(targetUrl);	
	}
}

</script>
<%
	//Logger.getLogger("oasweb").debug("Exit header.jsp");
%>