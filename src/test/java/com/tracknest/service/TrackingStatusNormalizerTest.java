
package com.tracknest.service;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class TrackingStatusNormalizerTest {

    @Test
    void shouldNormalizeOutForDelivery() {
        assertEquals("Out for Delivery",
                TrackingStatusNormalizer.normalizeStatus("Out for Delivery"));
    }

    @Test
    void shouldNormalizeDelivered() {
        assertEquals("Delivered",
                TrackingStatusNormalizer.normalizeStatus("Delivered"));
    }

    @Test
    void shouldNormalizeInTransit() {
        assertEquals("In Transit",
                TrackingStatusNormalizer.normalizeStatus("In Transit"));
    }

    @Test
    void shouldNormalizePickedUp() {
        assertEquals("Picked Up",
                TrackingStatusNormalizer.normalizeStatus("Picked Up"));
    }

    @Test
    void shouldReturnUnknownForNull() {
        assertEquals("Unknown",
                TrackingStatusNormalizer.normalizeStatus(null));
    }

    @Test
    void shouldReturnUnknownForBlank() {
        assertEquals("Unknown",
                TrackingStatusNormalizer.normalizeStatus(" "));
    }
}
