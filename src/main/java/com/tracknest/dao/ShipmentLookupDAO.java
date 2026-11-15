
package com.tracknest.dao;

import com.tracknest.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ShipmentLookupDAO {

    public int findShipmentId(String trackingNumber)
            throws SQLException {

        String sql = """
                SELECT ShipmentID
                FROM Shipments
                WHERE TrackingNumber = ?
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, trackingNumber);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt("ShipmentID");
                }
            }
        }

        return -1;
    }
}
