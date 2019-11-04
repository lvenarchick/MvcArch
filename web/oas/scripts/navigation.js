function submitNavigation (){
	var navLinks = document.getElementById("navg").value;
	
	if (navLinks== '-1'){
		//do nothing 
	}
	else
	{
		if ( /cardcenter/.test(navLinks))
		{
			window.open(navLinks);
		}
		else
		{
			var oForm = document.forms[0];
			oForm.action = navLinks;
			oForm.submit();
		}
	}
}