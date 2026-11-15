
package com.tracknest.dao;

import com.tracknest.model.Order;
import com.tracknest.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public List<Order> findOrdersByCustomerId(int customerID)
            throws SQLException {

        List<Order> orders = new ArrayList<>();

        String sql = """
                SELECT OrderID, CustomerID, StoreName,
                       OrderNumber, OrderDate, OrderStatus
                FROM Orders
                WHERE CustomerID = ?
                ORDER BY OrderDate DESC
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, customerID);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    Order order = new Order();

                    order.setOrderID(resultSet.getInt("OrderID"));
                    order.setCustomerID(resultSet.getInt("CustomerID"));
                    order.setStoreName(resultSet.getString("StoreName"));
                    order.setOrderNumber(resultSet.getString("OrderNumber"));
                    order.setOrderDate(resultSet.getTimestamp("OrderDate"));
                    order.setOrderStatus(resultSet.getString("OrderStatus"));

                    orders.add(order);
                }
            }
        }

        return orders;
    }
}
