package com.farmrecorder.core.util;

import com.github.f4b6a3.uuid.UuidCreator;
import java.util.UUID;

/**
 * Utility class for generating time-ordered UUIDs (UUIDv7).
 * UUIDv7 embeds a Unix timestamp in the most significant bits,
 * allowing chronological sorting and visual estimation of creation time.
 */
public final class IdGenerator {

    private IdGenerator() {
        // Utility class
    }

    /**
     * Generates a UUIDv7 (time-ordered UUID).
     * @return a new UUIDv7
     */
    public static UUID generate() {
        return UuidCreator.getTimeOrderedEpoch();
    }
}
