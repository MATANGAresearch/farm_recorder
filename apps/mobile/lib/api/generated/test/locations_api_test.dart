import 'package:test/test.dart';
import 'package:farm_recorder_api_client/farm_recorder_api_client.dart';


/// tests for LocationsApi
void main() {
  final instance = FarmRecorderApiClient().getLocationsApi();

  group(LocationsApi, () {
    // Get all locations
    //
    // Retrieves a list of all registered farm locations
    //
    //Future<BuiltList<Location>> apiV1LocationsGet() async
    test('test apiV1LocationsGet', () async {
      // TODO
    });

    // Delete a location
    //
    // Removes a location from the system
    //
    //Future apiV1LocationsIdDelete(String id) async
    test('test apiV1LocationsIdDelete', () async {
      // TODO
    });

    // Get location by ID
    //
    // Retrieves a specific location by its UUID
    //
    //Future<Location> apiV1LocationsIdGet(String id) async
    test('test apiV1LocationsIdGet', () async {
      // TODO
    });

    // Create a new farm location
    //
    // Registers a new field or facility with its GLN and GeoJSON boundary
    //
    //Future<Location> apiV1LocationsPost({ Location location }) async
    test('test apiV1LocationsPost', () async {
      // TODO
    });

  });
}
