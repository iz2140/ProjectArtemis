<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- This import is necessary for JDBC -->
<%@ page import= "java.util.*" %>
<%@include file="init.jsp" %>
<%
PreparedStatement pst = null;
String sql;
ResultSet rs = null;
String p_id = request.getParameter("p_id");
StringBuilder sb;
String story;
try	{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, userId, password);
} catch (SQLException e) {
	error_msg = e.getMessage();
	System.out.println(error_msg);
}
sql = "SELECT * FROM reviews WHERE p_id = ";
sb = new StringBuilder(sql);
sql = sb.append(p_id).append(";").toString();
try	{
	pst = conn.prepareStatement(sql);
	pst.clearParameters();
} catch (SQLException e) {
	error_msg = e.getMessage();
	System.out.println(error_msg);
}
try	{
	System.out.println(sql);
	rs = pst.executeQuery();
} catch (SQLException e) {
	System.out.println("error executing query");
	error_msg = e.getMessage();
	System.out.println(error_msg);
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
// iterate through result set
while (rs.next()) {
	story = rs.getString("review_text");
	out.print("<div><p>");
	out.print(story);
	out.print("</p></div>");
}
%>
</body>
</html>