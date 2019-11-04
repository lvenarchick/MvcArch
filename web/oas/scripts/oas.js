var button;
function setBtn(btn)
{
	button = btn;
}
function disableBtn()
{
	button.disabled = true;
}
function enableBtn()
{
	button.disabled = false;
}

function submitEnrollForm(){
	 		    
       	if (document.enrollForm.ccnum.value == "" || document.enrollForm.ccnum.value.length < 16) {
            alert("Enter Credit Card Number.");
            document.enrollForm.ccnum.focus();
            return false;
        }
		if (document.enrollForm.last4ssn.value == "" || document.enrollForm.last4ssn.value.length < 4) {
            alert("Enter Last 4 digits of Social Security Number.");
            document.enrollForm.last4ssn.focus();
            return false;
        }
		var month =  enrollForm.dobMonth.options[enrollForm.dobMonth.selectedIndex].value;
		if(month=='-1'){
			alert("Please select month.");
          
            return false;
		
		}
		var dobdate =  enrollForm.dobDate.options[enrollForm.dobDate.selectedIndex].value;
		if(dobdate=='-1'){
			alert("Please select date.");
            
            return false;
		
		}
		var year =  enrollForm.dobYear.options[enrollForm.dobYear.selectedIndex].value;
		
		if(year=='-1'){
			alert("Please select year.");
			
             return false;
		
		}
		
		var username	=	document.enrollForm.userId.value;
		var	usernameReturn = checkUsername (username);
		if (usernameReturn!=null && usernameReturn!=""){
			alert(usernameReturn);
			document.enrollForm.userId.focus();
			return false;
		}
		
		var password = document.enrollForm.password.value;
		var	passwordReturn = checkPassword (password);
		if (passwordReturn!=null && passwordReturn !=""){
			alert(passwordReturn);
			document.enrollForm.password.focus();
			return false;
		}
		
		var password2 = document.enrollForm.confirmPassword.value;
		var	passwordReturn2 = checkPassword (password2);
		if (passwordReturn2!=null && passwordReturn2 !=""){
			alert("Confirm Password Error.\n"+passwordReturn2);
			document.enrollForm.confirmPassword.focus();
			return false;
		}
	
		if (password != password2){
			alert("You did not enter the same new password twice. Please re-enter your password.");
			//document.enrollForm.confirmEmail.focus();
			return false;
		}
		disableBtn();
		return true;

}


function checkEmail (strng) { 
	var error=""; 
	if (strng == "") { 
	  error = "Enter an email address.\n"; 
	} 
	
	   var emailFilter=/^.+@.+\..{2,3}$/; 
	   if (!(emailFilter.test(strng))) { 
	      error = "Please enter a valid email address.\n"; 
	   } 
	   else { 
	//test email for illegal characters 
	      var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ 
	        if (strng.match(illegalChars)) { 
	         error = "The email address contains illegal characters.\n"; 
	      } 
	   } 
	return error; 
} 

// password - between 6-16 chars, uppercase, lowercase, and numeral 

function checkPassword (strng) { 
	var error = ""; 
	var illegalChars = /[\W_]g/; // allow only letters and numbers 
		  // else if (!(((strng.search(/(a-z)+/)) || (strng.search(/(A-Z)+/))) && (strng.search(/(0-9)+/)))) { 
	    //  error = "The password must contain at least one uppercase letter, one lowercase letter, and one numeral.\n"; 
	 //  }
	   
	var re = /^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@!#$%^&*\[\]\-+_\.\|,=/?]).*$/;
	   //var re = /^\w*(?=\w*\d)(?=\w*[a-z])(?=\w*[A-Z])\w*$/
	    //var re = /^\w*(?=\w*\d)(?=\w*[a-zA-Z]\w*$)/
	    
	if (strng == "") { 
	  error = "Enter a password.\n"; 
	} else  if ((strng.length < 8) || (strng.length > 16)) { 
	      error = "The password is the wrong length.\n"; 
	   } 
//	   else if (illegalChars.test(strng)) { 
//	     error = "The password contains illegal characters.\n"; 
//	   }
	   else if (!re.test(strng)) { 
		   error = "The password must contain at least one uppercase letter, one lowercase letter, and at least one special character.\n";
		}
 
	return error; 
} 


// username - 6-16 chars, uc, lc, and underscore only. 

function checkUsername (strng) { 
	var error = ""; 
    var illegalChars = /\W/g; // allow letters, numbers, and underscores 
	if (strng == "") { 
	  error = "Enter a username.\n"; 
	} else if ((strng.length < 6) || (strng.length > 16)) { 
	      error = "The username is the wrong length.\n"; 
	   } 
	   else if (illegalChars.test(strng)) { 
	   		error = "The username contains illegal characters.\n"; 
	   } 
	return error; 

} 

