package com.farmrecorder.domain.port;

import com.farmrecorder.domain.model.ActivityLog;

public interface OpenSearchIndexerPort {
    void indexActivity(ActivityLog activityLog);
}
