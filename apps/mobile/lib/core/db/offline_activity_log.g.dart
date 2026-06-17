// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_activity_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOfflineActivityLogCollection on Isar {
  IsarCollection<OfflineActivityLog> get offlineActivityLogs =>
      this.collection();
}

const OfflineActivityLogSchema = CollectionSchema(
  name: r'OfflineActivityLog',
  id: 2594825945662405622,
  properties: {
    r'applicationRate': PropertySchema(
      id: 0,
      name: r'applicationRate',
      type: IsarType.string,
    ),
    r'applicatorLicense': PropertySchema(
      id: 1,
      name: r'applicatorLicense',
      type: IsarType.string,
    ),
    r'batchId': PropertySchema(
      id: 2,
      name: r'batchId',
      type: IsarType.string,
    ),
    r'chemicalExpirationDate': PropertySchema(
      id: 3,
      name: r'chemicalExpirationDate',
      type: IsarType.string,
    ),
    r'chemicalLotNumber': PropertySchema(
      id: 4,
      name: r'chemicalLotNumber',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'customerEmail': PropertySchema(
      id: 6,
      name: r'customerEmail',
      type: IsarType.string,
    ),
    r'customerName': PropertySchema(
      id: 7,
      name: r'customerName',
      type: IsarType.string,
    ),
    r'customerPhone': PropertySchema(
      id: 8,
      name: r'customerPhone',
      type: IsarType.string,
    ),
    r'endTime': PropertySchema(
      id: 9,
      name: r'endTime',
      type: IsarType.string,
    ),
    r'gpsLat': PropertySchema(
      id: 10,
      name: r'gpsLat',
      type: IsarType.double,
    ),
    r'gpsLng': PropertySchema(
      id: 11,
      name: r'gpsLng',
      type: IsarType.double,
    ),
    r'isManualInput': PropertySchema(
      id: 12,
      name: r'isManualInput',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 13,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'locationId': PropertySchema(
      id: 14,
      name: r'locationId',
      type: IsarType.string,
    ),
    r'manualInputComments': PropertySchema(
      id: 15,
      name: r'manualInputComments',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 16,
      name: r'notes',
      type: IsarType.string,
    ),
    r'productId': PropertySchema(
      id: 17,
      name: r'productId',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 18,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'reiEndTime': PropertySchema(
      id: 19,
      name: r'reiEndTime',
      type: IsarType.string,
    ),
    r'startTime': PropertySchema(
      id: 20,
      name: r'startTime',
      type: IsarType.string,
    ),
    r'taskId': PropertySchema(
      id: 21,
      name: r'taskId',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 22,
      name: r'timestamp',
      type: IsarType.string,
    ),
    r'totalPrice': PropertySchema(
      id: 23,
      name: r'totalPrice',
      type: IsarType.double,
    ),
    r'totalQuantityApplied': PropertySchema(
      id: 24,
      name: r'totalQuantityApplied',
      type: IsarType.double,
    ),
    r'type': PropertySchema(
      id: 25,
      name: r'type',
      type: IsarType.string,
    ),
    r'unitPrice': PropertySchema(
      id: 26,
      name: r'unitPrice',
      type: IsarType.double,
    ),
    r'userId': PropertySchema(
      id: 27,
      name: r'userId',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 28,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'verificationStatus': PropertySchema(
      id: 29,
      name: r'verificationStatus',
      type: IsarType.string,
    ),
    r'verifiedAt': PropertySchema(
      id: 30,
      name: r'verifiedAt',
      type: IsarType.string,
    ),
    r'verifiedBy': PropertySchema(
      id: 31,
      name: r'verifiedBy',
      type: IsarType.string,
    ),
    r'weatherTemperature': PropertySchema(
      id: 32,
      name: r'weatherTemperature',
      type: IsarType.double,
    ),
    r'weatherWindDirection': PropertySchema(
      id: 33,
      name: r'weatherWindDirection',
      type: IsarType.string,
    ),
    r'weatherWindSpeed': PropertySchema(
      id: 34,
      name: r'weatherWindSpeed',
      type: IsarType.double,
    )
  },
  estimateSize: _offlineActivityLogEstimateSize,
  serialize: _offlineActivityLogSerialize,
  deserialize: _offlineActivityLogDeserialize,
  deserializeProp: _offlineActivityLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _offlineActivityLogGetId,
  getLinks: _offlineActivityLogGetLinks,
  attach: _offlineActivityLogAttach,
  version: '3.1.0+1',
);

int _offlineActivityLogEstimateSize(
  OfflineActivityLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.applicationRate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.applicatorLicense;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.batchId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.chemicalExpirationDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.chemicalLotNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customerEmail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.customerPhone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.endTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.locationId.length * 3;
  {
    final value = object.manualInputComments;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.reiEndTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.startTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.taskId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.timestamp.length * 3;
  bytesCount += 3 + object.type.length * 3;
  bytesCount += 3 + object.userId.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  {
    final value = object.verificationStatus;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.verifiedAt;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.verifiedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.weatherWindDirection;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _offlineActivityLogSerialize(
  OfflineActivityLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.applicationRate);
  writer.writeString(offsets[1], object.applicatorLicense);
  writer.writeString(offsets[2], object.batchId);
  writer.writeString(offsets[3], object.chemicalExpirationDate);
  writer.writeString(offsets[4], object.chemicalLotNumber);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeString(offsets[6], object.customerEmail);
  writer.writeString(offsets[7], object.customerName);
  writer.writeString(offsets[8], object.customerPhone);
  writer.writeString(offsets[9], object.endTime);
  writer.writeDouble(offsets[10], object.gpsLat);
  writer.writeDouble(offsets[11], object.gpsLng);
  writer.writeBool(offsets[12], object.isManualInput);
  writer.writeBool(offsets[13], object.isSynced);
  writer.writeString(offsets[14], object.locationId);
  writer.writeString(offsets[15], object.manualInputComments);
  writer.writeString(offsets[16], object.notes);
  writer.writeString(offsets[17], object.productId);
  writer.writeLong(offsets[18], object.quantity);
  writer.writeString(offsets[19], object.reiEndTime);
  writer.writeString(offsets[20], object.startTime);
  writer.writeString(offsets[21], object.taskId);
  writer.writeString(offsets[22], object.timestamp);
  writer.writeDouble(offsets[23], object.totalPrice);
  writer.writeDouble(offsets[24], object.totalQuantityApplied);
  writer.writeString(offsets[25], object.type);
  writer.writeDouble(offsets[26], object.unitPrice);
  writer.writeString(offsets[27], object.userId);
  writer.writeString(offsets[28], object.uuid);
  writer.writeString(offsets[29], object.verificationStatus);
  writer.writeString(offsets[30], object.verifiedAt);
  writer.writeString(offsets[31], object.verifiedBy);
  writer.writeDouble(offsets[32], object.weatherTemperature);
  writer.writeString(offsets[33], object.weatherWindDirection);
  writer.writeDouble(offsets[34], object.weatherWindSpeed);
}

OfflineActivityLog _offlineActivityLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OfflineActivityLog();
  object.applicationRate = reader.readStringOrNull(offsets[0]);
  object.applicatorLicense = reader.readStringOrNull(offsets[1]);
  object.batchId = reader.readStringOrNull(offsets[2]);
  object.chemicalExpirationDate = reader.readStringOrNull(offsets[3]);
  object.chemicalLotNumber = reader.readStringOrNull(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.customerEmail = reader.readStringOrNull(offsets[6]);
  object.customerName = reader.readStringOrNull(offsets[7]);
  object.customerPhone = reader.readStringOrNull(offsets[8]);
  object.endTime = reader.readStringOrNull(offsets[9]);
  object.gpsLat = reader.readDoubleOrNull(offsets[10]);
  object.gpsLng = reader.readDoubleOrNull(offsets[11]);
  object.id = id;
  object.isManualInput = reader.readBoolOrNull(offsets[12]);
  object.isSynced = reader.readBool(offsets[13]);
  object.locationId = reader.readString(offsets[14]);
  object.manualInputComments = reader.readStringOrNull(offsets[15]);
  object.notes = reader.readStringOrNull(offsets[16]);
  object.productId = reader.readStringOrNull(offsets[17]);
  object.quantity = reader.readLongOrNull(offsets[18]);
  object.reiEndTime = reader.readStringOrNull(offsets[19]);
  object.startTime = reader.readStringOrNull(offsets[20]);
  object.taskId = reader.readStringOrNull(offsets[21]);
  object.timestamp = reader.readString(offsets[22]);
  object.totalPrice = reader.readDoubleOrNull(offsets[23]);
  object.totalQuantityApplied = reader.readDoubleOrNull(offsets[24]);
  object.type = reader.readString(offsets[25]);
  object.unitPrice = reader.readDoubleOrNull(offsets[26]);
  object.userId = reader.readString(offsets[27]);
  object.uuid = reader.readString(offsets[28]);
  object.verificationStatus = reader.readStringOrNull(offsets[29]);
  object.verifiedAt = reader.readStringOrNull(offsets[30]);
  object.verifiedBy = reader.readStringOrNull(offsets[31]);
  object.weatherTemperature = reader.readDoubleOrNull(offsets[32]);
  object.weatherWindDirection = reader.readStringOrNull(offsets[33]);
  object.weatherWindSpeed = reader.readDoubleOrNull(offsets[34]);
  return object;
}

P _offlineActivityLogDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readLongOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readDoubleOrNull(offset)) as P;
    case 27:
      return (reader.readString(offset)) as P;
    case 28:
      return (reader.readString(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readStringOrNull(offset)) as P;
    case 32:
      return (reader.readDoubleOrNull(offset)) as P;
    case 33:
      return (reader.readStringOrNull(offset)) as P;
    case 34:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _offlineActivityLogGetId(OfflineActivityLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _offlineActivityLogGetLinks(
    OfflineActivityLog object) {
  return [];
}

void _offlineActivityLogAttach(
    IsarCollection<dynamic> col, Id id, OfflineActivityLog object) {
  object.id = id;
}

extension OfflineActivityLogByIndex on IsarCollection<OfflineActivityLog> {
  Future<OfflineActivityLog?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  OfflineActivityLog? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<OfflineActivityLog?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<OfflineActivityLog?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(OfflineActivityLog object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(OfflineActivityLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<OfflineActivityLog> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<OfflineActivityLog> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension OfflineActivityLogQueryWhereSort
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QWhere> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OfflineActivityLogQueryWhere
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QWhereClause> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension OfflineActivityLogQueryFilter
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QFilterCondition> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'applicationRate',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'applicationRate',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicationRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicationRate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicationRate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicationRate',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicationRateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicationRate',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'applicatorLicense',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'applicatorLicense',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'applicatorLicense',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'applicatorLicense',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'applicatorLicense',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'applicatorLicense',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      applicatorLicenseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'applicatorLicense',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'batchId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'batchId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'batchId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'batchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'batchId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batchId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      batchIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'batchId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chemicalExpirationDate',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chemicalExpirationDate',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chemicalExpirationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chemicalExpirationDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chemicalExpirationDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chemicalExpirationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalExpirationDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chemicalExpirationDate',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chemicalLotNumber',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chemicalLotNumber',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chemicalLotNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chemicalLotNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chemicalLotNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chemicalLotNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      chemicalLotNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chemicalLotNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customerEmail',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customerEmail',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customerName',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customerName',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerName',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'customerPhone',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'customerPhone',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customerPhone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customerPhone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customerPhone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      customerPhoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customerPhone',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      endTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gpsLat',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gpsLat',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpsLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gpsLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gpsLat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLatBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gpsLat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gpsLng',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gpsLng',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gpsLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gpsLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gpsLng',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      gpsLngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gpsLng',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      isManualInputIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isManualInput',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      isManualInputIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isManualInput',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      isManualInputEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isManualInput',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      locationIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manualInputComments',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manualInputComments',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manualInputComments',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manualInputComments',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manualInputComments',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manualInputComments',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      manualInputCommentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manualInputComments',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdEqualTo(
    String? value, {
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdGreaterThan(
    String? value, {
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdLessThan(
    String? value, {
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      quantityBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'reiEndTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'reiEndTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reiEndTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reiEndTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reiEndTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reiEndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      reiEndTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reiEndTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startTime',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'startTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'startTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      startTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'startTime',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taskId',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      taskIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timestamp',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timestamp',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      timestampIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timestamp',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalPrice',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalPrice',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalQuantityApplied',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalQuantityApplied',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalQuantityApplied',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalQuantityApplied',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalQuantityApplied',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      totalQuantityAppliedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalQuantityApplied',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
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

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unitPrice',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unitPrice',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      unitPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verificationStatus',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verificationStatus',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verificationStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verificationStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verificationStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verificationStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verificationStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verificationStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifiedAt',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifiedAt',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifiedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verifiedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verifiedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verifiedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'verifiedBy',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'verifiedBy',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verifiedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verifiedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verifiedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verifiedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      verifiedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verifiedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weatherTemperature',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weatherTemperature',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weatherTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weatherTemperature',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherTemperatureBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weatherTemperature',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weatherWindDirection',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weatherWindDirection',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weatherWindDirection',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weatherWindDirection',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weatherWindDirection',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherWindDirection',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindDirectionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weatherWindDirection',
        value: '',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weatherWindSpeed',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weatherWindSpeed',
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weatherWindSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weatherWindSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weatherWindSpeed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterFilterCondition>
      weatherWindSpeedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weatherWindSpeed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension OfflineActivityLogQueryObject
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QFilterCondition> {}

extension OfflineActivityLogQueryLinks
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QFilterCondition> {}

extension OfflineActivityLogQuerySortBy
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QSortBy> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByApplicationRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationRate', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByApplicationRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationRate', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByApplicatorLicense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicatorLicense', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByApplicatorLicenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicatorLicense', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByBatchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByBatchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByChemicalExpirationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalExpirationDate', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByChemicalExpirationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalExpirationDate', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByChemicalLotNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalLotNumber', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByChemicalLotNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalLotNumber', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerEmail', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerEmail', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByCustomerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByGpsLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLat', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByGpsLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLat', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByGpsLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLng', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByGpsLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLng', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByIsManualInput() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualInput', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByIsManualInputDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualInput', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByManualInputComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualInputComments', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByManualInputCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualInputComments', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByReiEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiEndTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByReiEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiEndTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTotalQuantityApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuantityApplied', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTotalQuantityAppliedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuantityApplied', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUnitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerificationStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verificationStatus', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerificationStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verificationStatus', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerifiedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedBy', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByVerifiedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedBy', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherTemperature', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherTemperature', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherWindDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindDirection', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherWindDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindDirection', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindSpeed', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      sortByWeatherWindSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindSpeed', Sort.desc);
    });
  }
}

extension OfflineActivityLogQuerySortThenBy
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QSortThenBy> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByApplicationRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationRate', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByApplicationRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicationRate', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByApplicatorLicense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicatorLicense', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByApplicatorLicenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'applicatorLicense', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByBatchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByBatchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batchId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByChemicalExpirationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalExpirationDate', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByChemicalExpirationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalExpirationDate', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByChemicalLotNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalLotNumber', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByChemicalLotNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chemicalLotNumber', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerEmail', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerEmail', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerName', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByCustomerPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customerPhone', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByGpsLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLat', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByGpsLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLat', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByGpsLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLng', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByGpsLngDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gpsLng', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByIsManualInput() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualInput', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByIsManualInputDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isManualInput', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByLocationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByLocationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByManualInputComments() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualInputComments', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByManualInputCommentsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manualInputComments', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByReiEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiEndTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByReiEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reiEndTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTotalQuantityApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuantityApplied', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTotalQuantityAppliedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuantityApplied', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUnitPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitPrice', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerificationStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verificationStatus', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerificationStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verificationStatus', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerifiedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerifiedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedAt', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerifiedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedBy', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByVerifiedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verifiedBy', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherTemperature', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherTemperatureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherTemperature', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherWindDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindDirection', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherWindDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindDirection', Sort.desc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindSpeed', Sort.asc);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QAfterSortBy>
      thenByWeatherWindSpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weatherWindSpeed', Sort.desc);
    });
  }
}

extension OfflineActivityLogQueryWhereDistinct
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct> {
  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByApplicationRate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicationRate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByApplicatorLicense({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'applicatorLicense',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByBatchId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'batchId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByChemicalExpirationDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chemicalExpirationDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByChemicalLotNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chemicalLotNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByCustomerEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerEmail',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByCustomerName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByCustomerPhone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customerPhone',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByEndTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByGpsLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLat');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByGpsLng() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gpsLng');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByIsManualInput() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isManualInput');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByLocationId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByManualInputComments({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manualInputComments',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByProductId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByReiEndTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reiEndTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByStartTime({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByTaskId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByTimestamp({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPrice');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByTotalQuantityApplied() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalQuantityApplied');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByUnitPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unitPrice');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByVerificationStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verificationStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByVerifiedAt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifiedAt', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByVerifiedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verifiedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByWeatherTemperature() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weatherTemperature');
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByWeatherWindDirection({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weatherWindDirection',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OfflineActivityLog, OfflineActivityLog, QDistinct>
      distinctByWeatherWindSpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weatherWindSpeed');
    });
  }
}

extension OfflineActivityLogQueryProperty
    on QueryBuilder<OfflineActivityLog, OfflineActivityLog, QQueryProperty> {
  QueryBuilder<OfflineActivityLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      applicationRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicationRate');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      applicatorLicenseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'applicatorLicense');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      batchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'batchId');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      chemicalExpirationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chemicalExpirationDate');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      chemicalLotNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chemicalLotNumber');
    });
  }

  QueryBuilder<OfflineActivityLog, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      customerEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerEmail');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      customerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerName');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      customerPhoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customerPhone');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations> gpsLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLat');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations> gpsLngProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gpsLng');
    });
  }

  QueryBuilder<OfflineActivityLog, bool?, QQueryOperations>
      isManualInputProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isManualInput');
    });
  }

  QueryBuilder<OfflineActivityLog, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<OfflineActivityLog, String, QQueryOperations>
      locationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationId');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      manualInputCommentsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manualInputComments');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<OfflineActivityLog, int?, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      reiEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reiEndTime');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations> taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<OfflineActivityLog, String, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations>
      totalPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPrice');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations>
      totalQuantityAppliedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalQuantityApplied');
    });
  }

  QueryBuilder<OfflineActivityLog, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations>
      unitPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unitPrice');
    });
  }

  QueryBuilder<OfflineActivityLog, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<OfflineActivityLog, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      verificationStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verificationStatus');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      verifiedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifiedAt');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      verifiedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verifiedBy');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations>
      weatherTemperatureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherTemperature');
    });
  }

  QueryBuilder<OfflineActivityLog, String?, QQueryOperations>
      weatherWindDirectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherWindDirection');
    });
  }

  QueryBuilder<OfflineActivityLog, double?, QQueryOperations>
      weatherWindSpeedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weatherWindSpeed');
    });
  }
}
