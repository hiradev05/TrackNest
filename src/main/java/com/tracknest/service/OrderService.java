
package com.tracknest.service;

import com.tracknest.dao.OrderDAO;
import com.tracknest.model.Order;

import java.sql.SQLException;
import java.util.List;

public class OrderService {

    private final OrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<Order> getCustomerOrders(int customerID)
            throws SQLException {

        if (customerID <= 0) {
            throw new IllegalArgumentException("Invalid customer ID.");
        }

        return orderDAO.findOrdersByCustomerId(customerID);
    }
}
