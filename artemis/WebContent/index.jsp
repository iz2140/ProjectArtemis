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
    
    
            
            $(document).ready(function() {
                $('#map').usmap({
                  /*'stateSpecificStyles': {
                    'AK' : {fill: '#f00'}
                  },*/
                  /*'stateSpecificHoverStyles': {
                  'HI' : {fill: '#ff0'}
                    },*/
                    
                  'stateStyles': {
                	  fill: '#aaaaaa',
                	  "stroke-width": 2,
                	  'stroke': '#999999'
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
                    alert(data.name);
                	  /*$('#alert')
                      .text('Click '+data.name+' on map 1')
                      .stop()
                      .css('backgroundColor', '#ff0')
                      .animate({backgroundColor: '#ddd'}, 1000);*/
                  }
                });
            });
                

    </script>
</head>
<body>
    <%@include file="header.jsp" %>
    <div class="mainDiv">
        <div id="map" style="padding-top: 50px; width: 800px; height: 550px;"></div>
    

        <div style="width: 800px; height: 400px; padding-top:50px; background-color:#ffffff;">
            <div style="width:540px; margin:0px auto;">
                <div>
                    <div class="title" style="height:32px;">I am looking for:</div>

                    <form name = "advanced_search" action="results.jsp" method="get">
				    <input type="checkbox" name="service" value="abortion"> Abortion Services<br>
				    <input type="checkbox" name="service" value="contraception"> Birth Control/Contraception<br>
				    <input type="checkbox" name="service" value="counseling"> Counseling<br>
				    <input type="checkbox" name="service" value="domestic_violence"> Domestic Violence<br>
				 	<input type="checkbox" name="service" value="low_cost"> Low Cost<br>
				 	<input type="checkbox" name="service" value="pregnancy"> Pregnancy Testing<br>
				 	<input type="checkbox" name="service" value="sexual_assault"> Sexual Assault<br>
				 	<input type="checkbox" name="service" value="std"> STD and Sexual Health Services<br>
				    <br>
					<br>
					in: <input type = "text" placeholder = "City" name = "city" style="width:200px;">, 
					<select name = "st">
						<option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option>
						<option value="CA">California</option>
						<option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="DC">District Of Columbia</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PA">Pennsylvania</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option>
					</select> or 
					<input type="text" placeholder = "Zipcode" name = "zipcode" style="width:100px;">			
					<br>
					<br>
					Age: 
					<input type="radio" name="age" value="under">Under 18
					<input type="radio" name="age" value="over">18+
					<br>
					<br>
				    <input type="submit" value="Go">
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
        
   
<%@include file="footer.jsp" %>

</body>
</html>