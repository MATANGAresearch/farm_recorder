import 'dart:io';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'api_service.dart';

enum MediaType { IMAGE, VIDEO, AUDIO }

class MediaService {
  final ImagePicker _picker = ImagePicker();

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<File?> captureMedia(MediaType type) async {
    const bool useMock = true; // Set to true to bypass native picker on emulator
    if (useMock) {
      final tempDir = Directory.systemTemp;
      if (type == MediaType.IMAGE) {
        final dummyFile = File('${tempDir.path}/mock_image.jpg');
        // Valid 1x1 pixel red JPEG
        final bytes = [
          0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10, 0x4A, 0x46, 0x49, 0x46, 0x00, 0x01, 0x01, 0x01, 0x00, 0x60,
          0x00, 0x60, 0x00, 0x00, 0xFF, 0xDB, 0x00, 0x43, 0x00, 0x08, 0x06, 0x06, 0x07, 0x06, 0x05, 0x08,
          0x07, 0x07, 0x07, 0x09, 0x09, 0x08, 0x0A, 0x0C, 0x14, 0x0D, 0x0C, 0x0B, 0x0B, 0x0C, 0x19, 0x12,
          0x13, 0x0F, 0x14, 0x1D, 0x1A, 0x1F, 0x1E, 0x1D, 0x1A, 0x1C, 0x1C, 0x20, 0x24, 0x2E, 0x27, 0x20,
          0x22, 0x2C, 0x23, 0x1C, 0x1C, 0x28, 0x37, 0x29, 0x2C, 0x30, 0x31, 0x34, 0x34, 0x34, 0x1F, 0x27,
          0x39, 0x3D, 0x38, 0x32, 0x3C, 0x2E, 0x33, 0x34, 0x32, 0xFF, 0xC0, 0x00, 0x0B, 0x08, 0x00, 0x01,
          0x00, 0x01, 0x01, 0x01, 0x11, 0x00, 0xFF, 0xC4, 0x00, 0x14, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x09, 0xFF, 0xC4, 0x00, 0x14, 0x10,
          0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0xFF, 0xDA, 0x00, 0x08, 0x01, 0x01, 0x00, 0x00, 0x3F, 0x00, 0x37, 0xFF, 0xD9
        ];
        await dummyFile.writeAsBytes(bytes);
        return dummyFile;
      } else if (type == MediaType.VIDEO) {
        final dummyFile = File('${tempDir.path}/mock_video.mp4');
        await dummyFile.writeAsBytes(List.generate(100, (index) => index));
        return dummyFile;
      } else {
        return null;
      }
    }

    if (type == MediaType.IMAGE) {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo == null) return null;
      final imageBytes = await photo.readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image == null) return File(photo.path);
      final resized = img.copyResize(image, width: 1024);
      final compressed = img.encodeJpg(resized, quality: 80);
      final tempDir = Directory.systemTemp;
      final compressedFile = File('${tempDir.path}/compressed_${photo.name}');
      await compressedFile.writeAsBytes(compressed);
      return compressedFile;
    } else if (type == MediaType.VIDEO) {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
      return video != null ? File(video.path) : null;
    } else {
      // AUDIO: Placeholder for now due to package compatibility issues.
      // In a real app, you'd use the 'record' package to capture .m4a.
      // Returning null to indicate no file was captured.
      return null;
    }
  }

  /// Uploads media to MinIO via a presigned URL and returns the final object URL.
  Future<String?> uploadMediaToMinIO(File mediaFile, MediaType type, String farmId, String taskId, ApiService apiService) async {
    try {
      final fileName = mediaFile.path.split('/').last;
      String contentType = 'application/octet-stream';
      if (type == MediaType.IMAGE) contentType = 'image/jpeg';
      else if (type == MediaType.VIDEO) contentType = 'video/mp4';
      else if (type == MediaType.AUDIO) contentType = 'audio/mp4';

      // 1. Request presigned URL from backend via ApiService (sends authorization token)
      print('DEBUG: Requesting presigned URL. farmId: $farmId, taskId: $taskId, fileName: $fileName, contentType: $contentType');
      final presignedResponse = await apiService.getPresignedUrl(
        farmId: farmId,
        taskId: taskId,
        fileName: fileName,
        contentType: contentType,
      );
      print('DEBUG: Presigned URL response: $presignedResponse');

      String uploadUrl = presignedResponse['uploadUrl'] as String;
      final originalUri = Uri.parse(uploadUrl);
      final originalHost = originalUri.authority; // e.g. "localhost:9000" or "127.0.0.1:9000"

      if (Platform.isAndroid) {
        uploadUrl = uploadUrl.replaceAll('localhost:9000', '10.0.2.2:9000')
                             .replaceAll('127.0.0.1:9000', '10.0.2.2:9000');
      }
      print('DEBUG: Uploading file to MinIO using URL: $uploadUrl, Host header: $originalHost');

      // 2. Upload file directly to MinIO
      final uploadDio = Dio();
      await uploadDio.put(
        uploadUrl,
        data: await mediaFile.readAsBytes(),
        options: Options(headers: {
          'Content-Type': contentType,
          'Host': originalHost,
        }),
      );
      print('DEBUG: File uploaded successfully to MinIO.');

      // 3. Construct final accessible URL
      final uri = Uri.parse(uploadUrl);
      final objectKey = uri.path.substring(1); // Remove leading '/'
      return 'http://10.0.2.2:9000/$objectKey'; // Use emulator IP for MinIO access from Android
    } catch (e) {
      print('Error uploading media to MinIO: $e');
      return null;
    }
  }
}
