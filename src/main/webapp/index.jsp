
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrackNest | Your Orders, One Place</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<header class="navbar">
    <div class="container">
        <a class="logo" href="${pageContext.request.contextPath}/">
            TrackNest
        </a>

        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/login.jsp">Sign In</a>
            <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
        </nav>
    </div>
</header>

<main>

    <section class="hero">
        <div class="container">
            <h1>All Your Orders.<br>
                <span>One Tracking Place.</span>
            </h1>

            <p>
                Track your online purchases from different stores
                and courier partners through one centralized dashboard.
            </p>

            <a href="${pageContext.request.contextPath}/register.jsp"
               class="btn">Get Started</a>

            <a href="${pageContext.request.contextPath}/login.jsp"
               class="btn btn-secondary">Sign In</a>
        </div>
    </section>

    <section class="features container">

        <div class="feature">
            <h3>One Dashboard</h3>
            <p>
                View your orders from multiple online stores in one place.
            </p>
        </div>

        <div class="feature">
            <h3>Shipment Tracking</h3>
            <p>
                Check shipment status and tracking details for your orders.
            </p>
        </div>

        <div class="feature">
            <h3>Tracking Timeline</h3>
            <p>
                Follow shipment events from dispatch to delivery.
            </p>
        </div>

    </section>

</main>

<footer class="footer">
    <p>TrackNest &copy; 2026 | Centralized Multi-Platform Order Tracking</p>
</footer>

</body>
</html>
