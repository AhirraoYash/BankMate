<%@page import="java.sql.*"%>
<%@page import="classfile.Mylib" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Request History</title>
<%@include file="head.jsp" %>
</head>
<body>
<%@include file="header.jsp" %>

<% 
int pin = (Integer) session.getAttribute("pin");
int sid = (Integer) session.getAttribute("sid");
Statement stmt = null;
Connection con = null;
ResultSet rs = null;
boolean hasRequests = false;

try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");
    String str = "SELECT request.rid, request.amount, request.mode, dbuser.ufname, dbuser.ulname, dbuser.uphone " +
                 "FROM request " +
                 "JOIN dbuser ON request.uid = dbuser.uid " +
                 "WHERE request.pin = " + pin + " AND request.status = 0";
    stmt = con.createStatement();
    rs = stmt.executeQuery(str);

    if (request.getParameter("btnaccept") != null) {
        String rid = request.getParameter("rid");
        Mylib obj = new Mylib(); 
        String updateQuery = "UPDATE request SET sid = " + sid + ", status = 1 WHERE rid = " + rid;
        obj.dml(updateQuery);
        %>
        <script>
        window.location.href = "acceptRequest.jsp";
        </script>
    <% 
    }
%>

<section class="history">
    <h1>Pending Requests</h1>
    <% if (rs.isBeforeFirst()) { %>
    <table class="history-table">
        <thead>
            <tr>
                <th>Amount</th>
                <th>Type</th>
                <th>Customer Name</th>
                <th>Mobile Number</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <form method="post">
                <tr>
                    <td>Rs. <%= rs.getString("amount") %></td>
                    <td><%= rs.getInt("mode") == 0 ? "Cash" : "Online" %></td>
                    <td><%= rs.getString("ufname") + " " + rs.getString("ulname") %></td>
                    <td><%= rs.getString("uphone") %></td>
                    <td class="action-buttons">
                        <input type="hidden" name="rid" value="<%= rs.getInt("rid") %>">
                        <button name="btnaccept">Accept</button>
                        <button name="btnreject" disabled>Reject</button>
                    </td>
                </tr>
            </form>
            <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p class="no-request">No pending requests at the moment.</p>
    <% } %>
</section>

<%
 
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>

</body>
</html>
