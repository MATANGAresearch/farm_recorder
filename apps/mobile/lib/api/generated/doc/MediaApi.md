# farm_recorder_api_client.api.MediaApi

## Load the API package
```dart
import 'package:farm_recorder_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1MediaActivityActivityLogIdGet**](MediaApi.md#apiv1mediaactivityactivitylogidget) | **GET** /api/v1/media/activity/{activityLogId} | Get media by activity log ID
[**apiV1MediaPost**](MediaApi.md#apiv1mediapost) | **POST** /api/v1/media | Upload media for an activity log


# **apiV1MediaActivityActivityLogIdGet**
> BuiltList<Media> apiV1MediaActivityActivityLogIdGet(activityLogId)

Get media by activity log ID

Retrieves all media associated with a specific activity log

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getMediaApi();
final String activityLogId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiV1MediaActivityActivityLogIdGet(activityLogId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MediaApi->apiV1MediaActivityActivityLogIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **activityLogId** | **String**|  | 

### Return type

[**BuiltList&lt;Media&gt;**](Media.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1MediaPost**
> Media apiV1MediaPost(media)

Upload media for an activity log

Records media metadata (image URL should be pre-signed or uploaded via separate endpoint)

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getMediaApi();
final Media media = ; // Media | 

try {
    final response = api.apiV1MediaPost(media);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MediaApi->apiV1MediaPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **media** | [**Media**](Media.md)|  | [optional] 

### Return type

[**Media**](Media.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

