<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link rel="stylesheet" type="text/css" href="css/main.css">
<title>Registration</title>
<script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
<%@include file="header.jsp"%>
<div class="mainDiv">


<div style="float:left; width:400px; height:100%;">
	<form action="reg1.jsp" method="post">
     <div style="margin-top:20px;">

         <div style="width:160px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             Email:
         </div>
         <div style="width:180px; height: 30px; float:left;">
             <input style="width: 150px;" type="text" name="email" />
         </div>
         
         <div style="width:160px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             New User Password:
         </div>
         <div style="width:180px; height: 30px; float:left;">
             <input style="width: 150px;" type="password" name="password1" />
         </div>
         
         
         <div style="width: 50px; margin-left:310px;">
         <input type="submit" value="login"/>
         </div>
     </div>
     <br>
      
     </form>
     
</div>
 <div style="float:right; width:400px; height:100%;">
    <form action="reg1.jsp" method="post">
     <div style="margin-top:20px;">

         <div style="width:160px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             Email:
         </div>
         <div style="width:180px; height: 30px; float:left;">
             <input style="width: 150px;" type="text" name="email" />
         </div>
         
         <div style="width:160px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             New User Password:
         </div>
         <div style="width:180px; height: 30px; float:left;">
             <input style="width: 150px;" type="password" name="password1" />
         </div>
         
         <div style="width:160px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             Confirm Your Password:
         </div>
         <div style="width:180px; height: 30px; float:left;">
             <input style="width: 150px;" type="password" name="password2" />
         </div>
         
         
         
         <div style="width: 50px; margin-left:310px;">
         <input type="submit" value="register"/>
         </div>
         
         <div style="padding-top:20px; height:100px; width:400px;">
         Your identity will never be shared or published. Usernames are randomly generated and emails are collected for password recovery purposes only.
         </div>
     </div>
     <br>
      <center><div class="g-recaptcha" data-sitekey="6LcT7v4SAAAAAO5WchV_q_WyrV-asheOD3aDhixx"></div></center>
     </form>
  </div>
</div>
</body>
</html>