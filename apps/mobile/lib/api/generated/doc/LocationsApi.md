# farm_recorder_api_client.api.LocationsApi

## Load the API package
```dart
import 'package:farm_recorder_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1LocationsGet**](LocationsApi.md#apiv1locationsget) | **GET** /api/v1/locations | Get all locations
[**apiV1LocationsIdDelete**](LocationsApi.md#apiv1locationsiddelete) | **DELETE** /api/v1/locations/{id} | Delete a location
[**apiV1LocationsIdGet**](LocationsApi.md#apiv1locationsidget) | **GET** /api/v1/locations/{id} | Get location by ID
[**apiV1LocationsPost**](LocationsApi.md#apiv1locationspost) | **POST** /api/v1/locations | Create a new farm location


# **apiV1LocationsGet**
> BuiltList<Location> apiV1LocationsGet()

Get all locations

Retrieves a list of all registered farm locations

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getLocationsApi();

try {
    final response = api.apiV1LocationsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->apiV1LocationsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Location&gt;**](Location.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1LocationsIdDelete**
> apiV1LocationsIdDelete(id)

Delete a location

Removes a location from the system

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getLocationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api.apiV1LocationsIdDelete(id);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->apiV1LocationsIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1LocationsIdGet**
> Location apiV1LocationsIdGet(id)

Get location by ID

Retrieves a specific location by its UUID

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getLocationsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiV1LocationsIdGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->apiV1LocationsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Location**](Location.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1LocationsPost**
> Location apiV1LocationsPost(location)

Create a new farm location

Registers a new field or facility with its GLN and GeoJSON boundary

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getLocationsApi();
final Location location = ; // Location | 

try {
    final response = api.apiV1LocationsPost(location);
    print(response);
} on DioException catch (e) {
    print('Exception when calling LocationsApi->apiV1LocationsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **location** | [**Location**](Location.md)|  | [optional] 

### Return type

[**Location**](Location.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

