<%@page import="classfile.Mylib"%>
<html>
<body>
<%
Mylib obj=new Mylib();
obj.conOpen();
obj.dml("insert into dbuser(utitle,ufname,ulname,uphone,uemail,udistrict,utaluka,upincode,uplace,upass)values('Mr','Yash','Ahirrao','956147140','yash@gmail.com','dhule','sakri','424306','dhadane','Yash@2003')");


<script>
alert("Already Register Please Log in");
window.location.href="login.jsp";
</script>


%>
</body>
</html>
 
 
 request_cash.jsp *************************************************************************
 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Request Cash or Online Money</title>
<%@ include file="head.jsp" %>
<style>
.loader {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: inline-block;
  border-top: 4px solid #FFF;
  border-right: 4px solid transparent;
  box-sizing: border-box;
  animation: rotation 1s linear infinite;
}
.loader::after {
  content: '';  
  box-sizing: border-box;
  position: absolute;
  left: 0;
  top: 0;
  width: 48px;
  height: 48px;
  border-radius: 50%;
  border-bottom: 4px solid #FF3D00;
  border-left: 4px solid transparent;
}
@keyframes rotation {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
} </style>
</head>
<body>
<%@ include file="header.jsp" %>

 <!-- Main Content Section -->
    <div class="container">
        <div class="content">
            <h1>Experience convenience with BankMate</h1>
            <p>Get cash delivered to you with just a few clicks.</p>
            <span class="loader"></span>
            <form action="serviceProviderList.jsp" method="post">
                <div class="input-group">
                    <label for="location">Enter your Pin code</label>
                    <input type="number" id="location" name="location" placeholder="Your current Pin code" required>
                </div>
                <div class="input-group">
                    <label for="amount">Enter the amount you need</label>
                    <input type="number" id="amount" name="amount" placeholder="Amount" required>
                </div>
                <button type="submit" name="btnCash" value="cash">Request Cash</button>
                <button type="submit" name="btnOnline" value="online" class="online-money-btn">Request Online Money</button>
            </form>
        </div>
        <div class="image-section">
            <img src="img/img.png" alt=" ">
        </div>
    </div>

<%@ include file="footer.jsp" %>

</body>
</html>
 
 
 ************************************ progress bar ************************************
 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Searching Service Provider</title>
<style>
/* Fullscreen Progress Bar Overlay */
body {
  margin: 0;
  font-family: Arial, sans-serif;
  background-color: #111;
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

h1 {
  font-size: 24px;
  margin-bottom: 20px;
  text-align: center;
}

/* Progress Bar Container */
.progress-container {
  width: 80%;
  max-width: 600px;
  background-color: #444;
  border-radius: 8px;
  overflow: hidden;
}

/* Progress Bar */
.progress-bar {
  height: 20px;
  width: 0%;
  background-color: #4caf50;
  transition: width 0.3s linear;
}

/* Status Text */
.status-text {
  margin-top: 15px;
  font-size: 16px;
  text-align: center;
}
</style>
<script>
window.onload = function () {
  const progressBar = document.getElementById("progress-bar");
  let progress = 0;

  // Update progress bar every 300ms for 30 seconds
  const interval = setInterval(() => {
    progress += 1;
    progressBar.style.width = progress + "%";

    if (progress >= 100) {
      clearInterval(interval);
      // Redirect to trackrequest.jsp after completion
      window.location.href = "trackrequest.jsp";
    }
  }, 300); // 300ms * 100 = 30 seconds
};
</script>
</head>
<body>

<h1>Searching Service Provider...</h1>

<div class="progress-container">
  <div id="progress-bar" class="progress-bar"></div>
</div>

<div class="status-text">Please wait while we connect you with a service provider...</div>

</body>
</html>
 
 
 
    ************************************************************************** of user is not login
    /* if(request.getParameter("btnCash")!=null || request.getParameter("btnOnline")!=null){
	 if(session.getAttribute("semail") == null) 
	    { // check if the user is logged in
	    	 %>
	 		<script>
	 		 window.location.href="login.jsp";
	 		</script>
	 		<%
	       //response.sendRedirect("login.jsp");
	     
	    }
	 else{
		 showLoaderAndRedirect();
	 }
		
//	************************************************************************************
} */

******************************************************************

  // Handle form submission
        if (request.getParameter("btnCash") != null || request.getParameter("btnOnline") != null) {
            if (session.getAttribute("semail") == null) {
                // Redirect to login page if user is not logged in
                response.sendRedirect("login.jsp");
            } else {
                try {
                    // Get form data and session data
                    int amount = Integer.parseInt(request.getParameter("amount"));
                    int mode = request.getParameter("btnCash") != null ? 0 : 1; // cash = 0, online = 1
                    int rstatus = 0; // Default request status
                      // Get user ID from session
                    int uid = (int) session.getAttribute("uid");
                    // Insert data into the request table
                    Mylib obj = new Mylib();
                    String qry = "INSERT INTO request (rstatus, uid, amount, mode,status) VALUES (" 
                                  + rstatus + ", " + uid + ", " + amount + ", " + mode + ","+rstatus+")";
                    obj.dml(qry);

    %>
                    <script>
                        showLoaderAndRedirect();
                    </script>
    <%
                } catch (Exception e) {
                    e.printStackTrace(); // Log error for debugging
    %>
                    <p style="color: red;">An error occurred while processing your request. Please try again later.</p>
    <%
                }
            }
        }