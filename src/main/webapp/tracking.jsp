
<%@ page import="com.tracknest.model.Order" %>
<%@ page import="com.tracknest.model.Shipment" %>
<%@ page import="com.tracknest.model.TrackingInfo" %>
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("customerID") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Order order = (Order) request.getAttribute("selectedOrder");
    Shipment shipment = (Shipment) request.getAttribute("shipment");

    List<TrackingInfo> events =
        (List<TrackingInfo>) request.getAttribute("trackingEvents");

    if (order == null) {
        response.sendError(404);
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Shipment Tracking | TrackNest</title>
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

    <a class="btn btn-secondary"
       href="<%= request.getContextPath() %>/dashboard">
        &larr; Back to Dashboard
    </a>

    <h2 class="page-title" style="margin-top:25px;">
        Shipment Tracking
    </h2>

    <p class="page-subtitle">
        View your order and follow its shipment progress.
    </p>

    <section class="dashboard-card">
        <h3>Order Information</h3>

        <p><strong>Store:</strong> <%= order.getStoreName() %></p>
        <p><strong>Order Number:</strong> <%= order.getOrderNumber() %></p>
        <p><strong>Order Status:</strong>
            <span class="status"><%= order.getOrderStatus() %></span>
        </p>
    </section>

    <% if (shipment == null) { %>

        <section class="dashboard-card">
            <h3>Shipment Not Available</h3>
            <p>No shipment information has been added for this order yet.</p>
        </section>

    <% } else { %>

        <section class="dashboard-card">
            <h3>Shipment Details</h3>

            <p><strong>Tracking Number:</strong>
                <%= shipment.getTrackingNumber() %></p>

            <p><strong>Courier Partner:</strong>
                <%= shipment.getCourierName() %></p>

            <p><strong>Current Status:</strong>
                <span class="status"><%= shipment.getCurrentStatus() %></span>
            </p>

            <p><strong>Last Updated:</strong>
                <%= shipment.getLastUpdated() %></p>
        </section>

        <section class="dashboard-card">
            <h3>Tracking Timeline</h3>

            <% if (events == null || events.isEmpty()) { %>

                <p>No tracking events are available yet.</p>

            <% } else { %>

                <div class="tracking-timeline">

                    <% for (TrackingInfo event : events) { %>

                        <div class="tracking-event">
                            <h3><%= event.getStatus() %></h3>

                            <p>
                                <strong>Location:</strong>
                                <%= event.getLocation() %>
                            </p>

                            <p><%= event.getDescription() %></p>

                            <p>
                                <small>
                                    <%= event.getEventTime() %>
                                </small>
                            </p>
                        </div>

                    <% } %>

                </div>

            <% } %>
        </section>

    <% } %>

</main>

<footer class="footer">
    <p>TrackNest &copy; 2026 | Centralized Multi-Platform Order Tracking</p>
</footer>

</body>
</html>
