//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'media.g.dart';

/// Media
///
/// Properties:
/// * [id] 
/// * [activityLogId] 
/// * [imageUrl] 
/// * [capturedGpsLat] 
/// * [capturedGpsLng] 
/// * [timestamp] 
@BuiltValue()
abstract class Media implements Built<Media, MediaBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'activityLogId')
  String? get activityLogId;

  @BuiltValueField(wireName: r'imageUrl')
  String? get imageUrl;

  @BuiltValueField(wireName: r'capturedGpsLat')
  double? get capturedGpsLat;

  @BuiltValueField(wireName: r'capturedGpsLng')
  double? get capturedGpsLng;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  Media._();

  factory Media([void updates(MediaBuilder b)]) = _$Media;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MediaBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Media> get serializer => _$MediaSerializer();
}

class _$MediaSerializer implements PrimitiveSerializer<Media> {
  @override
  final Iterable<Type> types = const [Media, _$Media];

  @override
  final String wireName = r'Media';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Media object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.activityLogId != null) {
      yield r'activityLogId';
      yield serializers.serialize(
        object.activityLogId,
        specifiedType: const FullType(String),
      );
    }
    if (object.imageUrl != null) {
      yield r'imageUrl';
      yield serializers.serialize(
        object.imageUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.capturedGpsLat != null) {
      yield r'capturedGpsLat';
      yield serializers.serialize(
        object.capturedGpsLat,
        specifiedType: const FullType(double),
      );
    }
    if (object.capturedGpsLng != null) {
      yield r'capturedGpsLng';
      yield serializers.serialize(
        object.capturedGpsLng,
        specifiedType: const FullType(double),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Media object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MediaBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'activityLogId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.activityLogId = valueDes;
          break;
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        case r'capturedGpsLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.capturedGpsLat = valueDes;
          break;
        case r'capturedGpsLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.capturedGpsLng = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Media deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MediaBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

