
package com.tracknest.controller;

import com.tracknest.service.CustomerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        try {

            String result = customerService.registerCustomer(
                    fullName,
                    email,
                    password,
                    confirmPassword
            );

            if ("SUCCESS".equals(result)) {

                response.sendRedirect(
                        request.getContextPath() + "/login.jsp?registered=true"
                );

            } else {

                request.setAttribute("errorMessage", result);
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);

                request.getRequestDispatcher("/register.jsp")
                        .forward(request, response);
            }

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to complete customer registration.", e
            );
        }
    }
}
