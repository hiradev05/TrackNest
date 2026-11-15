
package com.tracknest.adapter;

import com.tracknest.model.TrackingInfo;

import java.sql.SQLException;
import java.util.List;

public interface TrackingProvider {

    List<TrackingInfo> track(String trackingNumber)
            throws SQLException;
}
