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
<%@ page import="javax.servlet.*,java.text.*" %>
<%@include file="init.jsp" %>
<body>

<%
   String email=request.getParameter("email");
   String password1=request.getParameter("password1");
   String password2=request.getParameter("password2");
   
   getServletContext().getRequestDispatcher("/register.jsp").include(request, response);
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
		   //upon successful registration redirects to index/home page
	       response.sendRedirect("index.jsp");
	   } else{
		   
		   %>
 		<center><p style="color:red">Your passwords don't match.</p></center>

	    <%
	   		
   }
      
   }
   catch(SQLException sqe)
   {
	   %>
 	<center><p style="color:red">Your account is already registered. Please login.</p></center>

    <%
   }
   }
   else
   {
   %>
   <center><p style="color:red">Sorry, your registration is not complete!</p></center>
   <% 
   }
   %>

</body>
</html>