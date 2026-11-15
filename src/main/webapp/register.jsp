
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | TrackNest</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <main class="auth-container">
        <h1>Create Your TrackNest Account</h1>
        <p>Track all your orders in one place.</p>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <p style="color: red;">
                <%= request.getAttribute("errorMessage") %>
            </p>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">

            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName"
                   value="${fullName}" required minlength="2">

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email"
                   value="${email}" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   required minlength="8">

            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword"
                   name="confirmPassword" required minlength="8">

            <button type="submit">Create Account</button>
        </form>

        <p>Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp">Sign In</a>
        </p>

        <a href="${pageContext.request.contextPath}/">Back to Home</a>
    </main>

</body>
</html>
