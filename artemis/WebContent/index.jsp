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
    
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="js/raphael.js"></script>
    <script src="js/color.jquery.js"></script>
    <script src="js/jquery.usmap.js"></script>
    <script type="text/javascript">
    
    //$(document).ready(function() {
    	/*$('#map').usmap({
            'stateSpecificStyles': {
              'AK' : {fill: '#f00'}
            },
            'stateSpecificHoverStyles': {
              'HI' : {fill: '#ff0'}
            },
            'stateStyles': {
            	fill: 'purple'},

            'stateHoverStyles': {
            	fill: 'red'}
            });*/
            
    
            
            $(document).ready(function() {
                $('#map').usmap({
                  /*'stateSpecificStyles': {
                    'AK' : {fill: '#f00'}
                  },*/
                  /*'stateSpecificHoverStyles': {
                  'HI' : {fill: '#ff0'}
                    },*/
                    
                  'stateStyles': {
                	  fill: '#777777',
                	  "stroke-width": 2,
                	  'stroke': '#666666'
                  },
                  'stateHoverStyles': {
                	  fill: '#192f5f'
                  },
                  
                  stateHoverAnimation: 100,
                  showLabels: false,
                  
                  'mouseoverState': {
                    'HI' : function(event, data) {
                      //return false;
                    }
                  },
                  
                  
                  'click' : function(event, data) {
                    $('#alert')
                      .text('Click '+data.name+' on map 1')
                      .stop()
                      .css('backgroundColor', '#ff0')
                      .animate({backgroundColor: '#ddd'}, 1000);
                  }
                });
                
                /*$('#map2').usmap({
                  'stateStyles': {
                    fill: '#025', 
                    "stroke-width": 1,
                    'stroke' : '#036'
                  },
                  'stateHoverStyles': {
                    fill: 'teal'
                  },
                  
                  'click' : function(event, data) {
                    $('#alert')
                      .text('Click '+data.name+' on map 2')
                      .stop()
                      .css('backgroundColor', '#af0')
                      .animate({backgroundColor: '#ddd'}, 1000);
                  }
                });*/
                
                $('#over-md').click(function(event){
                  $('#map').usmap('trigger', 'MD', 'mouseover', event);
                });
                
                $('#out-md').click(function(event){
                  $('#map').usmap('trigger', 'MD', 'mouseout', event);
                });
              });
        

    
    
    
    
    </script>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="mainDiv">
        <div id="map" style="padding-top: 50px; width: 800px; height: 800px;"></div>
    
        <div style="width: 800px; height: 150px; padding-top:50px; background-color:#ffffff;">
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