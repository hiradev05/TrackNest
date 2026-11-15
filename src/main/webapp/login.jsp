
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | TrackNest</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<main class="auth-container">

    <h1>Welcome Back!</h1>
    <p>Sign in to access your TrackNest dashboard.</p>

    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color:red;">
            <%= request.getAttribute("errorMessage") %>
        </p>
    <% } %>

    <% if ("true".equals(request.getParameter("logout"))) { %>
        <p style="color:green;">You have successfully logged out.</p>
    <% } %>

    <% if ("true".equals(request.getParameter("registered"))) { %>
        <p style="color:green;">Registration successful! Please sign in.</p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <label for="email">Email Address</label>
        <input type="email" id="email" name="email"
               value="${email}" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password"
               required>

        <button type="submit">Sign In</button>

    </form>

    <p>Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Create Account</a>
    </p>

    <a href="${pageContext.request.contextPath}/">Back to Home</a>

</main>

</body>
</html>
