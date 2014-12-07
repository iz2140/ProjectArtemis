<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">

<title>Insert title here</title>
<%@include file="init.jsp" %>

</head>
<body>
<%@include file="header.jsp" %>
<div class="mainDiv" style="background-color:#f0f0f0;">
    
     

<div id="menuPage">
<div style="width:600px; margin:0px auto; padding-top:10px;">

<%
   String usid=(String)session.getAttribute("email");
   String stars=request.getParameter("moons");
   String comments=request.getParameter("comments").replace("'", "''");
   String p_id = request.getParameter("p_id");
   String[] qualities=request.getParameterValues("quality");
   
   java.util.Date date = new java.util.Date();
   java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
   String reviewDate = sdf.format(date);
   
   PreparedStatement ps = null;
   ResultSet rs = null;
  
   try {
   
	   //ps = conn.prepareStatement("insert into reviews (p_id, u_id, rating, review_text, timestamp) values ('"+p_id+"','"+usid+"','"+stars+"','"+comments+"','"+reviewDate+"')");
	   ps = conn.prepareStatement("insert into reviews (p_id, u_id, rating, review_text) values ('"+p_id+"','"+usid+"','"+stars+"','"+comments+"')");

	   int rows= ps.executeUpdate();
   
	   if (rows > 0) {
		    out.print("Thank you for your feedback!");
		   
		   /* update moons in providers table */
		   String sql = "UPDATE providers SET avg_rating=((avg_rating*num_reviews)+";
		   sql += stars + ")/(num_reviews + 1) WHERE p_id='" + p_id + "'";
		   ps = conn.prepareStatement(sql);
		   ps.clearParameters();
		   ps.executeUpdate();
		   
		   /* update count in providers table */
		   ps = conn.prepareStatement("UPDATE providers SET num_reviews=num_reviews+1 WHERE p_id='" + p_id + "'");
		   ps.clearParameters();
		   ps.executeUpdate();
	   }else {
		   out.print("Oops, you already reviewed this service provider!<br><br>");
	   }
   
   } catch(SQLException sqe) {
	   out.print(sqe);
	   //out.println("error: " + sqe);
   }
%>
<br><a href="index.jsp" class="button">Go Back?</a>
</div></div></div>
<%@include file="footer.jsp"%>
</body>
</html>