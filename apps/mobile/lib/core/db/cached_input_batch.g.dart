// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_input_batch.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedInputBatchCollection on Isar {
  IsarCollection<CachedInputBatch> get cachedInputBatchs => this.collection();
}

const CachedInputBatchSchema = CollectionSchema(
  name: r'CachedInputBatch',
  id: 5095366503610583055,
  properties: {
    r'expirationDate': PropertySchema(
      id: 0,
      name: r'expirationDate',
      type: IsarType.string,
    ),
    r'gtin': PropertySchema(
      id: 1,
      name: r'gtin',
      type: IsarType.string,
    ),
    r'lotNumber': PropertySchema(
      id: 2,
      name: r'lotNumber',
      type: IsarType.string,
    ),
    r'productId': PropertySchema(
      id: 3,
      name: r'productId',
      type: IsarType.string,
    ),
    r'remainingQuantity': PropertySchema(
      id: 4,
      name: r'remainingQuantity',
      type: IsarType.double,
    ),
    r'unit': PropertySchema(
      id: 5,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedInputBatchEstimateSize,
  serialize: _cachedInputBatchSerialize,
  deserialize: _cachedInputBatchDeserialize,
  deserializeProp: _cachedInputBatchDeserializeProp,
  idName: r'id',
  indexes: {
    r'gtin': IndexSchema(
      id: -5635237946550230413,
      name: r'gtin',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'gtin',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'lotNumber': IndexSchema(
      id: 4378911178298764563,
      name: r'lotNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lotNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedInputBatchGetId,
  getLinks: _cachedInputBatchGetLinks,
  attach: _cachedInputBatchAttach,
  version: '3.1.0+1',
);

int _cachedInputBatchEstimateSize(
  CachedInputBatch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.expirationDate.length * 3;
  bytesCount += 3 + object.gtin.length * 3;
  bytesCount += 3 + object.lotNumber.length * 3;
  bytesCount += 3 + object.productId.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _cachedInputBatchSerialize(
  CachedInputBatch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.expirationDate);
  writer.writeString(offsets[1], object.gtin);
  writer.writeString(offsets[2], object.lotNumber);
  writer.writeString(offsets[3], object.productId);
  writer.writeDouble(offsets[4], object.remainingQuantity);
  writer.writeString(offsets[5], object.unit);
}

CachedInputBatch _cachedInputBatchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedInputBatch();
  object.expirationDate = reader.readString(offsets[0]);
  object.gtin = reader.readString(offsets[1]);
  object.id = id;
  object.lotNumber = reader.readString(offsets[2]);
  object.productId = reader.readString(offsets[3]);
  object.remainingQuantity = reader.readDouble(offsets[4]);
  object.unit = reader.readString(offsets[5]);
  return object;
}

P _cachedInputBatchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedInputBatchGetId(CachedInputBatch object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedInputBatchGetLinks(CachedInputBatch object) {
  return [];
}

void _cachedInputBatchAttach(
    IsarCollection<dynamic> col, Id id, CachedInputBatch object) {
  object.id = id;
}

extension CachedInputBatchQueryWhereSort
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QWhere> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedInputBatchQueryWhere
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QWhereClause> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      gtinEqualTo(String gtin) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gtin',
        value: [gtin],
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      gtinNotEqualTo(String gtin) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gtin',
              lower: [],
              upper: [gtin],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gtin',
              lower: [gtin],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gtin',
              lower: [gtin],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'gtin',
              lower: [],
              upper: [gtin],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      lotNumberEqualTo(String lotNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lotNumber',
        value: [lotNumber],
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterWhereClause>
      lotNumberNotEqualTo(String lotNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lotNumber',
              lower: [],
              upper: [lotNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lotNumber',
              lower: [lotNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lotNumber',
              lower: [lotNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lotNumber',
              lower: [],
              upper: [lotNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CachedInputBatchQueryFilter
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QFilterCondition> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expirationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expirationDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expirationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      expirationDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expirationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gtin',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gtin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gtin',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      gtinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gtin',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lotNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lotNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lotNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      lotNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lotNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      remainingQuantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remainingQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      remainingQuantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remainingQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      remainingQuantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remainingQuantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      remainingQuantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remainingQuantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension CachedInputBatchQueryObject
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QFilterCondition> {}

extension CachedInputBatchQueryLinks
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QFilterCondition> {}

extension CachedInputBatchQuerySortBy
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QSortBy> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByExpirationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expirationDate', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByExpirationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expirationDate', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy> sortByGtin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByGtinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByLotNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lotNumber', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByLotNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lotNumber', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByRemainingQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingQuantity', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByRemainingQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingQuantity', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension CachedInputBatchQuerySortThenBy
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QSortThenBy> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByExpirationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expirationDate', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByExpirationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expirationDate', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy> thenByGtin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByGtinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByLotNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lotNumber', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByLotNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lotNumber', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByRemainingQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingQuantity', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByRemainingQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remainingQuantity', Sort.desc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QAfterSortBy>
      thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }
}

extension CachedInputBatchQueryWhereDistinct
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct> {
  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct>
      distinctByExpirationDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expirationDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct> distinctByGtin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gtin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct>
      distinctByLotNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lotNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct>
      distinctByProductId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct>
      distinctByRemainingQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remainingQuantity');
    });
  }

  QueryBuilder<CachedInputBatch, CachedInputBatch, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }
}

extension CachedInputBatchQueryProperty
    on QueryBuilder<CachedInputBatch, CachedInputBatch, QQueryProperty> {
  QueryBuilder<CachedInputBatch, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedInputBatch, String, QQueryOperations>
      expirationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expirationDate');
    });
  }

  QueryBuilder<CachedInputBatch, String, QQueryOperations> gtinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gtin');
    });
  }

  QueryBuilder<CachedInputBatch, String, QQueryOperations> lotNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lotNumber');
    });
  }

  QueryBuilder<CachedInputBatch, String, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<CachedInputBatch, double, QQueryOperations>
      remainingQuantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remainingQuantity');
    });
  }

  QueryBuilder<CachedInputBatch, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }
}
