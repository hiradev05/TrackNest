
package com.tracknest.service;

public class TrackingStatusNormalizer {

    public static String normalizeStatus(String status) {

        if (status == null || status.trim().isEmpty()) {
            return "Unknown";
        }

        String value = status.toLowerCase().trim();

        if (value.contains("out for delivery")) {
            return "Out for Delivery";
        }

        if (value.contains("deliver")) {
            return "Delivered";
        }

        if (value.contains("transit") || value.contains("way")) {
            return "In Transit";
        }

        if (value.contains("dispatch") || value.contains("pick")) {
            return "Picked Up";
        }

        return "Unknown";
    }
}
