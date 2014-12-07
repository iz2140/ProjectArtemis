<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<title>Search Results</title>
	
	<%@include file="init.jsp" %>
	
	<%
		PreparedStatement pstmt = null;
	    String sql;
	    ResultSet rset = null;
	    
	    int numResults = 0;
	    try {

	            /*------------ STORIES ------------*/
	            
 	            sql = "SELECT * FROM reviews R ORDER BY timestamp DESC";
	            
	            pstmt = conn.prepareStatement(sql);
	            rset = pstmt.executeQuery(); //SQL Query
	            
	        if (rset != null) {
	        	rset.last();
	        	numResults = rset.getRow();
	        	rset.beforeFirst();
	        }
	        
	    } catch (SQLException e) {
	        error_msg = e.getMessage();
	        System.out.println(error_msg);
	    } finally {
	    	
	    }
	%>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="mainDiv">
    
    <%
    if (rset != null) {
    	rset.beforeFirst();
    	int count = 0;
        ResultSet pset = null;
        
        /*---------- PAGES ------------*/
        int resultsPP = 20;
        int pageNum = 0;
        if (request.getParameter("page") != null) {
            pageNum = Integer.parseInt(request.getParameter("page")) - 1;
        }
        
        int pageMin = pageNum * resultsPP + 1;
        int pageMax = pageMin + resultsPP - 1;
        
        if (numResults > 20) {
        	int j = 0;
        	double numP = java.lang.Math.ceil(numResults / 20.0); //hard coded...
        	
        	String reloadURL = "window.location.href=\'results.jsp?";
        	reloadURL += "search=" + request.getParameter("search");
            
            reloadURL += "&page=";
            out.print("<div class=\"pgRow\">");
        	for (j = 0; j < numP; j++) {
        		
        		out.print("<div class=\"pgN\">");
        		out.print((j+1));
        		out.print("<a href=\"javascript:window.location.href=" + reloadURL + (j+1) + "'\"></a>");
        		out.print("</div>");
        	}
        	out.print("</div>");
        }
        
        %>
        <div style="width:800px; height:140px; background-color:#f6f6f6; margin:0px 0px; padding:10px 10px 0px 0px;">
        
            <div style="margin-left: 50px; margin-top: 90px;">
                <h1>Real Stories by Real Women.</h1>
            </div>
        
        </div>
        
        
        <%
        /* ------------------ STORIES -------------------*/
        while (rset.next()) {
        	count++;
        	
        	if (count < pageMin || count > pageMax) {
        		continue;
        	}
        	
        	out.print("<div class=\"storyRow\">");
        	
        	
        	/* NAME OF RESTAURANT */
        	
            out.print("<div class=\"resultName\">" + count + ". ");
            //out.print(rset.getString("name"));
            out.print("anonymous says...");
            
            out.print(rset.getString("review_text"));
            out.print("</div>");
            /* LINK */
            /*String rpath = rset.getString("name");
            rpath = rpath.replace(" ", "+");
            rpath = rpath.replace("&", "%26");
            rpath = rpath.replace("'", "%27%27");
            rpath = "\"restaurant.jsp?name=" + rpath + "\"";
            out.print("<a href=" + rpath + "></a>");
            out.print("</div>");*/
            
            /* CATEGORIES */
            /*pset = null;
            String cat;
            try {
                sql = "select c_name from Belongs_To where rid='" + rid + "'";
                pstmt = conn.prepareStatement(sql);
                pstmt.clearParameters();
                pset = pstmt.executeQuery();
                
            } catch (SQLException e) {
                error_msg = e.getMessage();
                System.out.println(error_msg);
            }
            
            if (pset.next()) {
	            out.print("<div style=\"width:658px; padding-left: 22px; float:left;\">" + pset.getString("c_name"));
	            while (pset.next()) {
	            	out.print(", " + pset.getString("c_name"));
	            }
	            out.print("</div>");
            }*/
            
            //STARS---------------------------------------------
            out.print("<div class=\"stars\" style=\"margin-left: 18px; margin-top: 8px;\">");
            double sd = rset.getDouble("rating");
            int s = (int) Math.floor(sd);
            String starsDiv = Integer.toString(s);
            if (s < sd) {
            	starsDiv += "5";
            }
            starsDiv = "<div class=\"stars" + starsDiv + "\">";
            out.print(starsDiv);
            out.print("<div class=\"starsImg\"></div>");
            out.print("</div></div>");
            //--------------------------------------------------
            
            
            
            /* end results row */
            out.print("</div>");

        }
    } else {
    	out.print("oh no! " + error_msg);
    }
    
    if (conn != null)
        conn.close();
    if (pstmt != null)
        pstmt.close();
    %>
    <%@include file="footer.jsp" %>
    </div>
</body>
</html>