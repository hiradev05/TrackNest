
package com.tracknest.dao;

import com.tracknest.model.Customer;
import com.tracknest.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {

    public boolean emailExists(String email) throws SQLException {

        String sql = "SELECT CustomerID FROM Customers WHERE Email = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public boolean registerCustomer(Customer customer) throws SQLException {

        String sql = """
                INSERT INTO Customers (FullName, Email, PasswordHash)
                VALUES (?, ?, ?)
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, customer.getFullName());
            statement.setString(2, customer.getEmail());
            statement.setString(3, customer.getPasswordHash());

            return statement.executeUpdate() == 1;
        }
    }

    public Customer findByEmail(String email) throws SQLException {

        String sql = "SELECT CustomerID, FullName, Email, PasswordHash, CreatedAt " +
                "FROM Customers WHERE Email = ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    Customer customer = new Customer();

                    customer.setCustomerID(resultSet.getInt("CustomerID"));
                    customer.setFullName(resultSet.getString("FullName"));
                    customer.setEmail(resultSet.getString("Email"));
                    customer.setPasswordHash(resultSet.getString("PasswordHash"));
                    customer.setCreatedAt(resultSet.getTimestamp("CreatedAt"));

                    return customer;
                }
            }
        }

        return null;
    }

}
