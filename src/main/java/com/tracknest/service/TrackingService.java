
package com.tracknest.service;

import com.tracknest.adapter.LeopardAdapter;
import com.tracknest.adapter.TCSAdapter;
import com.tracknest.adapter.TrackingProvider;
import com.tracknest.dao.ShipmentDAO;
import com.tracknest.model.Shipment;
import com.tracknest.model.TrackingInfo;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

public class TrackingService {

    private final ShipmentDAO shipmentDAO = new ShipmentDAO();

    public Shipment getShipment(int orderID)
            throws SQLException {

        return shipmentDAO.findByOrderId(orderID);
    }

    public List<TrackingInfo> getTrackingHistory(
            String trackingNumber, String courierName)
            throws SQLException {

        TrackingProvider provider;

        if (courierName == null) {
            return Collections.emptyList();
        }

        switch (courierName.trim().toLowerCase()) {

            case "tcs":
                provider = new TCSAdapter();
                break;

            case "leopard":
                provider = new LeopardAdapter();
                break;

            default:
                return Collections.emptyList();
        }

        return provider.track(trackingNumber);
    }
}
