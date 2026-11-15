
package com.tracknest.adapter;
import com.tracknest.service.TrackingStatusNormalizer;
import com.tracknest.model.TrackingInfo;
import com.tracknest.dao.TrackingEventDAO;
import com.tracknest.model.TrackingEvent;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TCSAdapter implements TrackingProvider {

    private final TrackingEventDAO trackingEventDAO =
            new TrackingEventDAO();

    @Override
    public List<TrackingInfo> track(String trackingNumber)
            throws SQLException {

        List<TrackingInfo> trackingInfoList = new ArrayList<>();

        // Find shipment events using the tracking number
        // These are simulated demonstration tracking records.
        // No live TCS API is being called.

        int shipmentID = findShipmentId(trackingNumber);

        if (shipmentID == -1) {
            return trackingInfoList;
        }

        List<TrackingEvent> events =
                trackingEventDAO.findByShipmentId(shipmentID);

        for (TrackingEvent event : events) {

            TrackingInfo info = new TrackingInfo();

            info.setTrackingNumber(trackingNumber);
            info.setCourierName("TCS");
            info.setStatus(normalizeStatus(event.getStatus()));
            info.setLocation(event.getLocation());
            info.setDescription(event.getDescription());
            info.setEventTime(event.getEventTime());

            trackingInfoList.add(info);
        }

        return trackingInfoList;
    }

    private int findShipmentId(String trackingNumber)
            throws SQLException {

        return new com.tracknest.dao.ShipmentLookupDAO()
                .findShipmentId(trackingNumber);
    }


    private String normalizeStatus(String status) {
        return TrackingStatusNormalizer.normalizeStatus(status);
    }

}
