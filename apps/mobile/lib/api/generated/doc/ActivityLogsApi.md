# farm_recorder_api_client.api.ActivityLogsApi

## Load the API package
```dart
import 'package:farm_recorder_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1ActivityLogsGet**](ActivityLogsApi.md#apiv1activitylogsget) | **GET** /api/v1/activity-logs | Get activity log by ID
[**apiV1ActivityLogsLocationLocationIdGet**](ActivityLogsApi.md#apiv1activitylogslocationlocationidget) | **GET** /api/v1/activity-logs/location/{locationId} | Get activity logs by location
[**apiV1ActivityLogsPost**](ActivityLogsApi.md#apiv1activitylogspost) | **POST** /api/v1/activity-logs | Create a new activity log


# **apiV1ActivityLogsGet**
> ActivityLog apiV1ActivityLogsGet()

Get activity log by ID

Retrieves a specific activity log

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getActivityLogsApi();

try {
    final response = api.apiV1ActivityLogsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ActivityLogsApi->apiV1ActivityLogsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ActivityLog**](ActivityLog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1ActivityLogsLocationLocationIdGet**
> BuiltList<ActivityLog> apiV1ActivityLogsLocationLocationIdGet(locationId)

Get activity logs by location

Retrieves all activity logs for a specific farm location

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getActivityLogsApi();
final String locationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiV1ActivityLogsLocationLocationIdGet(locationId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ActivityLogsApi->apiV1ActivityLogsLocationLocationIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locationId** | **String**|  | 

### Return type

[**BuiltList&lt;ActivityLog&gt;**](ActivityLog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1ActivityLogsPost**
> ActivityLog apiV1ActivityLogsPost(activityLog)

Create a new activity log

Records a farm activity with GPS coordinates, triggering EPCIS event

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getActivityLogsApi();
final ActivityLog activityLog = ; // ActivityLog | 

try {
    final response = api.apiV1ActivityLogsPost(activityLog);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ActivityLogsApi->apiV1ActivityLogsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityLog** | [**ActivityLog**](ActivityLog.md)|  | [optional] 

### Return type

[**ActivityLog**](ActivityLog.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

