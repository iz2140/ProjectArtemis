<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
 <div style="width:500px; height:100%; margin:0px auto;">
    <div style="width: 500px; height: 300px; padding-top:50px; background-color:#aac3d0;">
	<form action="reg1.jsp" method="post">
     <div style="margin-top:20px;">

         <div style="width:220px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             Email:
         </div>
         <div style="width:270px; height: 30px; float:left;">
             <input style="width: 150px;" type="text" name="email" />
         </div>
         
         <div style="width:220px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             New User Password:
         </div>
         <div style="width:270px; height: 30px; float:left;">
             <input style="width: 150px;" type="password" name="password1" />
         </div>
         
         <div style="width:220px; height: 30px; padding-right: 10px; float:left; text-align:right;">
             Confirm Your Password:
         </div>
         <div style="width:270px; height: 30px; float:left;">
             <input style="width: 150px;" type="password" name="password2" />
         </div>
         
         Your identity will never be published to the site. Usernames are randomly generated and emails are collected for password recover.
         
         <div style="width: 50px; margin-left:310px;">
         <input type="submit" value="register"/>
         </div>
     </div>
     <br>
     <br>
      <div class="g-recaptcha" data-sitekey="6LcT7v4SAAAAAO5WchV_q_WyrV-asheOD3aDhixx"></div>
     </form>
     </div>
  </div>

</body>
</html>