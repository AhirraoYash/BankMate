<%@page import="classfile.Mylib"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Mate</title>
    <%@ include file="head.jsp" %>
    <style>
        /* Add your CSS styling here if needed */
    </style>
    <script>
        function showLoaderAndRedirect() {
            // Show loader overlay
            document.getElementById("loader-overlay").style.display = "flex";

            // Redirect to track.jsp after 5 seconds
            setTimeout(function () {
                window.location.href = "track.jsp";
            }, 5000); // 5 seconds
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <!-- Loader Overlay -->
    <div id="loader-overlay" class="loader-overlay" style="display: none;">
        <div class="loader"></div>
        <div class="loader-message">Searching service provider...</div>
    </div>

    <!-- Main Content Section -->
    <div class="container">
        <div class="content">
            <h1>Experience convenience with BankMate</h1>
            <p>Get cash delivered to you with just a few clicks.</p>
            <form method="post">
                <div class="input-group">
                    <label for="amount">Enter the amount you need</label>
                    <input type="number" id="amount" name="amount" placeholder="Amount" required>
                </div>
                <div class="input-group">
                    <label for="location">Enter your Pin code</label>
                    <input type="text" id="location" name="location" placeholder="Pin code" pattern="\d{6}" title="Please enter a 6-digit pin code" required>

                </div>
                <button type="submit" name="btnCash" value="cash">Request Cash</button>
                <button type="submit" name="btnOnline" value="online" class="online-money-btn">Request Online Money</button>
            </form>
        </div>
        <div class="image-section">
            <img src="img/img.png" alt="Image">
        </div>
    </div>

    <%
    if (request.getParameter("btnCash") != null || request.getParameter("btnOnline") != null) {
        if (session.getAttribute("semail") == null) {
            // check login or not
            response.sendRedirect("login.jsp");
        } else {
            try {
            		Mylib obj=new Mylib();
            	    int uid = (int) session.getAttribute("uid");
            		String qr="select * from request where uid="+uid+"and status<4";
            		if(!obj.exists(qr)){
            			Mylib obj2=new Mylib();
			                int pin=Integer.parseInt(request.getParameter("location"));
            			    int amount = Integer.parseInt(request.getParameter("amount"));
                			int mode = request.getParameter("btnCash") != null ? 0 : 1; // cash = 0, online = 1
  	    		            int rstatus = 0; // Default request status
    	          			String s="select * from serviceprovider where spincode='"+pin+"'";
  	    		             
		            		    String qry = "INSERT INTO request (status, uid, amount, mode,pin) VALUES (" 
                    	          + rstatus + ", " + uid + ", " + amount + ", " + mode + ","+pin+")";
        		 			       obj2.dml(qry);
  	    		          
%>
                <script>
                    showLoaderAndRedirect();
                </script>
<%
            }else{
            	%>
            	<script>
            	alert("You already have an active request. Please wait until it is processed.");
            	</script>
            	<% 
            }
            } catch (Exception e) {
                e.printStackTrace(); // Log error for debugging
%>
                <p style="color: red;">An error occurred while processing your request. Please try again later.</p>
<%
            }
        }
    }  
    %>

    <%@ include file="footer.jsp" %>
</body>
</html>
