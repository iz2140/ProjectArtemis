<div style="position:fixed; top: 0; width:100%; height:84px; padding-top: 2px; background-color:#dadee8; z-index:999;">
        <div style="width: 800px; margin: 0px auto;">
            <a href="index.jsp"><img src="img/logo.png" style="margin-left:12px;" /></a>
        </div>
        <div style="float:right; margin-top:14px; padding-right:12px;">
        <%
        String uname = (String)session.getAttribute("email");
        if (uname != null) {
            out.print("Hi " + uname + "! | ");
/*             out.print("<a href=\"welcome.jsp\" class=\"dblogin\">Profile</a>");
            out.print(" | "); */
            //can you edit this to re-route to index.jsp and just set uname to null?
            out.print("<a href=\"index.jsp\" class=\"dblogin\">Logout</a>");

        } else {
            out.print("<a href=\"LoginHome.jsp\" class=\"dblogin\">Log In/Sign Up!</a>");
        }  
        %>
        </div>
        <div style="clear:both;"></div>
</div>