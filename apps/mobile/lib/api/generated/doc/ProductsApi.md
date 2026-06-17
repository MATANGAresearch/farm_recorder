# farm_recorder_api_client.api.ProductsApi

## Load the API package
```dart
import 'package:farm_recorder_api_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**apiV1ProductsGet**](ProductsApi.md#apiv1productsget) | **GET** /api/v1/products | Get all products
[**apiV1ProductsIdGet**](ProductsApi.md#apiv1productsidget) | **GET** /api/v1/products/{id} | Get product by ID
[**apiV1ProductsPost**](ProductsApi.md#apiv1productspost) | **POST** /api/v1/products | Create a new product


# **apiV1ProductsGet**
> BuiltList<Product> apiV1ProductsGet()

Get all products

Retrieves a list of all registered products

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getProductsApi();

try {
    final response = api.apiV1ProductsGet();
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiV1ProductsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;Product&gt;**](Product.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1ProductsIdGet**
> Product apiV1ProductsIdGet(id)

Get product by ID

Retrieves a specific product by its UUID

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getProductsApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.apiV1ProductsIdGet(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiV1ProductsIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**Product**](Product.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **apiV1ProductsPost**
> Product apiV1ProductsPost(product)

Create a new product

Registers a new product with its GTIN

### Example
```dart
import 'package:farm_recorder_api_client/api.dart';

final api = FarmRecorderApiClient().getProductsApi();
final Product product = ; // Product | 

try {
    final response = api.apiV1ProductsPost(product);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ProductsApi->apiV1ProductsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **product** | [**Product**](Product.md)|  | [optional] 

### Return type

[**Product**](Product.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

