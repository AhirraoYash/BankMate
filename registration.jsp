<%@page import="classfile.Mylib"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="css/registration.css">
</head>
<body>
<%@include file="header.jsp" %>
<form method="POST">
    <div class="registration-page">
        <div class="form-container">
            <div class="form-section general-info">
                <h2>General Information</h2>
                <div class="form-group">
                    <label for="title">Prefix </label>
                    <select id="title" name="title">
                        <option value="">Select Prefix </option>
                        <option value="mr">Mr</option>
                        <option value="mrs">Mrs</option>
                        <option value="miss">Miss</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="first-name">First Name</label>
                    <input type="text" id="first-name" name="fname" placeholder="First Name" required="required">
                </div>

                <div class="form-group">
                    <label for="last-name">Last Name</label>
                    <input type="text" id="last-name" name="lname" placeholder="Last Name" required="required">
                </div>

                <div class="form-group">
                    <label for="phone-number">Phone Number</label>
                    <input type="text" id="phone-number" name="phone" placeholder="Phone Number" required pattern="\d{10}">
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Your Email" required pattern="^[a-zA-Z0-9._%+-]+@gmail\.com$">
                </div>
            </div>

            <div class="form-section contact-details">
                <h2>Contact Details</h2>
                <div class="form-group">
                    <label for="district">District</label>
                    <input type="text" id="district" name="district" placeholder="Your District" required="required">
                </div>

                <div class="form-group">
                    <label for="place">City</label>
                    <input type="text" id="place" name="place" placeholder="Place" required="required">
                </div>
                <div class="form-group">
                    <label for="pin-code">Pin Code</label>
                    <input type="text" id="pin-code" name="pincode" placeholder="Pin Code" required pattern="\d{6}">
                </div>

                

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter Password" required="required">
                </div>
		<!-- 
		minlength="8" 
           maxlength="16" 
           pattern="(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}" 
		 -->
                <div class="form-group">
                    <label for="category">Select Category</label>
                    <select id="category" name="category">
                        <option value="1">Customer</option>
                        <option value="2">Service provider</option>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit" name="btnsave" class="btnsave">Register</button>
                </div>

                <p class="already-registered">Already registered? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>
</form>

<%
try { 
	if (request.getParameter("btnsave") != null) {
        
        String title = request.getParameter("title");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String district = request.getParameter("district");
        String place = request.getParameter("place");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String pincodeStr = request.getParameter("pincode");
        String categoryStr = request.getParameter("category");
        int status=0;
         

         
        if (title.isEmpty() || fname.isEmpty() || lname.isEmpty() || email.isEmpty() ||
            district.isEmpty() || place.isEmpty() || password.isEmpty() || phone.isEmpty() || 
            pincodeStr.isEmpty() || categoryStr.isEmpty()) {
%>
            <script>
                alert("All fields are required. Please fill in all fields.");
                window.history.back();
            </script>
<%
        } else {
           
            int pincode = Integer.parseInt(pincodeStr);
            int category = Integer.parseInt(categoryStr);

      
            Mylib l1 = new Mylib();
            String checkQuery = "SELECT * FROM dbuser WHERE uemail = '" + email + "'";
            String QueryS="SELECT * FROM serviceprovider WHERE semail = '" + email + "'";
            if (l1.exists(checkQuery)) {
%>
                <script>
                    alert("Already Registered. Please Log in");
                    window.location.href = "login.jsp";
                </script>
<%
            } else {
            	String insertQuery="";
                // Insert new user
           if(category==1){ //if customer
                  insertQuery = "INSERT INTO dbuser (utitle, ufname, ulname, uphone, uemail, udistrict, upincode, uplace, upass) "
                        + "VALUES ('" + title + "', '" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" 
                        + district + "', '" + pincode + "', '" + place + "', '" + password + "')";
           }
           else{
        	    insertQuery = "INSERT INTO serviceprovider (stitle, sfname, slname, sphone, semail, sdistrict, spincode, splace, spass,status) "
                       + "VALUES ('" + title + "', '" + fname + "', '" + lname + "', '" + phone + "', '" + email + "', '" 
                       + district + "', '" + pincode + "', '" + place + "', '" + password + "','"+status+"')";
           }
        	   
           
                l1.dml(insertQuery);
%>
                <script>
                    alert("Registration Successful");
                    window.location.href = "login.jsp";
                </script>
<%
            }
        }
    }
} catch (Exception e) {
    e.printStackTrace();
%>
    <script>
        alert("An error occurred. Please try again later.");
    </script>
<%
}
%>
</body>
</html>
