
<%@ page import="java.util.List" %>
<%@ page import="com.tracknest.model.Order" %>

<%
    if (session.getAttribute("customerID") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String customerName = (String) session.getAttribute("customerName");
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

<header class="navbar">
    <div class="container">
        <a class="logo" href="<%= request.getContextPath() %>/dashboard">
            TrackNest
        </a>

        <nav class="nav-links">
            <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="container page-section">

    <div class="dashboard-header">
        <div>
            <h2 class="page-title">
                Welcome, <%= customerName %>!
            </h2>
            <p class="page-subtitle">
                Manage and track all your orders in one place.
            </p>
        </div>
    </div>

    <section class="dashboard-card">

        <h3>My Orders</h3>
        <p class="page-subtitle">Your centralized order overview.</p>

        <% if (orders == null || orders.isEmpty()) { %>

            <p>You have no orders yet.</p>

        <% } else { %>

            <div class="form-group">
                <input
                    type="text"
                    id="orderSearch"
                    placeholder="Search by order number, store or status..."
                    aria-label="Search orders">
            </div>

            <div class="table-container">
                <table id="ordersTable">
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
                                <td>
                                    <span class="status">
                                        <%= order.getOrderStatus() %>
                                    </span>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <p id="noSearchResults" style="display:none; margin-top:15px;">
                No matching orders found.
            </p>

        <% } %>

    </section>

</main>

<footer class="footer">
    <p>TrackNest &copy; 2026 | Centralized Multi-Platform Order Tracking</p>
</footer>

<script src="<%= request.getContextPath() %>/js/script.js"></script>

</body>
</html>
