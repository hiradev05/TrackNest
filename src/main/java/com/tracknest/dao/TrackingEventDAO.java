
package com.tracknest.dao;

import com.tracknest.model.TrackingEvent;
import com.tracknest.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TrackingEventDAO {

    public List<TrackingEvent> findByShipmentId(int shipmentID)
            throws SQLException {

        List<TrackingEvent> events = new ArrayList<>();

        String sql = """
                SELECT EventID, ShipmentID, Status,
                       Location, Description, EventTime
                FROM TrackingEvents
                WHERE ShipmentID = ?
                ORDER BY EventTime ASC
                """;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, shipmentID);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {

                    TrackingEvent event = new TrackingEvent();

                    event.setEventID(resultSet.getInt("EventID"));
                    event.setShipmentID(resultSet.getInt("ShipmentID"));
                    event.setStatus(resultSet.getString("Status"));
                    event.setLocation(resultSet.getString("Location"));
                    event.setDescription(
                            resultSet.getString("Description"));
                    event.setEventTime(
                            resultSet.getTimestamp("EventTime"));

                    events.add(event);
                }
            }
        }

        return events;
    }
}
