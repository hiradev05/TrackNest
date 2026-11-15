<%
    if (session.getAttribute("customerID") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<%@ page import="java.util.List" %>
<%@ page import="com.tracknest.model.Order" %>

<%
    if (session.getAttribute("customerID") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Order> orders =
        (List<Order>) request.getAttribute("orders");

    String customerName =
        (String) session.getAttribute("customerName");
%>

<!DOCTYPE html>
<html>
<head>
    <title>TrackNest | Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<header>
    <h1>TrackNest</h1>
    <nav>
        <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </nav>
</header>

<main>
    <h2>Welcome, <%= customerName %>!</h2>
    <p>Your centralized order tracking dashboard.</p>

    <h3>My Orders</h3>

    <% if (orders == null || orders.isEmpty()) { %>

        <p>You have no orders yet.</p>

    <% } else { %>

        <table border="1" cellpadding="10">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Store</th>
                    <th>Order Number</th>
                    <th>Order Date</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody>
                <% for (Order order : orders) { %>
                    <tr>
                        <td><%= order.getOrderID() %></td>
                        <td><%= order.getStoreName() %></td>
                        <td>
                            <a href="<%= request.getContextPath() %>/track?orderId=<%= order.getOrderID() %>">
                                <%= order.getOrderNumber() %>
                            </a>
                        </td>
                        <td><%= order.getOrderDate() %></td>
                        <td><%= order.getOrderStatus() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

    <% } %>

</main>

</body>
</html>
