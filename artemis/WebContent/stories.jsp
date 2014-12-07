<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<title>Stories</title>
	
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
    
        <div style="width:100%; height:300px; background-color:#f6f6f6; margin:0px 0px; margin-top: 86px; padding:10px 10px 0px 0px;">
            <div style="width: 800px; margin:0px auto; margin-top: 90px;">
                <h1>Real Stories by Real Women.</h1>
                Violence against women is one of the most widespread of human rights abuses. One out of every three women worldwide will be physically, sexually or otherwise abused during her lifetime. During times of war and conflict, sexual violence is used to terrorize and humiliate women and girls. Survivors often suffer further victimization by family and society. The International Rescue Committee works to break this cycle of violence by helping survivors 
            </div>
        </div>
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
        	
        	String reloadURL = "window.location.href=\'stories.jsp?";
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
        
        /* ------------------ STORIES -------------------*/
        while (rset.next()) {
        	if (count != 0)
        		out.print("<hr>");
        	
        	count++;
        	
        	if (count < pageMin || count > pageMax) {
        		continue;
        	}
        	
        	out.print("<div class=\"storyRow\">");
        	out.print("<div class=\"storyLeft\">");
        	
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
        	
            
            /* SERVICES USED */
            String serv = rset.getString("serv_used");
            out.print("<div style=\"clear:both; float:left; padding-left: 10px; margin-top: 41px;\">");
           
            pset = null;
            try {
                sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='artemis' AND TABLE_NAME='services'";
                pstmt = conn.prepareStatement(sql);
                pset = pstmt.executeQuery();
                
                pset.next();
                
                out.print("<div class=\"smallBold\">");
                out.print("<ul style=\"padding-left:35px;\">");
                int ct = 0;
                while (pset.next()) {
                    
                	if (serv.substring(ct, ct+1).equals("1")) {
	                	out.print("<li>");
	                    out.print(pset.getString(1).replace('_', ' '));
	                    out.print("</li>");
                	}
                    
                    ct++;

                }
                out.print("</ul>");
                out.print("</div>");
                
            } catch (SQLException e) {
                error_msg = e.getMessage();
                System.out.println(error_msg);
            }
            
            if (rset.getInt("verified") == 1) {
            	out.print("<div class=\"verifiedImg\">verified review</div>");
            }
            
            
            
        	out.print("</div></div>");
        	
        	
        	out.print("<div class=\"storyRight\">");
        	
        	/* NAME OF PROVIDER */
            pset = null;
            try {
                sql = "select * from providers where p_id='" + rset.getInt("p_id") + "'";
                pstmt = conn.prepareStatement(sql);
                pset = pstmt.executeQuery();
                
                if (pset.next()) {
                	
                	out.print("<h3 style=\"margin-top:6px;\">");
                    out.print("@ " + pset.getString("name"));
                    /*while (pset.next()) {
                        out.print(", " + pset.getString("c_name"));
                    }*/
                    out.print("</h3>");
                    
                    out.print("<h3 style=\"margin-left:23px;\">");
                    out.print(pset.getString("city") + ", " + pset.getString("state"));
                    out.print("</h3>");
                    
                }
                
            } catch (SQLException e) {
                error_msg = e.getMessage();
                System.out.println(error_msg);
            }
            
        	
            
            out.print("<div style=\"float:left; margin-top: 20px;\"><h3>");
            //out.print(rset.getString("name"));
            out.print("anonymous' story:");
            out.print("</h3></div>");
            
            out.print("<div style=\"float:right; margin-top: 20px;\"><h3>");
            out.print(rset.getString("timestamp"));
            
            out.print("</h3></div>");
            
            out.print("<div style=\"clear:both; float:left; margin-top: 10px;\">");
            out.print(rset.getString("review_text"));
            out.print("</div>");
            
            
            /* LINK */
            
            
            
            /* end results row */
            out.print("</div></div>");
            
        }
    } else {
    	out.print("oh no! " + error_msg);
    }
    
    if (conn != null)
        conn.close();
    if (pstmt != null)
        pstmt.close();
    %>
    
    </div>
    <%@include file="footer.jsp" %>
</body>
</html>