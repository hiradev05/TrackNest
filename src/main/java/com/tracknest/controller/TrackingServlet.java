
package com.tracknest.controller;

import com.tracknest.model.Order;
import com.tracknest.model.Shipment;
import com.tracknest.model.TrackingInfo;
import com.tracknest.service.OrderService;
import com.tracknest.service.TrackingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/track")
public class TrackingServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final TrackingService trackingService =
            new TrackingService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("customerID") == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdValue = request.getParameter("orderId");

        try {
            int orderID = Integer.parseInt(orderIdValue);

            int customerID =
                    (Integer) session.getAttribute("customerID");

            // Verify that this order belongs to the logged-in customer.
            List<Order> orders =
                    orderService.getCustomerOrders(customerID);

            Order selectedOrder = orders.stream()
                    .filter(order -> order.getOrderID() == orderID)
                    .findFirst()
                    .orElse(null);

            if (selectedOrder == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            Shipment shipment =
                    trackingService.getShipment(orderID);

            request.setAttribute("selectedOrder", selectedOrder);
            request.setAttribute("shipment", shipment);

            if (shipment != null) {
                List<TrackingInfo> events =
                        trackingService.getTrackingHistory(
                                shipment.getTrackingNumber(),
                                shipment.getCourierName());

                request.setAttribute("trackingEvents", events);
            }

            request.getRequestDispatcher("/tracking.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to retrieve tracking information.", e);
        }
    }
}
