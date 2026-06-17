import 'package:test/test.dart';
import 'package:farm_recorder_api_client/farm_recorder_api_client.dart';


/// tests for ProductsApi
void main() {
  final instance = FarmRecorderApiClient().getProductsApi();

  group(ProductsApi, () {
    // Get all products
    //
    // Retrieves a list of all registered products
    //
    //Future<BuiltList<Product>> apiV1ProductsGet() async
    test('test apiV1ProductsGet', () async {
      // TODO
    });

    // Get product by ID
    //
    // Retrieves a specific product by its UUID
    //
    //Future<Product> apiV1ProductsIdGet(String id) async
    test('test apiV1ProductsIdGet', () async {
      // TODO
    });

    // Create a new product
    //
    // Registers a new product with its GTIN
    //
    //Future<Product> apiV1ProductsPost({ Product product }) async
    test('test apiV1ProductsPost', () async {
      // TODO
    });

  });
}
