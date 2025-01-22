<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Track Your Request</title>
    <%@include file="head.jsp" %>
    <link rel="stylesheet" type="text/css" href="styles/track.css">
</head>
<body>
<%@include file="header.jsp" %>
<center>
    <div class="loader-overlay" id="loader">
        <div class="loader"></div>
        <div class="loader-message" id="loaderMessage">Loading...</div>
    </div>
    <h1>Track Your Request</h1>
    <div class="tracker-container">
        <% 
        	int status =0;
        	int sid;
            try {
                int uid = (Integer) session.getAttribute("uid");
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");
                PreparedStatement ps = con.prepareStatement(
                	    "SELECT request.status, serviceprovider.sfname, serviceprovider.slname " +
                	    "FROM request " +
                	    "JOIN serviceprovider ON request.sid = serviceprovider.sid " +
                	    "WHERE request.uid = ? AND request.status < 4"
                	);
					ps.setInt(1, uid);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    status = rs.getInt("status");
                } 
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            System.out.println(status);
          %>
          <% 
            if (status == 4) { %>
            <div class="no-request">
                <h2>No active request sent.</h2>
                <p>Please initiate a new request if needed.</p>
            </div>
        <% } else { %>
            <div class="tracker-step <%= status >= 0 ? "active" : "" %>">
                <div class="tracker-circle"></div>
                <div class="tracker-label">Request Sent</div>
            </div>
            <div class="tracker-step <%= status >= 1 ? "active" : "" %>">
                <div class="tracker-circle"></div>
                <div class="tracker-label">Request Approved</div>
            </div>
            <div class="tracker-step <%= status >= 2 ? "active" : "" %>">
                <div class="tracker-circle"></div>
                <div class="tracker-label">Service Provider Coming</div>
            </div>
            <div class="tracker-step <%= status >= 3 ? "active" : "" %>">
                <div class="tracker-circle"></div>
                <div class="tracker-label">Service Provider Reached</div>
            </div>
            <div class="tracker-step <%= status == 4 ? "active" : "" %>">
                <div class="tracker-circle"></div>
                <div class="tracker-label">Payment Completed</div>
            </div>
        </div>

        <div id="tracker-status" class="tracker-status">
            <%= status == 0 ? "Request Sent" :
                status == 1 ? "Request Approved" :
                status == 2 ? "Service Provider Coming" :
                status == 3 ? "Service Provider Reached" : "" %>
        </div>
     
        <% } %>
      
        
        
    
    </div>
</center>
</body>
</html>
