//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_type.g.dart';

class ActivityType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PLANTING')
  static const ActivityType PLANTING = _$PLANTING;
  @BuiltValueEnumConst(wireName: r'SPRAYING')
  static const ActivityType SPRAYING = _$SPRAYING;
  @BuiltValueEnumConst(wireName: r'HARVESTING')
  static const ActivityType HARVESTING = _$HARVESTING;
  @BuiltValueEnumConst(wireName: r'CLEANING')
  static const ActivityType CLEANING = _$CLEANING;
  @BuiltValueEnumConst(wireName: r'INSPECTION')
  static const ActivityType INSPECTION = _$INSPECTION;

  static Serializer<ActivityType> get serializer => _$activityTypeSerializer;

  const ActivityType._(String name): super(name);

  static BuiltSet<ActivityType> get values => _$values;
  static ActivityType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActivityTypeMixin = Object with _$ActivityTypeMixin;

