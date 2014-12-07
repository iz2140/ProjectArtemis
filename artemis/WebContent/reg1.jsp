<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Registration</title>
</head>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.Date" %>
<%@include file="init.jsp" %>
<body>

<%
   String email=request.getParameter("email");
   String password1=request.getParameter("password1");
   String password2=request.getParameter("password2");
   
  
   PreparedStatement ps = null;
   ResultSet rs = null;
   
   //password and username not null
   if(!(email.equals(null) || email.equals("")) && !(password1.equals(null) || password1.equals(""))) {
   try {

   //passwords match
	if(password1.equals(password2)){
		//get random username --TO DO: RANDOMLY GENERATE USERNAMES
		String username = "Calliope";
		
		String sql = "insert into Users (u_id, email, username, password)";
		sql += "values ('"+email+"','"+username+"','"+password1+"')";
	   ps = conn.prepareStatement(sql);
	   int rows= ps.executeUpdate(); 
	   session.setAttribute("uid", email);
	   session.setAttribute("username", username);
       response.sendRedirect("RegComplete.jsp");
   }
   else
	   response.sendRedirect("RegistrationError.jsp");
      
   }
   catch(SQLException sqe)
   {
	   %>
	   <div class="mainDiv" style="background-color:#f0f0f0;">
		    <%@include file="header.jsp" %>
		    <div id="menuPage">
		<div style="width:600px; margin:0px auto; padding-top:10px;">
	   <%
	   out.println("<div class=\"title\"><center>Sorry, your account already exists!</center></div>");
	   out.println("<center><img src=\"registered.png\"></center>");
	   out.println("<br><center><a href=\"LoginHome.jsp\" class=\"button\">Back to Login Page</a></center>");
	    %>
        </div></div></div>
    <%
   }
   }
   else
   {
	   //?? Please halp!1
	   getServletContext().getRequestDispatcher("/RegistrationUI.jsp").include(request, response);
   %>
   <center><p style="color:red">Sorry, your registration is not complete!</p></center>
   <% 
   }
   %>

</body>
</html>