<%@page import="java.sql.*"%>
<%@page import="classfile.Mylib" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Completed Requests History</title>
    <%@include file="head.jsp" %>
    <style>
        .header-title {
            text-align: center;
            color: #00ffcc;
            margin: 20px 0;
        }
        .data-table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #222;
            color: #fff;
        }
        .data-table th, .data-table td {
            border: 1px solid #444;
            padding: 10px;
            text-align: center;
        }
        .data-table th {
            background-color: #333;
        }
        .data-table tr:nth-child(even) {
            background-color: #111;
        }
    </style>
</head>
<%@include file="header.jsp" %>
<body>

<% 
int sid = (Integer) session.getAttribute("sid");
Statement stmt = null;
Connection con = null;
ResultSet rs = null;

try {
    Class.forName("org.postgresql.Driver");
    con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");
    String query = "SELECT request.rid, request.amount, request.status, request.mode, dbuser.ufname, dbuser.ulname, dbuser.uphone " +
                   "FROM request " +
                   "JOIN dbuser ON request.uid = dbuser.uid " +
                   "WHERE request.sid = ? AND request.status = 4"; // Only completed requests (status = 4)
    PreparedStatement pstmt = con.prepareStatement(query);
    pstmt.setInt(1, sid);
    rs = pstmt.executeQuery();
%>

    <h1 class="header-title">Completed Requests</h1>
    <table class="data-table">
        <thead>
            <tr>
                <th>Amount</th>
                <th>Mode</th>
                <th>Customer Name</th>
                <th>Mobile Number</th>
                <th>Completion Status</th>
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

                String modeText = mode == 1 ? "Online Money" : "Cash";
            %>
            <tr>
            
                <td>Rs. <%= amount %></td>
                <td><%= modeText %></td>
                <td><%= ufname + " " + ulname %></td>
                <td><%= uphone %></td>
                <td>Completed</td>
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
