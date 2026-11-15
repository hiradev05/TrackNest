
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | TrackNest</title>
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
            <a href="${pageContext.request.contextPath}/register.jsp">Register</a>
        </nav>
    </div>
</header>

<main class="auth-container">

    <h2>Welcome Back!</h2>
    <p class="page-subtitle">Sign in to access your TrackNest dashboard.</p>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </p>
    <% } %>

    <% if ("true".equals(request.getParameter("logout"))) { %>
        <p class="success-message">You have successfully logged out.</p>
    <% } %>

    <% if ("true".equals(request.getParameter("registered"))) { %>
        <p class="success-message">Registration successful! Please sign in.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   value="${email}" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   required>
        </div>

        <button type="submit" class="btn">Sign In</button>

    </form>

    <p class="auth-link">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register.jsp">
            Create Account
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
