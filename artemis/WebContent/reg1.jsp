<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Online Registration</title>
</head>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@include file="init.jsp"%>
<body>

	<%
		String email = request.getParameter("email");
		String password1 = request.getParameter("password1");
		String password2 = request.getParameter("password2");
		String usr = request.getParameter("user");

		getServletContext().getRequestDispatcher("/register.jsp").include(
				request, response);
		PreparedStatement ps = null;
		ResultSet rs = null;

		//password and username not null
		if (!(email.equals(null) || email.equals(""))
				&& !(password1.equals(null) || password1.equals(""))) {
			try {
			    String sql;
			    
				if (usr.equals("old")) {
					/* ------------ login old user --------------- */
					
					sql = "select * from users where email='" + email + "' AND password='" + password1 + "'";
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					
					if (rs != null && rs.next()) {
						session.setAttribute("u_id", rs.getInt("u_id"));
						response.sendRedirect("index.jsp");
					} else {
						out.print("wrong login");
					}
					
					
					

				} else {
					//passwords match
					if (password1.equals(password2)) {
						//get random username --TO DO: RANDOMLY GENERATE USERNAMES
						String username = "Calliope";

						sql = "insert into users (email, username, password)";
						sql += "values ('" + email + "','" + username
								+ "','" + password1 + "')";
						ps = conn.prepareStatement(sql);
						int rows = ps.executeUpdate();

						//set the u_id in the setAttributes space
						int u_id = 0;

						try {
							//select the u_id that was just inserted into the users table
							String sql2 = "SELECT u_id from users where email='"
									+ email + "'";
							ps = null;
							ps = conn.prepareStatement(sql2);

							ResultSet set = ps.executeQuery();

							while (set.next()) {
								u_id = set.getInt("u_id");
							}

							if (u_id != 0) {
								session.setAttribute("u_id", u_id);
							} else {
								System.out.println("u_id of 0... error");
							}

						} catch (SQLException e) {
							error_msg = e.getMessage();
							System.out.println(error_msg);
						}

						//upon successful registration redirects to index/home page
						response.sendRedirect("index.jsp");
					} else {
					%>
					<center>
						<p style="color: red">Your passwords don't match.</p>
					</center>
				
					<%
				    }
				}

			} catch (SQLException sqe) {
				out.print(sqe);
			%>
			
			
			
			<center>
				<p style="color: red">Your account is already registered. Please
					login.</p>
			</center>
		
			<%
			  }
		} else {
			%>
			<center>
				<p style="color: red">Sorry, your registration is not complete!</p>
			</center>
			<%
		}
	%>

</body>
</html>