import 'package:test/test.dart';
import 'package:farm_recorder_api_client/farm_recorder_api_client.dart';


/// tests for MediaApi
void main() {
  final instance = FarmRecorderApiClient().getMediaApi();

  group(MediaApi, () {
    // Get media by activity log ID
    //
    // Retrieves all media associated with a specific activity log
    //
    //Future<BuiltList<Media>> apiV1MediaActivityActivityLogIdGet(String activityLogId) async
    test('test apiV1MediaActivityActivityLogIdGet', () async {
      // TODO
    });

    // Upload media for an activity log
    //
    // Records media metadata (image URL should be pre-signed or uploaded via separate endpoint)
    //
    //Future<Media> apiV1MediaPost({ Media media }) async
    test('test apiV1MediaPost', () async {
      // TODO
    });

  });
}
