<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<title>Search Results</title>
	
	<%@include file="init.jsp" %>
	<%
		PreparedStatement pstmt = null;
		StringBuilder sb;
	    String sql;
	    ResultSet rset = null;
	    ResultSet nset = null;
	    
	    String[] ser = request.getParameterValues("service"); //search param from prev page
	    if (ser !=null ) {
		    for (int i = 0; i < ser.length; i++) {
		    	System.out.print(ser[i] + "\n");
		    }
	    }
	    
	    String city = request.getParameter("city");
	    //System.out.print(city + "\n");
	    String state = request.getParameter("st");
	    //System.out.print(state + "\n");
	    String zipcode = request.getParameter("zipcode");
	    //System.out.print(zipcode + "\n");
	    String age_to_18 = request.getParameter("age");
	    //System.out.print(age_to_18 + "\n");
	    
	    int numResults = 0;
	    try {
	        if (request.getParameterValues("service") != null && (city != null) && (state !=null)) {
	        	
	            /*------------ SEARCH BY GEOCODING ------------*/        
/* 	        	sql = "SELECT *,X(latlong),Y(latlong) FROM providers ";
	           
	            sql += "WHERE X(latlong) BETWEEN " + request.getParameter("latSW");
	            sql += " AND " + request.getParameter("latNE") + " AND ";
	            sql += "Y(latlong) BETWEEN " + request.getParameter("lonSW");
	            sql += " AND " + request.getParameter("lonNE");
	        	
	        	sql += " ORDER BY n_Stars DESC";
	        	 */
	        	
	        	/*------------ SEARCH BY CITY, ST ------------*/
	        	//list of providers ordered by rating, where city and state matched user specified params
	        	sql = "SELECT * FROM providers";
	        	//sql += String.format("WHERE city='%s'", city);
	        	//sql += String.format(" AND state='%s'", state);
	        	sql += " ORDER BY num_reviews DESC";
	        	pstmt = conn.prepareStatement(sql);
	            pstmt.clearParameters();
	            rset = pstmt.executeQuery();

	        } else {
	        
	            /*------------ SEARCH BY NAME/CATEGORY/NEIGHBORHOOD ------------*/
	            
/* 	            sql = "SELECT *,X(latlong),Y(latlong) FROM Restaurants R LEFT JOIN Neighborhoods N ";
	            sql += "on R.neighborhood=N.nid WHERE R.name LIKE '%" + req + "%' ";
	            
	            sql += "OR R.rid IN (select rid from Belongs_To WHERE ";
	            sql += "c_name LIKE '%" + req + "%') OR ";
	            
	            sql += "R.neighborhood IN (SELECT nid FROM Neighborhoods WHERE ";
	            sql += "n_name LIKE '%" + req + "%') ";
	            
	            sql += "ORDER BY n_Stars DESC";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.clearParameters();
	            rset = pstmt.executeQuery(); //SQL Query
	             */
	        }
	        if (rset != null) {
	        	rset.last();
	        	numResults = rset.getRow();
	        	rset.beforeFirst();
	        }
	        
	    } catch (SQLException e) {
	        error_msg = e.getMessage();
	        System.out.println(error_msg);
	        if( conn != null ) {
	            conn.close();
	        }
	    } finally {
	    	
	    }
	%>
	
	<!---------------------- MAPS ---------------------->
    <style type="text/css">
        #map-canvas { height: 100% }
    </style>
    <script type="text/javascript"
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdPsLgg5PiilpehtL2BGcf4Q5LteFmZzU">
    </script>
    <script type="text/javascript">
    var markers = new Array();
    var map;
    function initialize() {
    	var c = markers[0].getPosition();
    	
        var mapOptions = {
                center: { lat: c.lat(), lng: c.lng() },
                zoom: 18,
                mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById('map-canvas'),
                mapOptions);
        google.maps.event.addListenerOnce(map, 'bounds_changed', mapInit);
    }
    
    function addMarker(_name, _lat, _lon, _url) {
    	var myLatlng = new google.maps.LatLng(_lat, _lon);
        var marker = new google.maps.Marker({
            position: myLatlng,
            title: _name,
            url: _url,
            animation: google.maps.Animation.DROP
        });
        markers.push(marker);
    }

    function dropMarker() {
        var m = markers.shift();
        var marker_pos = m.getPosition();
        var current_bounds = map.getBounds();
        
        if (current_bounds == undefined) {
        	alert(m.getTitle());
        } else if (!current_bounds.contains(marker_pos)) {
            var new_bounds = current_bounds.extend(marker_pos);
            map.fitBounds(new_bounds);
        }
        
        m.setMap(map);
        
        google.maps.event.addListener(m, 'click', function() {
            window.location.href = this.url;
        });
    }
    
    function mapInit() {
    	for (var i = 0; i < markers.length; i++) {
            setTimeout(function() { dropMarker(); }, i * 250);
        }
    }
    google.maps.event.addDomListener(window, 'load', initialize);
    
    </script>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="mainDiv">
    

    
    <!-- MAPS -->
    <div id="map-canvas" style="width: 800px; height: 300px;"></div>
  
    <%
    if (rset != null) {
    	rset.beforeFirst();
    	int count = 0;
        ResultSet pset = null;
        String p_id = "0"; //unique key id of the provider
        
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
        	
            if (request.getParameter("latSW") != null) {
            	reloadURL += "&latSW=" + request.getParameter("latSW");
            	reloadURL += "&lonSW=" + request.getParameter("lonSW");
            	reloadURL += "&latNE=" + request.getParameter("latNE");
            	reloadURL += "&lonNE=" + request.getParameter("lonNE");
            }
            
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
        while (rset.next()) {
        	count++;
        	
        	if (count < pageMin || count > pageMax) {
        		continue;
        		
        	}
        	
        	
        	out.print("<div class=\"resultRow\">");
        	out.print("<div class=\"provResLeft\">");
        	p_id = rset.getString("p_id");
        	pset = null;
        	String photo = "http://s3-media1.ak.yelpcdn.com/assets/2/www/img/924a6444ca6c/gfx/blank_biz_medium.gif";
        	
        	try {
                sql = "select url from providerphotos where p_id=" + p_id + "";
                pstmt = conn.prepareStatement(sql);
                pstmt.clearParameters();
                pset = pstmt.executeQuery();
                pset.next();
                photo = pset.getString("url");
                
            } catch (SQLException e) {
                error_msg = e.getMessage();
                System.out.println(error_msg);
            }
        	/*
        	out.print("<div class=\"resultImg\">");
        	out.print("<span class=\"resultImgInner\"></span>");
        	out.print("<img style=\"vertical-align:middle; max-height:100px; max-width:100px;\" src=\"" + photo + "\">");
        	out.print("</div>");
        	*/
        	//STARS---------------------------------------------
            out.print("<div class=\"stars\" style=\"margin-left: 18px; margin-top: 8px;\">");
            double sd = rset.getDouble("avg_rating");
            int s = (int) Math.floor(sd);
            String starsDiv = Integer.toString(s);
            if (s < sd) {
            	starsDiv += "5";
            }
			System.out.println(starsDiv);
            
            starsDiv = "<div class=\"stars" + starsDiv + "\">";
            out.print(starsDiv);
            out.print("<div class=\"starsImg\"></div>");
            out.print("</div></div>");
            //--------------------------------------------------
            
            /* SERVICES */
					String[] service_array = {"std","sexual_assault","domestic_violence", "pregnancy_testing",
    				"abortion", "low_cost", "contraception", "counseling"};
					
					out.print("<div style=\"clear:both; float:left; padding-left: 10px; margin-top: 41px;\">");

					pset = null;
		          
					try {
						//sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA='artemis' AND TABLE_NAME='services'";
						sql = "select * from services where p_id='" + p_id + "'";
						pstmt = conn.prepareStatement(sql);
						pset = pstmt.executeQuery();
						ArrayList<String> servicesOffered= new ArrayList<String>();
						while (pset.next()) {
							
							for (String serv:service_array)	{
								if (pset.getInt(serv)==1)
									servicesOffered.add(serv);
							}
						}

						out.print("<div class=\"smallBold\">");
						out.print("<ul style=\"padding-left:35px;\">");
						for (String serv:servicesOffered) {
							out.print("<li>");
							out.print(serv);
							out.print("</li>");
						}

						out.print("</ul>");
						out.print("</div>");

					} catch (SQLException e) {
						error_msg = e.getMessage();
						System.out.println(error_msg);
					}
					out.print("</div>");
					
        	out.print("</div>");	//storyLeft
        	
        	out.print("<div class=\"provResRight\">");
        	/* NAME OF PROVIDER */
        	
            out.print("<div class=\"resultName\">" + count + ". ");
            out.print(rset.getString("name"));
            out.print("</div>");	// end result name
            /* LINK */
            int pid = rset.getInt("p_id");
            String rpath = "\"provider.jsp?p_id=";
            sb = new StringBuilder(rpath);
            rpath = sb.append(pid).append("\"").toString();
            StringBuilder anchor = new StringBuilder("<a href=");
            String anchorStr = anchor.append(rpath).append(">").append(rset.getString("name")).append("</a>").toString();
            //out.print("<a href=" + rpath + "></a>");
            out.print(anchorStr);
            
            
			
            out.print("<div style=\"width: 140px; height: 24px; margin-top: 14px; margin-left: 10px; float:left;\">");
            out.print(rset.getInt("num_reviews") + " reviews");
            out.print("</div>");	// end num review
            
           
            /* NEIGHBORHOOD / ADDRESS */
            out.print("<div style=\"margin-top: 14px; width: 358px; float:left;\">");
            out.print(rset.getString("address_1") + "<br>");
            if (!rset.getString("address_2").equals("NULL"))	{
            	out.print(rset.getString("address_2"));
            	
            }
            out.print("</div><div style=\"clear:both;\"></div>");
            //out.print("</div>");	// end result name
            /* end results row */
            out.print("</div>");
            out.print("</div>");
            /* add marker to map */
            out.print("<script type=\"text/javascript\">");
            out.print("addMarker(\"" + rset.getString("name") + "\",");
            out.print(rset.getFloat("latitude") + ",");
            out.print(rset.getFloat("longitude") + ",");
            out.print(rpath + ");");
            out.print("</script>");
            
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