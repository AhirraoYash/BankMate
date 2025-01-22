<%@page import="java.sql.*"%>
<%@page import="classfile.Mylib" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transaction History</title>
<%@include file="head.jsp" %>
</head>
<body>
<%@include file="header.jsp" %>
<%
    int uid = (Integer) session.getAttribute("uid");
    Statement stm = null;
    Connection con = null;
    ResultSet rs = null;
    try {
        Class.forName("org.postgresql.Driver");
        con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/BankMate", "postgres", "postgres");
        String query = "SELECT request.rid, request.amount, request.status, request.mode, serviceprovider.sfname, serviceprovider.slname, serviceprovider.sphone " +
                       "FROM request " +
                       "JOIN serviceprovider ON request.sid = serviceprovider.sid " +
                       "WHERE request.uid = ? AND request.status >=0";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, uid);
        rs = pstmt.executeQuery();
%>
<section class="history">
    <h1>Transaction History</h1>
    <table class="history-table">
        <thead>
            <tr>
                <th>Amount</th>
                <th>Charges</th>
                <th>Type</th>
                <th>Agent Name</th>
                <th>Phone</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody align="center">
            <% 
                while (rs.next()) {
                    int rid = rs.getInt("rid");
                    double amount = rs.getDouble("amount");
                    int mode = rs.getInt("mode");
                    String sfname = rs.getString("sfname");
                    String slname = rs.getString("slname");
                    String sphone = rs.getString("sphone");
                    double charges = amount * 0.05;
                    int status = rs.getInt("status");
                    String modeText = mode == 1 ? "Online Money" : "Cash";

                    // Map status to text
                    String statusText;
                    switch (status) {
                        case 0: statusText = "Pending"; break;
                        case 1: statusText = "Request Approved"; break;
                        case 2: statusText = "Service Provider Coming"; break;
                        case 3: statusText = "Reached"; break;
                        case 4: statusText = "Payment Completed"; break;
                        default: statusText = "Unknown Status";
                    }
            %>
            <tr>
                <td>Rs. <%= amount %></td>
                <td>Rs. <%= charges %></td>
                <td><%= modeText %></td>
                <td><%= sfname + " " + slname %></td>
                <td><%= sphone %></td>
                <td><%= statusText %></td>
            </tr>
            <% 
                } 
            %>
        </tbody>
    </table>
</section>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stm != null) stm.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
