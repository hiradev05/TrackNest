<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrackNest | Your Orders, One Place</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #172554;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 22px 8%;
            background: white;
        }

        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #2563eb;
        }

        nav a {
            text-decoration: none;
            color: #334155;
            margin-left: 25px;
            font-weight: bold;
        }

        .hero {
            text-align: center;
            padding: 100px 20px;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero h1 span {
            color: #2563eb;
        }

        .hero p {
            font-size: 18px;
            color: #64748b;
            line-height: 1.7;
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 14px 28px;
            margin: 8px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            background: #2563eb;
            color: white;
        }

        .secondary {
            background: white;
            color: #2563eb;
            border: 1px solid #2563eb;
        }

        .features {
            display: flex;
            justify-content: center;
            gap: 25px;
            padding: 30px 8% 70px;
            flex-wrap: wrap;
        }

        .feature {
            background: white;
            padding: 30px;
            border-radius: 12px;
            width: 280px;
            text-align: center;
            box-shadow: 0 4px 15px #0000000a;
        }

        .feature h3 {
            margin-bottom: 12px;
        }

        .feature p {
            color: #64748b;
            line-height: 1.6;
        }
    </style>
</head>
<body>

<nav>
    <div class="logo">TrackNest</div>
    <div>
        <a href="login.jsp">Sign In</a>
        <a href="register.jsp">Register</a>
    </div>
</nav>

<section class="hero">
    <h1>All Your Orders.<br><span>One Tracking Place.</span></h1>

    <p>
        Track your online purchases from different stores
        and courier partners through one centralized dashboard.
    </p>

    <a href="register.jsp" class="btn">Get Started</a>
    <a href="login.jsp" class="btn secondary">Sign In</a>
</section>

<section class="features">
    <div class="feature">
        <h3>One Dashboard</h3>
        <p>View your orders from multiple online stores in one place.</p>
    </div>

    <div class="feature">
        <h3>Shipment Tracking</h3>
        <p>Check shipment status and tracking details for your orders.</p>
    </div>

    <div class="feature">
        <h3>Tracking Timeline</h3>
        <p>Follow shipment events from dispatch to delivery.</p>
    </div>
</section>

</body>
</html>
