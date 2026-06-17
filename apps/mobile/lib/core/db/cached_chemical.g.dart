// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_chemical.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCachedChemicalCollection on Isar {
  IsarCollection<CachedChemical> get cachedChemicals => this.collection();
}

const CachedChemicalSchema = CollectionSchema(
  name: r'CachedChemical',
  id: 9127929712676137677,
  properties: {
    r'activeIngredients': PropertySchema(
      id: 0,
      name: r'activeIngredients',
      type: IsarType.string,
    ),
    r'adminNotes': PropertySchema(
      id: 1,
      name: r'adminNotes',
      type: IsarType.string,
    ),
    r'epaRegistrationNumber': PropertySchema(
      id: 2,
      name: r'epaRegistrationNumber',
      type: IsarType.string,
    ),
    r'gtin': PropertySchema(
      id: 3,
      name: r'gtin',
      type: IsarType.string,
    ),
    r'isLocalOnly': PropertySchema(
      id: 4,
      name: r'isLocalOnly',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'phiDays': PropertySchema(
      id: 6,
      name: r'phiDays',
      type: IsarType.long,
    ),
    r'reiHours': PropertySchema(
      id: 7,
      name: r'reiHours',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
    ),
    r'variety': PropertySchema(
      id: 9,
      name: r'variety',
      type: IsarType.string,
    )
  },
  estimateSize: _cachedChemicalEstimateSize,
  serialize: _cachedChemicalSerialize,
  deserialize: _cachedChemicalDeserialize,
  deserializeProp: _cachedChemicalDeserializeProp,
  idName: r'id',
  indexes: {
    r'gtin': IndexSchema(
      id: -5635237946550230413,
      name: r'gtin',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'gtin',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cachedChemicalGetId,
  getLinks: _cachedChemicalGetLinks,
  attach: _cachedChemicalAttach,
  version: '3.1.0+1',
);

int _cachedChemicalEstimateSize(
  CachedChemical object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activeIngredients;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.adminNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.epaRegistrationNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.gtin.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  {
    final value = object.variety;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _cachedChemicalSerialize(
  CachedChemical object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activeIngredients);
  writer.writeString(offsets[1], object.adminNotes);
  writer.writeString(offsets[2], object.epaRegistrationNumber);
  writer.writeString(offsets[3], object.gtin);
  writer.writeBool(offsets[4], object.isLocalOnly);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.phiDays);
  writer.writeLong(offsets[7], object.reiHours);
  writer.writeString(offsets[8], object.type);
  writer.writeString(offsets[9], object.variety);
}

CachedChemical _cachedChemicalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CachedChemical();
  object.activeIngredients = reader.readStringOrNull(offsets[0]);
  object.adminNotes = reader.readStringOrNull(offsets[1]);
  object.epaRegistrationNumber = reader.readStringOrNull(offsets[2]);
  object.gtin = reader.readString(offsets[3]);
  object.id = id;
  object.isLocalOnly = reader.readBool(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.phiDays = reader.readLongOrNull(offsets[6]);
  object.reiHours = reader.readLongOrNull(offsets[7]);
  object.type = reader.readString(offsets[8]);
  object.variety = reader.readStringOrNull(offsets[9]);
  return object;
}

P _cachedChemicalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cachedChemicalGetId(CachedChemical object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cachedChemicalGetLinks(CachedChemical object) {
  return [];
}

void _cachedChemicalAttach(
    IsarCollection<dynamic> col, Id id, CachedChemical object) {
  object.id = id;
}

extension CachedChemicalByIndex on IsarCollection<CachedChemical> {
  Future<CachedChemical?> getByGtin(String gtin) {
    return getByIndex(r'gtin', [gtin]);
  }

  CachedChemical? getByGtinSync(String gtin) {
    return getByIndexSync(r'gtin', [gtin]);
  }

  Future<bool> deleteByGtin(String gtin) {
    return deleteByIndex(r'gtin', [gtin]);
  }

  bool deleteByGtinSync(String gtin) {
    return deleteByIndexSync(r'gtin', [gtin]);
  }

  Future<List<CachedChemical?>> getAllByGtin(List<String> gtinValues) {
    final values = gtinValues.map((e) => [e]).toList();
    return getAllByIndex(r'gtin', values);
  }

  List<CachedChemical?> getAllByGtinSync(List<String> gtinValues) {
    final values = gtinValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'gtin', values);
  }

  Future<int> deleteAllByGtin(List<String> gtinValues) {
    final values = gtinValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'gtin', values);
  }

  int deleteAllByGtinSync(List<String> gtinValues) {
    final values = gtinValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'gtin', values);
  }

  Future<Id> putByGtin(CachedChemical object) {
    return putByIndex(r'gtin', object);
  }

  Id putByGtinSync(CachedChemical object, {bool saveLinks = true}) {
    return putByIndexSync(r'gtin', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByGtin(List<CachedChemical> objects) {
    return putAllByIndex(r'gtin', objects);
  }

  List<Id> putAllByGtinSync(List<CachedChemical> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'gtin', objects, saveLinks: saveLinks);
  }
}

extension CachedChemicalQueryWhereSort
    on QueryBuilder<CachedChemical, CachedChemical, QWhere> {
  QueryBuilder<CachedChemical, CachedChemical, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CachedChemicalQueryWhere
    on QueryBuilder<CachedChemical, CachedChemical, QWhereClause> {
  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> idBetween(
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause> gtinEqualTo(
      String gtin) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'gtin',
        value: [gtin],
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterWhereClause>
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
}

extension CachedChemicalQueryFilter
    on QueryBuilder<CachedChemical, CachedChemical, QFilterCondition> {
  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activeIngredients',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activeIngredients',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activeIngredients',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activeIngredients',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activeIngredients',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activeIngredients',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      activeIngredientsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activeIngredients',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'adminNotes',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'adminNotes',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      adminNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'epaRegistrationNumber',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'epaRegistrationNumber',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'epaRegistrationNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'epaRegistrationNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'epaRegistrationNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'epaRegistrationNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      epaRegistrationNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'epaRegistrationNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      gtinContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gtin',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      gtinMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gtin',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      gtinIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gtin',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      gtinIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gtin',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      isLocalOnlyEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLocalOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phiDays',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phiDays',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phiDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phiDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phiDays',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      phiDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phiDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reiHours',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reiHours',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reiHours',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reiHours',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reiHours',
        value: value,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      reiHoursBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reiHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'variety',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'variety',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'variety',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'variety',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'variety',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'variety',
        value: '',
      ));
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterFilterCondition>
      varietyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'variety',
        value: '',
      ));
    });
  }
}

