<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>
    <%@include file="head.jsp" %>
    <link rel="stylesheet" href="css/contact.css">
  </head>


<body>
<%@include file="header.jsp" %>
<center>
  <div class="black-theme-contact-container">
        <h1 class="black-theme-contact-title">Contact Us</h1>
        <p class="black-theme-contact-description">
            Reach out to us with your questions or support requests.
        </p>
        <form method="post" >
            <table class="black-theme-contact-table">
                <tr>
                    <td><label for="black-theme-name" class="black-theme-label">Name:</label></td>
                    <td><input type="text" id="black-theme-name" name="name" placeholder="Enter your name" required class="black-theme-input"></td>
                </tr>
                <tr>
                    <td><label for="black-theme-email" class="black-theme-label">Email:</label></td>
                    <td><input type="email" id="black-theme-email" name="email" placeholder="Enter your email" required class="black-theme-input"></td>
                </tr>
                <tr>
                    <td><label for="black-theme-subject" class="black-theme-label">Subject:</label></td>
                    <td><input type="text" id="black-theme-subject" name="subject" placeholder="Enter subject" required class="black-theme-input"></td>
                </tr>
                <tr>
                    <td><label for="black-theme-message" class="black-theme-label">Message:</label></td>
                    <td><textarea id="black-theme-message" name="message" rows="5" placeholder="Enter your message" required class="black-theme-textarea"></textarea></td>
                </tr>
                <tr>
                    <td colspan="2" class="black-theme-submit-cell">
                        <button type="submit" class="black-theme-btn-submit" name="btnsave">Submit</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
 </center>  
 
</body>
</html>
