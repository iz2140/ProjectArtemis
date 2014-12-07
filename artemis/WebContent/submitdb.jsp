<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="mainDiv" style="background-color:#f0f0f0;">
    <%@include file="header.jsp" %>
     <%@include file="init.jsp" %>

<div id="menuPage">
<div style="width:600px; margin:0px auto; padding-top:10px;">

<%
   String usid=(String)session.getAttribute("uid");
   String stars=request.getParameter("stars");
   String comments=request.getParameter("comments");
   
   java.util.Date date = new java.util.Date();
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String reviewDate = sdf.format(date);
   
   Connection con= null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   String driverName = "com.mysql.jdbc.Driver";
   String url = "jdbc:mysql://cs4111.c0qbuooiy4er.us-west-2.rds.amazonaws.com:3306/cs4111";
   String user = "nl2450";
   String pwd = "Einsteinlnj123";
   try {
   Class.forName(driverName);
   con = DriverManager.getConnection(url, user, pwd);
   ps = con.prepareStatement("insert into Reviews (uid, rid, r_text, n_Stars, r_date) values ('"+usid+"','"+req+"','"+comments+"','"+stars+"','"+reviewDate+"')");
   int rows= ps.executeUpdate();
   
	   if (rows > 0) {
		    out.print("Thank you for your feedback!" + session.getAttribute("name") + "<br><br>");
	   
	   
		   ps = con.prepareStatement("UPDATE Users SET n_Reviews=n_Reviews+1 WHERE uid='" + usid + "'");
		   ps.clearParameters();
		   ps.executeUpdate();
		   
		   /* update stars */
		   String sql = "UPDATE Restaurants SET n_Stars=((n_Stars*n_Reviews)+";
		   sql += stars + ")/(n_Reviews + 1) WHERE rid='" + req + "'";
		   ps = con.prepareStatement(sql);
		   ps.clearParameters();
		   ps.executeUpdate();
		   
		   /* update count */
		   ps = con.prepareStatement("UPDATE Restaurants SET n_Reviews=n_Reviews+1 WHERE rid='" + req + "'");
		   ps.clearParameters();
		   ps.executeUpdate();
	   }else {
		   out.print("oops, you already reviewed this restaurant!<br><br>");
	   }
   
   } catch(SQLException sqe) {
	   out.print("oops, you already reviewed this restaurant!<br><br>");
	   //out.println("error: " + sqe);
   }
%>
<br><a href="index.jsp" class="button">Go Back Home?</a>
</div></div></div>

</body>
</html>