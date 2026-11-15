
package com.tracknest.dao;

import com.tracknest.model.Shipment;
import com.tracknest.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ShipmentDAO {

    public Shipment findByOrderId(int orderID)
            throws SQLException {

        String sql = """
                SELECT s.ShipmentID, s.OrderID,
                       s.TrackingNumber, s.CourierName,
                       s.CurrentStatus, s.LastUpdated
                FROM Shipments s
                INNER JOIN Orders o ON s.OrderID = o.OrderID
                WHERE s.OrderID = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, orderID);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {

                    Shipment shipment = new Shipment();

                    shipment.setShipmentID(
                            resultSet.getInt("ShipmentID"));

                    shipment.setOrderID(
                            resultSet.getInt("OrderID"));

                    shipment.setTrackingNumber(
                            resultSet.getString("TrackingNumber"));

                    shipment.setCourierName(
                            resultSet.getString("CourierName"));

                    shipment.setCurrentStatus(
                            resultSet.getString("CurrentStatus"));

                    shipment.setLastUpdated(
                            resultSet.getTimestamp("LastUpdated"));

                    return shipment;
                }
            }
        }

        return null;
    }
}
