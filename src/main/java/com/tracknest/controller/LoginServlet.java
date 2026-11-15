
package com.tracknest.controller;

import com.tracknest.model.Customer;
import com.tracknest.service.LoginService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private LoginService loginService;

    @Override
    public void init() {
        loginService = new LoginService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Customer customer = loginService.authenticate(email, password);

            if (customer != null) {

                HttpSession session = request.getSession(true);

                session.setAttribute("customerID", customer.getCustomerID());
                session.setAttribute("customerName", customer.getFullName());

                response.sendRedirect(
                        request.getContextPath() + "/dashboard.jsp"
                );

            } else {

                request.setAttribute(
                        "errorMessage",
                        "Invalid email or password."
                );

                request.setAttribute("email", email);

                request.getRequestDispatcher("/login.jsp")
                        .forward(request, response);
            }

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to complete customer login.", e
            );
        }
    }
}
