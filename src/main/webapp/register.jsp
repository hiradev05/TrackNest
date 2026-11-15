
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | TrackNest</title>
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
            <a href="${pageContext.request.contextPath}/">Home</a>
            <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
        </nav>
    </div>
</header>

<main class="auth-container">

    <h2>Create Your TrackNest Account</h2>
    <p class="page-subtitle">
        Track all your orders in one place.
    </p>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </p>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName"
                   value="${fullName}" required minlength="2">
        </div>

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   value="${email}" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   required minlength="8">
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword"
                   name="confirmPassword" required minlength="8">
        </div>

        <button type="submit" class="btn">Create Account</button>

    </form>

    <p class="auth-link">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login.jsp">
            Sign In
        </a>
    </p>

    <p class="auth-link">
        <a href="${pageContext.request.contextPath}/">Back to Home</a>
    </p>

</main>

<footer class="footer">
    <p>TrackNest &copy; 2026 | Centralized Multi-Platform Order Tracking</p>
</footer>

</body>
</html>
