
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
    <title>Track Shipment | TrackNest</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">
</head>

<body>

<header>
    <h1>TrackNest</h1>

    <nav>
        <a href="<%= request.getContextPath() %>/dashboard">
            Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/logout">
            Logout
        </a>
    </nav>
</header>

<main>

    <a href="<%= request.getContextPath() %>/dashboard">
        ← Back to Dashboard
    </a>

    <h2>Shipment Tracking</h2>

    <section>
        <h3>Order Information</h3>

        <p><strong>Store:</strong>
            <%= order.getStoreName() %></p>

        <p><strong>Order Number:</strong>
            <%= order.getOrderNumber() %></p>

        <p><strong>Order Status:</strong>
            <%= order.getOrderStatus() %></p>
    </section>

    <hr>

    <% if (shipment == null) { %>

        <h3>Shipment Not Available</h3>
        <p>No shipment information has been added for this order yet.</p>

    <% } else { %>

        <section>
            <h3>Shipment Details</h3>

            <p><strong>Tracking Number:</strong>
                <%= shipment.getTrackingNumber() %></p>

            <p><strong>Courier Partner:</strong>
                <%= shipment.getCourierName() %></p>

            <p><strong>Current Status:</strong>
                <%= shipment.getCurrentStatus() %></p>

            <p><strong>Last Updated:</strong>
                <%= shipment.getLastUpdated() %></p>
        </section>

        <hr>

        <section>
            <h3>Tracking Timeline</h3>

            <% if (events == null || events.isEmpty()) { %>

                <p>No tracking events are available.</p>

            <% } else { %>

                <div class="tracking-timeline">

                    <% for (TrackingInfo event : events) { %>

                        <div class="tracking-event">

                            <h4>
                                <%= event.getStatus() %>
                            </h4>

                            <p>
                                <strong>Location:</strong>
                                <%= event.getLocation() %>
                            </p>

                            <p>
                                <%= event.getDescription() %>
                            </p>

                            <small>
                                <%= event.getEventTime() %>
                            </small>

                        </div>

                    <% } %>

                </div>

            <% } %>
        </section>

    <% } %>

</main>

</body>
</html>
