<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Provider List</title>
    <link rel="stylesheet" href="css/serviceproviderlist.css">
    <%@ include file="head.jsp" %>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="page-container">
        <div class="main-content">
            <div class="provider-list">
                <h2>Available Service Providers</h2>
                <div class="provider-item">
                    <div class="details">
                        <h3>Provider Name 1</h3>
                        <p>Location: Location 1</p>
                        <p>Available for: Cash Delivery</p>
                    </div>
                    <button class="action-btn">Request Service</button>
                </div>
                <div class="provider-item">
                    <div class="details">
                        <h3>Provider Name 2</h3>
                        <p>Location: Location 2</p>
                        <p>Available for: Cash Delivery</p>
                    </div>
                    <button class="action-btn">Request Service</button>
                </div>
                <!-- Add more providers as necessary -->
            </div>
        </div>
        
        <div class="image-wrapper">
            <img src="img/service-provider.png" alt="Service Provider Image">
        </div>
    </div>

    <footer class="page-footer">
        <p>&copy; 2024 BankMate. All rights reserved.</p>
    </footer>

</body>
</html>