function submitUpdatePassForm(){

	var cpassword = document.updatePassForm.currentPassword.value;
		if (cpassword == "" || cpassword ==null){
			alert("Enter Current Password.");
			document.updatePassForm.currentPassword.focus();
			return false;
		}
		
	var cpasswordErr = checkPassword (cpassword);
	if (cpasswordErr != null && cpasswordErr != ""){
		alert("Current Password: " + cpasswordErr);
		document.updatePassForm.confirmPassword.focus();
		return  false;
	}
		
	var password = document.updatePassForm.newPassword.value;
		var	passwordReturn = checkPassword (password);
		if (passwordReturn!=null && passwordReturn !=""){
			alert(passwordReturn);
			document.updatePassForm.newPassword.focus();
			return  false;
		}
		
		var password2 = document.updatePassForm.confirmPassword.value;
		var	passwordReturn2 = checkPassword (password2);
		if (passwordReturn2!=null && passwordReturn2 !=""){
			alert(passwordReturn2);
			document.updatePassForm.confirmPassword.focus();
			return  false;
		}
		
		if (password == cpassword ){
			alert("New password can not be same as current password. Please re-enter your password.");
			//document.enrollForm.confirmEmail.focus();
			return  false;
		}
		
		if (password != password2){
			alert("You did not enter the same new password twice. Please re-enter your password.");
			//document.enrollForm.confirmEmail.focus();
			return  false;
		}
		
		return true;
	
}

var phone_field_length=0;
function TabNext(obj,event,len,next_field) {
	if (event == "down") {
		phone_field_length=obj.value.length;
		}
	else if (event == "up") {
		if (obj.value.length != phone_field_length) {
			phone_field_length=obj.value.length;
			if (phone_field_length == len) {
				next_field.focus();
				}
			}
		}
	}

function setCCNum(){
	var cardNum = this.document.enrollForm.ccnum.value;
	this.document.enrollForm.ccnum1.value = cardNum;
	//alert(this.document.enrollForm.ccnum1.value);
	this.document.enrollForm.ccnum.value = "****************";
}



function submitResetPassForm(){
		
	 if (document.forms[0].last4ssn.value == "") {
            alert("Enter Last 4 digits of Social Security Number.");
            document.forms[0].last4ssn.focus();
             return false;
        }
     if (document.forms[0].ccnum.value == "") {
          alert("Enter Credit Card Number.");
          document.forms[0].ccnum.focus();
       return false;
     }
	 
	 var month =  document.forms[0].dobMonth.options[document.forms[0].dobMonth.selectedIndex].value;
		if(month=='-1'){
			alert("Please select month.");
          
            return false;
		
		}
		var dobdate =  document.forms[0].dobDate.options[document.forms[0].dobDate.selectedIndex].value;
		if(dobdate=='-1'){
			alert("Please select date.");
            
            return false;
		
		}
		var year =  document.forms[0].dobYear.options[document.forms[0].dobYear.selectedIndex].value;
		
		if(year=='-1'){
			alert("Please select year.");
			
             return false;
		
		}
	 var password = document.forms[0].password.value;
		var	passwordReturn = checkPassword (password);
		if (passwordReturn!=null && passwordReturn !=""){
			alert(passwordReturn);
			document.forms[0].password.focus();
			 return false;
		}
		
		var password2 = document.forms[0].confirmPassword.value;
		var	passwordReturn2 = checkPassword (password2);
		if (passwordReturn2!=null && passwordReturn2 !=""){
			alert(passwordReturn2);
			document.forms[0].confirmPassword.focus();
			 return false;
		}
		
		if (password != password2){
			alert("You did not enter the same new password twice. Please re-enter your password.");
			//document.enrollForm.confirmEmail.focus();
			 return false;
		}
	
	return true;
}

function validateAcceptLostForm(){
		
	if(document.forms[0].custfname.value == ''){
		alert("Enter First Name");
		document.forms[0].custfname.focus();
		 return false;
	}
	else if(document.forms[0].custlname.value == ''){
		alert("Enter Last Name");
		document.forms[0].custlname.focus();
		 return false;
	}
	else if(document.forms[0].custsocial1.value == ''){
		alert("Enter Social Security Number");
		document.forms[0].custsocial1.focus();
		 return false;
	}
	else if(document.forms[0].custsocial2.value == ''){
		alert("Enter Social Security Number");
		document.forms[0].custsocial2.focus();
		 return false;
	}
	else if(document.forms[0].custsocial3.value == ''){
		alert("Enter Social Security Number");
		document.forms[0].custsocial3.focus();
		 return false;
	}
	
	return true;
}

