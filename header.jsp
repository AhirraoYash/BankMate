  <!-- Navbar Section -->
   <%@include file="head.jsp" %>
    <nav class="navbar">
        <div class="left-nav">
            <div class="logo"> BankMate </div>
            <ul class="nav-links">
            <%if(session.getAttribute("memail")!=null){ %>
            <li><a href="request.jsp">Request</a></li>
            <li><a href="serviceProviderHistory.jsp">History</a></li>
            <li><a href="acceptRequest.jsp">Accepted Request</a>
            <%}else{ %>
             
                <li><a href="request_cash.jsp">Request cash</a></li>
                 <% if(session.getAttribute("semail")!=null){ %>
                  <li><a href="track.jsp">Track Request</a></li>  
                <li><a href="history.jsp">History</a></li>
               <%} } %>
               
            </ul>
        </div>
        <div class="auth-buttons">
        <% if(session.getAttribute("semail")==null && session.getAttribute("memail")==null){ %>
            <a href="login.jsp" class="login-btn">Login</a>
            <a href="registration.jsp" class="signup-btn">Sign Up</a>
         <%}else{ %>
         	 <ul>Hello, <%out.println(session.getAttribute("uname")); %> </ul>
            <ul> <a href="logout.jsp" class="login-btn">Log Out</a></ul>
            
            <%} %>
        </div>
    </nav>
 