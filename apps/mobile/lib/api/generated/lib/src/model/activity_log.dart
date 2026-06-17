//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:farm_recorder_api_client/src/model/activity_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_log.g.dart';

/// ActivityLog
///
/// Properties:
/// * [id] 
/// * [timestamp] 
/// * [userId] 
/// * [locationId] 
/// * [productId] 
/// * [type] 
/// * [notes] 
/// * [gpsLat] 
/// * [gpsLng] 
@BuiltValue()
abstract class ActivityLog implements Built<ActivityLog, ActivityLogBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'locationId')
  String? get locationId;

  @BuiltValueField(wireName: r'productId')
  String? get productId;

  @BuiltValueField(wireName: r'type')
  ActivityType? get type;
  // enum typeEnum {  PLANTING,  SPRAYING,  HARVESTING,  CLEANING,  INSPECTION,  };

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'gpsLat')
  double? get gpsLat;

  @BuiltValueField(wireName: r'gpsLng')
  double? get gpsLng;

  ActivityLog._();

  factory ActivityLog([void updates(ActivityLogBuilder b)]) = _$ActivityLog;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActivityLogBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActivityLog> get serializer => _$ActivityLogSerializer();
}

class _$ActivityLogSerializer implements PrimitiveSerializer<ActivityLog> {
  @override
  final Iterable<Type> types = const [ActivityLog, _$ActivityLog];

  @override
  final String wireName = r'ActivityLog';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActivityLog object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.locationId != null) {
      yield r'locationId';
      yield serializers.serialize(
        object.locationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.productId != null) {
      yield r'productId';
      yield serializers.serialize(
        object.productId,
        specifiedType: const FullType(String),
      );
    }
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(ActivityType),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType(String),
      );
    }
    if (object.gpsLat != null) {
      yield r'gpsLat';
      yield serializers.serialize(
        object.gpsLat,
        specifiedType: const FullType(double),
      );
    }
    if (object.gpsLng != null) {
      yield r'gpsLng';
      yield serializers.serialize(
        object.gpsLng,
        specifiedType: const FullType(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ActivityLog object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ActivityLogBuilder result,
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
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'locationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.locationId = valueDes;
          break;
        case r'productId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productId = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ActivityType),
          ) as ActivityType;
          result.type = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.notes = valueDes;
          break;
        case r'gpsLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.gpsLat = valueDes;
          break;
        case r'gpsLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.gpsLng = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActivityLog deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActivityLogBuilder();
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