function validateAppStatusForm()
{
	
     var lname  = document.appStatusForm.lastName.value;
     var s1 = document.appStatusForm.ss1.value;
     var s2 = document.appStatusForm.ss2.value;
     var s3 = document.appStatusForm.ss3.value;
     var errMsg = "";
     if (lname == '')
     {
     	alert("Please enter last name as entered in the application.");
		document.appStatusForm.lastName.focus();
		return false;
     }
     
     else if ((s1 == '') || (s2 == '') || (s3 == ''))
     {
          alert("Please enter Social Security Number.");
		  return false;
          
     }
    
     return true;
     
}

function submitLoginForm() {
	var frm = document.loginForm;
	var username= frm.username.value;
		
	if( username == null || username==""  ) { 
		alert("Please enter username");
		frm.username.focus();
		return false;
	}

	
	return true;
	
}



function submitEmailProfileForm(){
	 //var valid = true;
	 if (this.document.forms[0].last4ssn.value == "") {
            alert("Enter Last 4 digits of Social Security Number.");
            this.document.forms[0].last4ssn.focus();
            return false;
			
      }
      if (this.document.forms[0].ccnum.value == "") {
            alert("Enter Credit Card Number.");
            this.document.forms[0].ccnum.focus();
            return false;
      }
	  
	  return true; 
	//  if (true){
	  	//	this.document.forms[0].method = 'post';
 		//	this.document.forms[0].action = 'validateEmailProfile.do';
  			//this.document.forms[0].submit();
	  //}
}



//actions --
function updateEmail(action){
	var updateAction = action;
	//alert(updateAction);
	
	var sucess =true;
	var emailAction = document.getElementById("updateAction");

	if (updateAction == 'dp'){
	 	alert("You can not delete Primary unless you add a new one.");
	 	sucess= false;
		//	return false;
	}
	else if (updateAction== 'dalt1'){
		emailAction.value ="deleteAlt1";
	}
	else if (updateAction== 'dalt2'){
		emailAction.value ="deleteAlt2";
	}
	else if (updateAction== 'mpalt1'){
		emailAction.value ="makePrimaryAlt1";
	}
	else if (updateAction== 'mpalt2'){
		emailAction.value ="makePrimaryAlt2";
	}
	else if (updateAction== 'add'){
		var newEmail = this.document.emailForm.newEmail.value;
		if (newEmail==''){
			alert("New Email Address can not be blank");
			sucess= false;
		}
		else {
			
			//var	emailReturn = checkEmail (newEmail);
			//if (emailReturn!=null && emailReturn !=""){
				//alert("Email Address Error.\n"+emailReturn);
				//this.document.emailForm.newEmail.focus();
				//sucess= false;
			//}
			//else{
			
			emailAction.value ="add";
			//}
		}
	}
	
	//alert("sucess: "+sucess + " for action: " + document.getElementById("updateAction").value);
	if (sucess== true){
		 	//this.document.emailForm.method = 'post';
		  //  this.document.emailForm.action = 'updateEmail.do';
		    this.document.emailForm.submit();
	}
}





var isNN = (navigator.appName.indexOf("Netscape")!=-1);
function autoTab(input,len, e)
{
	var keyCode = (isNN) ? e.which : e.keyCode; 
	var filter = (isNN) ? [0,8,9] : [0,8,9,16,17,18,37,38,39,40,46];
	if(input.value.length >= len && !containsElement(filter,keyCode))
	{
		input.value = input.value.slice(0, len);
		input.form[(getIndex(input)+1) % input.form.length].focus();
	}
	function containsElement(arr, ele)
	{
		var found = false, index = 0;
		while(!found && index < arr.length)
			if(arr[index] == ele)
				found = true;
			else
				index++;
			return found;
	}
	function getIndex(input)
	{
		var index = -1, i = 0, found = false;
		while (i < input.form.length && index == -1)
			if (input.form[i] == input)index = i;
			else i++;
			return index;
	}
	return true;
}
 // Only digits 
function digitsOnly(e)
{
	var key;
	if (window.event)
	{
		key = window.event.keyCode; //IE
	}
	else
	{
		key = e.which; // Fire Fox
	}

	if ((key > 47 && key < 58)||(key == 8 || key == 0 || key == 118 || key == 99))
	{
		return true;
	}
	else
	{
		return false;
	}
}

//
function numberKey(e)
{
	var key;
	if (window.event)
	{
		key = window.event.keyCode; //IE
	}
	else
	{
		key = e.which; // Fire Fox
	}

	if ((key > 47 && key < 58)||(key == 8 || key == 0 || key == 118 || key == 99))
	{
		return true;
	}
	else
	{
		return false;
	}
}


