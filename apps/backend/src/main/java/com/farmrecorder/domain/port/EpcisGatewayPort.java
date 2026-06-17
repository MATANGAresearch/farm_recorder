package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.ActivityLog;

public interface EpcisGatewayPort {
    void publishEvent(ActivityLog activityLog);
}
