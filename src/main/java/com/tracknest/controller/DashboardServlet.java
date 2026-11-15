
package com.tracknest.controller;

import com.tracknest.model.Order;
import com.tracknest.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("customerID") == null) {

            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        int customerID =
                (Integer) session.getAttribute("customerID");

        try {
            List<Order> orders =
                    orderService.getCustomerOrders(customerID);

            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/dashboard.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load customer orders.", e);
        }
    }
}