extension CachedChemicalQueryObject
    on QueryBuilder<CachedChemical, CachedChemical, QFilterCondition> {}

extension CachedChemicalQueryLinks
    on QueryBuilder<CachedChemical, CachedChemical, QFilterCondition> {}

extension CachedChemicalQuerySortBy
    on QueryBuilder<CachedChemical, CachedChemical, QSortBy> {
  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByActiveIngredients() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredients', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByActiveIngredientsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredients', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByAdminNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminNotes', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByAdminNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminNotes', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByEpaRegistrationNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epaRegistrationNumber', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByEpaRegistrationNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epaRegistrationNumber', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByGtin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByGtinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByIsLocalOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalOnly', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByIsLocalOnlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalOnly', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByPhiDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phiDays', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByPhiDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phiDays', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByReiHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiHours', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByReiHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiHours', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> sortByVariety() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variety', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      sortByVarietyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variety', Sort.desc);
    });
  }
}

extension CachedChemicalQuerySortThenBy
    on QueryBuilder<CachedChemical, CachedChemical, QSortThenBy> {
  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByActiveIngredients() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredients', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByActiveIngredientsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activeIngredients', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByAdminNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminNotes', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByAdminNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminNotes', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByEpaRegistrationNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epaRegistrationNumber', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByEpaRegistrationNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'epaRegistrationNumber', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByGtin() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByGtinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gtin', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByIsLocalOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalOnly', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByIsLocalOnlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLocalOnly', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByPhiDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phiDays', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByPhiDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phiDays', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByReiHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiHours', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByReiHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiHours', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy> thenByVariety() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variety', Sort.asc);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QAfterSortBy>
      thenByVarietyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'variety', Sort.desc);
    });
  }
}

extension CachedChemicalQueryWhereDistinct
    on QueryBuilder<CachedChemical, CachedChemical, QDistinct> {
  QueryBuilder<CachedChemical, CachedChemical, QDistinct>
      distinctByActiveIngredients({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activeIngredients',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByAdminNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct>
      distinctByEpaRegistrationNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'epaRegistrationNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByGtin(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gtin', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct>
      distinctByIsLocalOnly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLocalOnly');
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByPhiDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phiDays');
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByReiHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reiHours');
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CachedChemical, CachedChemical, QDistinct> distinctByVariety(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'variety', caseSensitive: caseSensitive);
    });
  }
}

extension CachedChemicalQueryProperty
    on QueryBuilder<CachedChemical, CachedChemical, QQueryProperty> {
  QueryBuilder<CachedChemical, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CachedChemical, String?, QQueryOperations>
      activeIngredientsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activeIngredients');
    });
  }

  QueryBuilder<CachedChemical, String?, QQueryOperations> adminNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminNotes');
    });
  }

  QueryBuilder<CachedChemical, String?, QQueryOperations>
      epaRegistrationNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'epaRegistrationNumber');
    });
  }

  QueryBuilder<CachedChemical, String, QQueryOperations> gtinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gtin');
    });
  }

  QueryBuilder<CachedChemical, bool, QQueryOperations> isLocalOnlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLocalOnly');
    });
  }

  QueryBuilder<CachedChemical, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CachedChemical, int?, QQueryOperations> phiDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phiDays');
    });
  }

  QueryBuilder<CachedChemical, int?, QQueryOperations> reiHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reiHours');
    });
  }

  QueryBuilder<CachedChemical, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<CachedChemical, String?, QQueryOperations> varietyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'variety');
    });
  }
}
