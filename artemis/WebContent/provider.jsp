<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <title>provider</title>
    
    <%@include file="init.jsp" %>
    
    <%
    
        PreparedStatement pstmt = null;
        StringBuilder sb;
        String sql;
        ResultSet rset = null;
        ResultSet revset = null;
        
        String p_id = request.getParameter("p_id");
        
        int numResults = 0;
        try {
        	sql = "SELECT * FROM providers where p_id='" + p_id + "'";
        	pstmt = conn.prepareStatement(sql);
            rset = pstmt.executeQuery();
        	
            
                //sql += " ORDER BY avg_rating DESC";
            sql = "SELECT * FROM reviews where p_id='" + p_id + "'";
            pstmt = conn.prepareStatement(sql);
            revset = pstmt.executeQuery();
            
            if (revset != null) {
            	revset.last();
                numResults = revset.getRow();
                revset.beforeFirst();
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
    <script type="text/javascript" src="js/alertBox.js"></script>
    <script  language="JavaScript" type="text/javascript">
function gotoreview ()
{
    <%
    //if (uid != null) {
    %>
    document.reviewForm.submit();
    <%
    //} else {
    %>
    //alertBox("Please login first!!");
    <%
    //}
    %>
}

function gotodelete()
{
    document.deleteForm.submit();
}
</script>
    <!---------------------- MAPS ---------------------->
    <style type="text/css">
        html { height: 100% }
        body { height: 100%; margin: 0; padding: 0 }
        #map-canvas { height: 100% }
    </style>
    <script type="text/javascript"
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdPsLgg5PiilpehtL2BGcf4Q5LteFmZzU">
    </script>
    <script type="text/javascript">
    var map;
    var rMark;
    function initialize() {
        
        var mapOptions = {
                center: { lat: rMark.lat, lng: rMark.lon },
                zoom: 18,
                mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById('map-canvas'),
                mapOptions);
        
        var myLatlng = new google.maps.LatLng(rMark.lat, rMark.lon);
        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            animation: google.maps.Animation.DROP
        });
    }
    function addMark(_lat, _lon) {
        rMark = { lat: _lat, lon: _lon };
    }

    google.maps.event.addDomListener(window, 'load', initialize);
    
    </script>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="mainDiv">
    
<%
rset.next();
    if (rset != null) {
        /* add marker to map */
        out.print("<script type=\"text/javascript\">");
        out.print("addMark(");
        out.print(rset.getFloat("latitude") + ",");
        out.print(rset.getFloat("longitude") + ");");
        out.print("</script>");

        out.print("<div style=\"width:800px; height:200px;\">");

        out.print("<div style=\"float:left; width:350px; height: 193px; padding-left: 15px; padding-top: 7px; background-color:#eeeeee;\">");
        out.print("<h2>");
        out.print(rset.getString("name"));
        out.print("</h2>");
         
        //--------------------------------------------------
        //STARS---------------------------------------------
        out.print("<div class=\"stars\" style=\"margin-top: 8px;\">");
        double sd = rset.getDouble("avg_rating");
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
        
        out.print("<div style=\"width: 140px; height: 24px; margin-top: 14px; margin-left: 10px; float:left;\">");
        out.print(rset.getInt("num_reviews") + " reviews");
        out.print("</div>");
            
            
            
            
        out.print("<div style=\"margin-top:8px;\">");
            
        
        out.print(rset.getString("address_1") + "\n");
        out.print(rset.getString("address_2"));
        
        out.print("</div>");
        
        //info div end
        out.print("</div>");
            
            
            //out.print("<div style=\"float: left; overflow:hidden; width:435px; height: 200px;\">");
            
            /*-- MAPS --*/
            out.print("<div id=\"map-canvas\" style=\"float: left; width:435px; height: 200px;\">");
            
            out.print("</div>");
            
            //resultRow div end
            out.print("</div>");
            
            /*--------------- PHOTOS ---------------*/
            /*out.print("<div style=\"width:800px; height:200px; overflow:hidden; background-color:#E9F1F5;\">");
            try {
                sql = "select url from Photos where rid='" + rid + "'";
                pstmt = conn.prepareStatement(sql);
                pstmt.clearParameters();
                pset = pstmt.executeQuery();

                out.print("<div style=\"width:1200px; height:200px;\">");
                String photo;
                while(pset.next()) {
                    photo = pset.getString("url");
                    out.print("<div style=\"float: left;\">");
                    out.print("<img height=\"200\" src=\"" + photo + "\">");
                    out.print("</div>");
                }
                out.print("</div>");
            } catch (SQLException e) {
                error_msg = e.getMessage();
                System.out.println(error_msg);
            }
            out.print("</div>");*/

    } else {
        out.print(error_msg);
    }
    
    
    out.print("<div style=\"margin: 10px 0px;\">");
    
    out.print("<div style=\"margin-top: 10px; float:right;\">");
    
    out.print("<form name=\"reviewForm\" action=\"submission.jsp\" method=\"GET\">");
    out.print("<input type=\"hidden\" name=\"p_id\" value=\"" + p_id + "\">");
    out.print("<a href=\"javascript:gotoreview()\" class=\"button\"\">Write a Review</a>");
    out.print("</form>");
    
    out.print("</div>");

    
    out.print("<div style=\"clear:both;\"></div>");
    out.print("</div>");
    %>

    <!-- --------------------------------------------------- -->
    <!-- REVIEWS SECTION -->
    <!-- --------------------------------------------------- -->
    <div class="reviews" style="margin-top:30px; margin-left:10px;">
    Reviews
    </div>
    
    <%
    if (revset != null) {
        
        while (revset.next()) {
    
            out.print("<div class=\"reviewRow\">");
            
            
            //STARS---------------------------------------------
            out.print("<div class=\"stars\">");
            double sd = revset.getDouble("rating");
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
            
            out.print("<div style=\"width: 600px; height: 30px; float:right; position:relative;\">");
            out.print("<div style=\"height: 20px; position:absolute; bottom:0; right:5px;\" class=\"boldTxt\">" + revset.getDate("date") + "</div>");
            out.print("</div><div style=\"clear:both;\"></div>");

            
            out.print("<div class=\"boldTxt\" style=\"padding: 10px;\">");
            out.print("anonymous says:");
            out.print("</div>");
            
            out.print("<div style=\"padding: 10px;\">");
            out.print(revset.getString("review_text"));
            out.print("</div>");
            
            
            /* delete review */
           /* if(uid != null && uid.equals(revset.getString("uid"))) {
                out.print("<div style=\"text-align:right; padding-right:5px;\">");
                out.print("<form name=\"deleteForm\" action=\"deleteReview.jsp\" method=\"POST\">");
                out.print("<input type=\"hidden\" name=\"rid\" value=\"" + rid + "\">");
                out.print("<input type=\"hidden\" name=\"uid\" value=\"" + uid + "\">");
                out.print("<input type=\"hidden\" name=\"stars\" value=\"" + revset.getDouble("n_Stars") + "\">");
                out.print("<a href=\"javascript:gotodelete()\"\">[delete]</a>");
                out.print("</form>");
                out.print("</div>");
            }*/
            
            
            
            out.print("</div>");

        }
    } else {
        out.print(error_msg);
    }
    if( conn != null )
        conn.close();
    if (pstmt != null)
        pstmt.close();
    %>
    </div>
<%@include file="footer.jsp" %>
</body>
</html>