<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String p_id = request.getParameter("p_id"); //search provider from prev page
%>

<%@include file="header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Tell Your Story</title>
</head>
<body>

	<div class="mainDiv">
<%-- 		
		<%
			if (uname != null) {
		%> --%>
		
		<%
			
			out.print("<input type=\"hidden\" name=\"rid\" value=\""
						+ request.getParameter("rid") + "\"");
		%>
		    
		<form name="story" method="post" action="submitdb.jsp">
			<table cellpadding="10" cellspacing="10" align="center">
				<col width="230">
  				<col width="500">
				<tr>
					<td>Rate your experience</td>
					<td>
					<input type="radio" name="moons" value="1"> 1
					<input type="radio" name="moons" value="2"> 2
					<input type="radio" name="moons" value="3"> 3
					<input type="radio" name="moons" value="4"> 4
					<input type="radio" name="moons" value="5"> 5
					</td></tr>
				<tr>
					<td>Tell your story</td>
					<td><textarea name="comments">Please be as detailed as you're comfortable sharing.</textarea>	
					</tr>
				<tr>
					<td>I would describe this place as...</td>
					<td>
					 	<input type="checkbox" name="quality" value="lgbt"> LGBT-friendly<br>
				    	<input type="checkbox" name="quality" value="nonjudgmental"> non-judgmental<br>
				    	<input type="checkbox" name="quality" value="responsive"> responsive<br>
					    <input type="checkbox" name="quality" value="convenient"> convenient<br>
					 	<input type="checkbox" name="quality" value="professional"> professional<br>
					 	<input type="checkbox" name="quality" value="budget"> budget friendly<br>
					 	<input type="checkbox" name="quality" value="safe"> safe<br>
					</td>
				</tr>
			</table>
			<center>
				<input type="submit" value="submit" />
				<%
					java.util.Date date = new java.util.Date();
						java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
								"yyyy-MM-dd");
						String reviewDate = sdf.format(date);
						out.print("TODAY'S DATE: " + reviewDate);
				%>
			</center>
		</form>
		<%-- <% 
} else {
%>
		<div class="reviewRow">Please login to write a review. Thank
			you!</div>
		<%
}
%> --%>
	</div>

</body>
</html>