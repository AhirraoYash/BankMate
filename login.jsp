<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="classfile.Mylib"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - BankMate</title> <!-- Updated title -->
    <link rel="stylesheet" href="css/login.css">
    <%@include file="header.jsp" %>
</head>
<body>
    <section class="container">
        <div class="login-container">
            <div class="circle circle-one"></div>
            <div class="form-container">
                 <h1 class="opacity">LOGIN</h1>
                <form   method="POST"> <!-- Add form action -->
                    <input type="text" name="email" placeholder="USERNAME" aria-label="Username" required />
                    <input type="password" name="password" placeholder="PASSWORD" aria-label="Password" required />
                    <button type="submit" name="btnlogin" class="opacity">SUBMIT</button> <!-- Specify button type -->
                </form>
                <div class="register-forget opacity"><br>
                    <a href="registration.jsp">REGISTER</a><br><br> <!-- Link to registration page -->
                	 
                </div>
            </div>
            <div class="circle circle-two"></div>
        </div>
        <div class="theme-btn-container"></div>
    </section>
   <%
if(request.getParameter("btnlogin")!=null)
{
	String email=request.getParameter("email");
	String pass=request.getParameter("password");
	String admin="admin@gmail.com";
	String admin_password="admin";
	if(email.equals(admin) && pass.equals(admin_password)){
		System.out.println("amdin");
		 %>
	 		<script>	 
	 				alert("Login Sucessfully")
					window.location.href="admin/service_provider_request.jsp";
			</script>
			<%
	}
	System.out.println(email);
	System.out.println(pass);
	Mylib obj=new Mylib();
	Statement stmt=null;
	Connection con=null;
	ResultSet rs=null;
	Class.forName("org.postgresql.Driver");
	con=DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate","postgres","postgres");
	stmt=con.createStatement();
	 String checkQuery = "SELECT * FROM dbuser WHERE uemail = '" + email + "' AND upass = '" + pass + "'";
	 if(obj.exists(checkQuery)){
		 session.setAttribute("semail",email);
		 
			rs=stmt.executeQuery("select * from dbuser where uemail='"+session.getAttribute("semail")+"'");
			while(rs.next())
			{
				//start user session
					session.setAttribute("uid",rs.getInt("uid"));
					session.setAttribute("uname",rs.getString("ufname"));
					 
			}
			  %>
	 		<script>	 
	 				alert("Login Sucessfully")
					window.location.href="index.jsp";
			</script>
			<%
		}
		else{
			checkQuery = "SELECT * FROM serviceprovider WHERE semail = '" + email + "' AND spass = '" + pass + "'";
			if(obj.exists(checkQuery)){
				//start serviceprovider session
			 
				 session.setAttribute("memail",email);
					rs=stmt.executeQuery("select * from serviceprovider where semail='"+session.getAttribute("memail")+"'");
					while(rs.next())
					{
						if(rs.getInt("status")==0){
							%>
								<script>
									alert("Request Not Approved by admin");
								</script>
							<%
							
						}else{
							session.setAttribute("pin",rs.getInt("spincode"));
							session.setAttribute("sid",rs.getInt("sid"));
							session.setAttribute("uname",rs.getString("sfname"));
							 %>
						 		<script>	 
						 				alert("Login Sucessfully")
										window.location.href="request.jsp";
								</script>
								<%
						}
					}
					rs.close();
					stmt.close();
					con.close();
				
				}
				else{
			%>
			<script>
			alert("Invalid Credentials");
			</script>
			<%
				}
		}
	 }
   
   %>
</body>
</html>
