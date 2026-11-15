
package com.tracknest.adapter;
import com.tracknest.service.TrackingStatusNormalizer;
import com.tracknest.dao.ShipmentLookupDAO;
import com.tracknest.dao.TrackingEventDAO;
import com.tracknest.model.TrackingEvent;
import com.tracknest.model.TrackingInfo;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LeopardAdapter implements TrackingProvider {

    private final TrackingEventDAO trackingEventDAO =
            new TrackingEventDAO();

    private final ShipmentLookupDAO shipmentLookupDAO =
            new ShipmentLookupDAO();

    @Override
    public List<TrackingInfo> track(String trackingNumber)
            throws SQLException {

        List<TrackingInfo> trackingInfoList = new ArrayList<>();

        int shipmentID =
                shipmentLookupDAO.findShipmentId(trackingNumber);

        if (shipmentID == -1) {
            return trackingInfoList;
        }

        List<TrackingEvent> events =
                trackingEventDAO.findByShipmentId(shipmentID);

        for (TrackingEvent event : events) {

            TrackingInfo info = new TrackingInfo();

            info.setTrackingNumber(trackingNumber);
            info.setCourierName("Leopard");
            info.setStatus(normalizeStatus(event.getStatus()));
            info.setLocation(event.getLocation());
            info.setDescription(event.getDescription());
            info.setEventTime(event.getEventTime());

            trackingInfoList.add(info);
        }

        return trackingInfoList;
    }

    private String normalizeStatus(String status) {
        return TrackingStatusNormalizer.normalizeStatus(status);
    }
}
