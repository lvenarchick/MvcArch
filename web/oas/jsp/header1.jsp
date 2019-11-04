<!-- Start header1 content -->
<tr>
	<td height="87" align="right" background="images/abcc_color_version_header.gif"><table width="100%" height="67" border="0" cellpadding="0" cellspacing="4">
			<tr>
				<td align="right" valign="top"><span class="topnav"> <a href="https://cardcenter.appliedbank.com/aboutUs.jsp" target="_blank" class="topnav">About Us</a> | <a href="https://cardcenter.appliedbank.com/siteMap.jsp" target="_blank" class="topnav">Site Map</a> | <a href="https://cardcenter.appliedbank.com/contactUs.jsp" target="_blank" class="topnav">Contact Us</a>&nbsp;
				</span></td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
					<table width="50%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right" valign="bottom">
								<form id="cse-search-box" name="cse-search-box" target="_blank" autocomplete="nope" action = "https://content.appliedbank.com/acb/searchresults.html">
									<input type="hidden" name="cx" value="006280706724292160154:bxaww0gx_ly" /> 
									<input type="hidden" name="cof" value="FORID:11" /> 
									<input type="hidden" name="ie" value="UTF-8" /> 
									<input type="text" autocomplete="nope" name="q" id="searchText" size="25" /> 
									<input type="button" onclick="searchSite();" name="sa" value="Search" height="25" />
								</form>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td height="23">
		<div align="right">
		<script>
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
			
			function submitMenuForm(action)
			{
				document.forms[0].action = action;
				document.forms[0].submit();
			}

		</script>
		<!-- <form id="menuForm" autocomplete="off" action="">-->
			<script type="text/javascript" src="milonic_src.js"></script>
			<script type="text/javascript">
				if(ns4)_d.write("<scr"+"ipt type=text/javascript src=mmenuns4.js><\/scr"+"ipt>");		
  				else _d.write("<scr"+"ipt type=text/javascript src=mmenudom.js><\/scr"+"ipt>"); 
        	</script>
			<script>
		_menuCloseDelay=500;
		_menuOpenDelay=150;
		_subOffsetTop=2;
		_subOffsetLeft=-2;

		with(AllImagesStyle=new mm_style()){
		styleid=1;
		bordercolor="#000000";
		borderstyle="solid";
		fontstyle="normal";
		fontweight="normal";
		padding=3;
		}

		with(menuStyle=new mm_style()){
		bordercolor="#ffffc6";
		borderstyle="solid";
		borderwidth=1;
		fontfamily="Arial, Helvetica";
		fontsize="8pt";
		fontstyle="normal";
		fontweight="bold";
		headerbgcolor="#ffffff";
		headercolor="#000000";
		offbgcolor="#ffe7c6";
		offcolor="#000000";
		onbgcolor="#EF6B00";
		oncolor="ffffff";
		padding=2;
		pagebgcolor="#EF6B00";
		pagecolor="#ffffff";
		separatorcolor="#ffffff";
		separatorsize=1;
		subimage="arrow.gif";
		subimagepadding=2;
		itemwidth="148"; 
		}

		with(milonic=new menuname("Main Menu")){
		alwaysvisible=1;
		orientation="horizontal";
		screenposition="center"
		style=AllImagesStyle;
		top=87;
		aI("image=dr-home.gif;overimage=dr-home-hover.gif;status=Home Page;url=javascript:submitMenuForm('accountSummary.do');");
		aI("image=manage.gif;overimage=manage-hover.gif;pageimage=manage-hover.gif;showmenu=myaccounts;status=My Account Information;");
		aI("image=cs.gif;overimage=cs-hover.gif;pageimage=cs-hover.gif;showmenu=cs;status=Customer Service");
		aI("image=payment.gif;overimage=payment-hover.gif;pageimage=payment-hover.gif;showmenu=Paymentpages;status=Payment Center");
		aI("image=products.gif;overimage=products-hover.gif;pageimage=products-hover.gif;showmenu=My milonic;status=Products");}
		with(milonic=new menuname("aa Samples")){
		overflow="scroll";
		style=menuStyle;
		aI("image=allimages.gif;overimage=allimages_on.gif;url=/menusample.php?sampleid=18;");
		aI("image=xpstyle.gif;overimage=xpstyle_on.gif;url=/menusample.php?sampleid=12;");
		aI("image=static.gif;overimage=static_on.gif;url=/menusample.php?sampleid=16;");
		aI("image=horizontal.gif;overimage=horizontal_on.gif;url=/menusample.php?sampleid=1;");
		}

		with(milonic=new menuname("myaccounts")){
		style=menuStyle;
		margin=2
		aI("text=Account Summary;status=Account Summary;url=javascript:submitMenuForm('accountSummary.do');");
		aI("text=Account History;status=Account History;url=javascript:submitMenuForm('accountHistory.do');");
		aI("text=Statements;status=Statements;url=javascript:submitMenuForm('statementsummary.do');");
		aI("text=Payment History;status=Payment History;url=javascript:submitMenuForm('paymentHistory.do');");
		}

		with(milonic=new menuname("Partners")){
		style=menuStyle;
		aI("status=(aq) Web Server Hosting & Services;text=(aq) Web Hosting;url=https://www.a-q.co.uk/;");
		aI("text=SMS 2 Email;url=https://www.sms2email.com/;");
		aI("text=WebSmith;url=http://www.softidiom.com/;");
		}

		with(milonic=new menuname("cs")){
		style=menuStyle;
		margin=2
		aI("text=Update Address/Phone;status=Update Address/Phone;url=javascript:submitMenuForm('displayContactInfo.do');");
		aI("text=Update Email Address;status=Update Email Address;url=javascript:submitMenuForm('displayEmail.do');");
		aI("text=Request a Pin;status=Request a Pin;url=javascript:submitMenuForm('displayRequestPIN.do');");
		aI("text=Change Online Password;status=Change Online Password;url=javascript:submitMenuForm('displayUpdatePassword.do');");
		aI("text=Update PicturePass;status=Update PicturePass &nbsp;<sup>SM</sup> &nbsp; and/or Questions;url=javascript:submitMenuForm('updatePass.do');");
		aI("text=Dispute a Charge;status=Dispute a Charge;url=javascript:submitMenuForm('displayRequestDispute.do');");
		aI("text=Contact Us;status=Contact Us;url=https://cardcenter.appliedbank.com/contactUs.jsp;target=_blank;");
		aI("text=Order Checks;status=Order Checks;url=javascript:submitMenuForm('displayRequestChecks.do');");
		}

		with(milonic=new menuname("deposit")){
		style=menuStyle;
		margin=2
		aI("text=Overview;status=Overview;url=https://cardcenter.appliedbank.com/depositOverview.jsp;target=_blank");
		aI("text=CD Rates;status=CD Rates;url=https://cardcenter.appliedbank.com/cdRates.jsp;target=_blank");
		aI("text=Money Market Rates;status=Money Market Rates;url=https://cardcenter.appliedbank.com/mmRates.jsp;target=_blank");
		aI("text=New Account Form;status=New Account Form;url=https://cardcenter.appliedbank.com/newAccountForm.jsp;target=_blank");
		aI("text=FAQ;status=FAQ;url=https://cardcenter.appliedbank.com/faq.jsp;target=_blank");
		}

		with(milonic=new menuname("My Milonic")){
		style=menuStyle;
		margin=2
		aI("text=Deposit Products;url=http://www.appliedbank.com;status=Deposit Products;text=Deposit Products;");
		aI("text=Applied Protection;status=Applied Protection;url=https://cardcenter.appliedbank.com/cap.jsp;target=_blank");
		aI("text=Payment Protection Plus;status=Payment Protection Plus;url=https://cardcenter.appliedbank.com/cap.jsp;target=_blank");
		aI("text=Applied Advantage;status=Applied Advantage;url=https://myappliedadvantage.appliedcard.com;target=_blank");
		aI("text=Special Offers;status=Special Offers;url=https://cardcenter.appliedbank.com/cli.jsp;target=_blank");
		aI("text=Credit Cards;status=Credit Cards;url=https://cardcenter.appliedbank.com/chooseCardToday.do;target=_blank");
		}
		with(milonic=new menuname("paymentpages")){
		style=menuStyle;
		margin=2
		aI("text=Pay Online Now;status=Pay Online Now;url=javascript:submitMenuForm('oaspay.do');");
		aI("text=Other Payment Options;status=Other Payment Options;url=https://cardcenter.appliedbank.com/otherPayment.jsp;target=_blank");
		aI("text=Payment History;status=Payment History;url=javascript:submitMenuForm('paymentHistory.do');");
		aI("text=Change Payment Due Date;status=Change Payment Due Date;url=javascript:submitMenuForm('displayChangeDueDate.do');");
		aI("text=Payoff Requests;status=Payoff Requests;url=javascript:submitMenuForm('displayPayoff.do');");
		}
		drawMenus();
		</script>
		<!-- <input type="hidden" name="pageGuid" value="${guid}">
		</form>-->
		</div>
	</td>
</tr>
<tr>
	<td height="7"><img src="images/newtop3_03.gif" width="750" height="7" alt=""></td>
</tr>
<tr>
	<td height="4"><img src="images/blank.gif" height="4"></td>
</tr>
<!-- End header1 content -->
