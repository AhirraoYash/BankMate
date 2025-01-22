<%@page import="java.sql.*"%>
<%@page import="classfile.Mylib" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Provider Dashboard</title>
    <%@include file="head.jsp" %>
    <style>
        
     
    </style>
</head>
<%@include file="header.jsp" %>
<body>

<% 
int pin = (Integer) session.getAttribute("pin");
Statement stmt = null;
Connection con = null;
ResultSet rs = null;

try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");

    String ridParam = request.getParameter("rid");
    String statusParam = request.getParameter("status");
    if (ridParam != null && statusParam != null) {
        int rid = Integer.parseInt(ridParam);
        int newStatus = Integer.parseInt(statusParam);

        String updateQuery = "UPDATE request SET status = ? WHERE rid = ?";
        PreparedStatement pstmt = con.prepareStatement(updateQuery);
        pstmt.setInt(1, newStatus);
        pstmt.setInt(2, rid);
        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            out.println("<p style='color: green; text-align: center;'>Status updated successfully!</p>");
        }
        pstmt.close();
    }

    String query = "SELECT request.rid, request.amount, request.status, request.mode, dbuser.ufname, dbuser.ulname, dbuser.uphone " +
                   "FROM request " +
                   "JOIN dbuser ON request.uid = dbuser.uid " +
                   "WHERE request.pin = ? AND request.status > 0 and request.status!=4";
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setInt(1, pin);
    rs = pstmt.executeQuery();
%>

    <h1 class="header-title">Accepted Requests</h1>
    <table class="data-table">
        <thead>
            <tr>
                <th>Request ID</th>
                <th>Amount</th>
                <th>Charges</th>
                <th>Mode</th>
                <th>Customer Name</th>
                <th>Mobile Number</th>
                <th>Current Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
            while (rs.next()) {
                int rid = rs.getInt("rid");
                double amount = rs.getDouble("amount");
                int mode = rs.getInt("mode");
                String ufname = rs.getString("ufname");
                String ulname = rs.getString("ulname");
                String uphone = rs.getString("uphone");
                int status = rs.getInt("status");

                String statusText = "";
                if (status == 1) {
                    statusText = "Accepted";
                } else if (status == 2) {
                    statusText = "Coming";
                } else if (status == 3) {
                    statusText = "Reached";
                } else if (status == 4) {
                    statusText = "Completed";
                }

                String modeText = mode == 1 ? "Online Money" : "Cash";
                double charges = amount * 0.05;
            %>
            <tr>
                <td><%= rid %></td>
                <td>Rs. <%= amount %></td>
                <td>Rs. <%= charges %></td>
                <td><%= modeText %></td>
                <td><%= ufname + " " + ulname %></td>
                <td><%= uphone %></td>
                <td><%= statusText %></td>
                <td>
                    <% if (status < 4) { %>
                        <form method="post">
                            <input type="hidden" name="rid" value="<%= rid %>">
                            <input type="hidden" name="status" value="<%= status + 1 %>">
                            <button class="action-button">Move to Next Status</button>
                        </form>
                    <% } else { %>
                        <button class="action-button" disabled>Completed</button>
                    <% } %>
                </td>
            </tr>
            <% 
            } 
            %>
        </tbody>
    </table>

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
