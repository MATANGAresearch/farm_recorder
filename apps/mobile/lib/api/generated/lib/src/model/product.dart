//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product.g.dart';

/// Product
///
/// Properties:
/// * [id] 
/// * [gtin] 
/// * [name] 
/// * [variety] 
/// * [batchPrefix] 
@BuiltValue()
abstract class Product implements Built<Product, ProductBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'gtin')
  String? get gtin;

  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'variety')
  String? get variety;

  @BuiltValueField(wireName: r'batchPrefix')
  String? get batchPrefix;

  Product._();

  factory Product([void updates(ProductBuilder b)]) = _$Product;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProductBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Product> get serializer => _$ProductSerializer();
}

class _$ProductSerializer implements PrimitiveSerializer<Product> {
  @override
  final Iterable<Type> types = const [Product, _$Product];

  @override
  final String wireName = r'Product';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Product object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.gtin != null) {
      yield r'gtin';
      yield serializers.serialize(
        object.gtin,
        specifiedType: const FullType(String),
      );
    }
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.variety != null) {
      yield r'variety';
      yield serializers.serialize(
        object.variety,
        specifiedType: const FullType(String),
      );
    }
    if (object.batchPrefix != null) {
      yield r'batchPrefix';
      yield serializers.serialize(
        object.batchPrefix,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Product object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ProductBuilder result,
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
        case r'gtin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.gtin = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'variety':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.variety = valueDes;
          break;
        case r'batchPrefix':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.batchPrefix = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Product deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProductBuilder();
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

