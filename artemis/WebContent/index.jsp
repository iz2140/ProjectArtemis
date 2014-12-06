<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="init.jsp" %>
<%
	ResultSet rset = null;
	try {
		Statement stmt = conn.createStatement();
		rset = stmt.executeQuery("SHOW TABLES");
	} catch (SQLException e) {
		error_msg = e.getMessage();
	}
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <title>Project Artemis</title>

</head>
<body>
    <div class="mainDiv">
    <%@include file="header.jsp" %>
    
        <div style="width: 800px; height: 150px; padding-top:50px; background-color:#C4D8E2;">
            <div style="width:540px; height: 100px; margin:0px auto;">
                <div class="title" style="height:32px;">test</div>
                <div style="height:68px">
                    <form name ="dbsearch" action="results.jsp" method="GET" onsubmit="return(submitSearch());">
                    <input type="text" placeholder="restaurant, neighborhood, category or blank for map search" name="search"><input id="searchBtn" type="submit" value="search!">
                    </form>
                </div>
            </div>
            
        </div>
        
        <%
		if(rset != null) {
			while(rset.next()) {
				out.print("<tr>");
				out.print("<td>" + rset.getString(1) + "</td>");
				out.print("</tr>");
			}
		} else {
			out.print(error_msg);
		}
		if( conn != null ) {
			conn.close();
		}
		%>
        
        
    </div>
        
   


</body>
</html>