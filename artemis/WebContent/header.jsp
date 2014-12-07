<div style="position:fixed; top: 0; width:100%; height:120px; padding-top: 2px; background-color:#dadee8; z-index:999;">
        <div style="width: 800px; margin: 0px auto;">
            <div style="float:left">
                <a href="index.jsp"><img src="img/logo.png" style="margin-left:12px;" /></a>
            </div>
            
        </div>
        <div style="clear:both;"></div>
        <div style="width:100%; margin-top: 20px; height: 30px; background-color:#192f5f;">
                <div style="padding-top:5px; width: 800px; height: 30px; margin: 0px auto;">
	                <div class="navlinks" style="margin-left:34px;"><a href="index.jsp#stateInfoDiv">find help</a></div>
	                <div class="navlinks"><a href="stories.jsp">read stories</a></div>
	                <div class="navlinks" style="margin-left:8px;"><a href="index.jsp">contact</a></div>
	                
	                <div class="navlinks" style="float:right;">
                <%
                String uname = (String)session.getAttribute("email");
                if (uname != null) {
                    out.print("Hi artemis. ");
                    out.print("<a href=\"index.jsp\" class=\"dblogin\">Logout</a>");
                } else {
                    out.print("<a href=\"LoginHome.jsp\" class=\"dblogin\">Log In/Sign Up!</a>");
                }  
                %>
            </div>
	                
                </div>
        </div>
        
</div>