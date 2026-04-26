// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReminderItemCollection on Isar {
  IsarCollection<ReminderItem> get reminderItems => this.collection();
}

const ReminderItemSchema = CollectionSchema(
  name: r'ReminderItem',
  id: 6220093467772847587,
  properties: {
    r'anchorDay': PropertySchema(
      id: 0,
      name: r'anchorDay',
      type: IsarType.long,
    ),
    r'anchorMonth': PropertySchema(
      id: 1,
      name: r'anchorMonth',
      type: IsarType.long,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
      enumMap: _ReminderItemcategoryEnumValueMap,
    ),
    r'completedCount': PropertySchema(
      id: 3,
      name: r'completedCount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deletedAt': PropertySchema(
      id: 5,
      name: r'deletedAt',
      type: IsarType.dateTime,
    ),
    r'dueAt': PropertySchema(
      id: 6,
      name: r'dueAt',
      type: IsarType.dateTime,
    ),
    r'isArchived': PropertySchema(
      id: 7,
      name: r'isArchived',
      type: IsarType.bool,
    ),
    r'lastCompletedAt': PropertySchema(
      id: 8,
      name: r'lastCompletedAt',
      type: IsarType.dateTime,
    ),
    r'note': PropertySchema(
      id: 9,
      name: r'note',
      type: IsarType.string,
    ),
    r'notificationId': PropertySchema(
      id: 10,
      name: r'notificationId',
      type: IsarType.long,
    ),
    r'repeatType': PropertySchema(
      id: 11,
      name: r'repeatType',
      type: IsarType.string,
      enumMap: _ReminderItemrepeatTypeEnumValueMap,
    ),
    r'title': PropertySchema(
      id: 12,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _reminderItemEstimateSize,
  serialize: _reminderItemSerialize,
  deserialize: _reminderItemDeserialize,
  deserializeProp: _reminderItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'dueAt': IndexSchema(
      id: 3701044435752459706,
      name: r'dueAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dueAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'isArchived': IndexSchema(
      id: 655844772568347876,
      name: r'isArchived',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isArchived',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'deletedAt': IndexSchema(
      id: -8969437169173379604,
      name: r'deletedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deletedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _reminderItemGetId,
  getLinks: _reminderItemGetLinks,
  attach: _reminderItemAttach,
  version: '3.1.0+1',
);

int _reminderItemEstimateSize(
  ReminderItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.name.length * 3;
  {
    final value = object.note;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.repeatType.name.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _reminderItemSerialize(
  ReminderItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.anchorDay);
  writer.writeLong(offsets[1], object.anchorMonth);
  writer.writeString(offsets[2], object.category.name);
  writer.writeLong(offsets[3], object.completedCount);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeDateTime(offsets[5], object.deletedAt);
  writer.writeDateTime(offsets[6], object.dueAt);
  writer.writeBool(offsets[7], object.isArchived);
  writer.writeDateTime(offsets[8], object.lastCompletedAt);
  writer.writeString(offsets[9], object.note);
  writer.writeLong(offsets[10], object.notificationId);
  writer.writeString(offsets[11], object.repeatType.name);
  writer.writeString(offsets[12], object.title);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

ReminderItem _reminderItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReminderItem();
  object.anchorDay = reader.readLongOrNull(offsets[0]);
  object.anchorMonth = reader.readLongOrNull(offsets[1]);
  object.category =
      _ReminderItemcategoryValueEnumMap[reader.readStringOrNull(offsets[2])] ??
          Category.card;
  object.completedCount = reader.readLong(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.deletedAt = reader.readDateTimeOrNull(offsets[5]);
  object.dueAt = reader.readDateTime(offsets[6]);
  object.id = id;
  object.isArchived = reader.readBool(offsets[7]);
  object.lastCompletedAt = reader.readDateTimeOrNull(offsets[8]);
  object.note = reader.readStringOrNull(offsets[9]);
  object.notificationId = reader.readLongOrNull(offsets[10]);
  object.repeatType = _ReminderItemrepeatTypeValueEnumMap[
          reader.readStringOrNull(offsets[11])] ??
      RepeatType.once;
  object.title = reader.readString(offsets[12]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _reminderItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (_ReminderItemcategoryValueEnumMap[
              reader.readStringOrNull(offset)] ??
          Category.card) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (_ReminderItemrepeatTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          RepeatType.once) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ReminderItemcategoryEnumValueMap = {
  r'card': r'card',
  r'subscription': r'subscription',
  r'utility': r'utility',
  r'tax': r'tax',
  r'insurance': r'insurance',
  r'loan': r'loan',
  r'other': r'other',
};
const _ReminderItemcategoryValueEnumMap = {
  r'card': Category.card,
  r'subscription': Category.subscription,
  r'utility': Category.utility,
  r'tax': Category.tax,
  r'insurance': Category.insurance,
  r'loan': Category.loan,
  r'other': Category.other,
};
const _ReminderItemrepeatTypeEnumValueMap = {
  r'once': r'once',
  r'daily': r'daily',
  r'weekly': r'weekly',
  r'monthly': r'monthly',
  r'yearly': r'yearly',
};
const _ReminderItemrepeatTypeValueEnumMap = {
  r'once': RepeatType.once,
  r'daily': RepeatType.daily,
  r'weekly': RepeatType.weekly,
  r'monthly': RepeatType.monthly,
  r'yearly': RepeatType.yearly,
};

Id _reminderItemGetId(ReminderItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reminderItemGetLinks(ReminderItem object) {
  return [];
}

void _reminderItemAttach(
    IsarCollection<dynamic> col, Id id, ReminderItem object) {
  object.id = id;
}

extension ReminderItemQueryWhereSort
    on QueryBuilder<ReminderItem, ReminderItem, QWhere> {
  QueryBuilder<ReminderItem, ReminderItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhere> anyDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dueAt'),
      );
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhere> anyIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isArchived'),
      );
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhere> anyDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'deletedAt'),
      );
    });
  }
}

extension ReminderItemQueryWhere
    on QueryBuilder<ReminderItem, ReminderItem, QWhereClause> {
  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> dueAtEqualTo(
      DateTime dueAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dueAt',
        value: [dueAt],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> dueAtNotEqualTo(
      DateTime dueAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueAt',
              lower: [],
              upper: [dueAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueAt',
              lower: [dueAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueAt',
              lower: [dueAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dueAt',
              lower: [],
              upper: [dueAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> dueAtGreaterThan(
    DateTime dueAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueAt',
        lower: [dueAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> dueAtLessThan(
    DateTime dueAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueAt',
        lower: [],
        upper: [dueAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> dueAtBetween(
    DateTime lowerDueAt,
    DateTime upperDueAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dueAt',
        lower: [lowerDueAt],
        includeLower: includeLower,
        upper: [upperDueAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> isArchivedEqualTo(
      bool isArchived) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isArchived',
        value: [isArchived],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause>
      isArchivedNotEqualTo(bool isArchived) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [],
              upper: [isArchived],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [isArchived],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [isArchived],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isArchived',
              lower: [],
              upper: [isArchived],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deletedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deletedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> deletedAtEqualTo(
      DateTime? deletedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deletedAt',
        value: [deletedAt],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause>
      deletedAtNotEqualTo(DateTime? deletedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deletedAt',
              lower: [],
              upper: [deletedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deletedAt',
              lower: [deletedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deletedAt',
              lower: [deletedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deletedAt',
              lower: [],
              upper: [deletedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause>
      deletedAtGreaterThan(
    DateTime? deletedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deletedAt',
        lower: [deletedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> deletedAtLessThan(
    DateTime? deletedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deletedAt',
        lower: [],
        upper: [deletedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterWhereClause> deletedAtBetween(
    DateTime? lowerDeletedAt,
    DateTime? upperDeletedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deletedAt',
        lower: [lowerDeletedAt],
        includeLower: includeLower,
        upper: [upperDeletedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReminderItemQueryFilter
    on QueryBuilder<ReminderItem, ReminderItem, QFilterCondition> {
  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'anchorDay',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'anchorDay',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'anchorDay',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorDayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'anchorDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'anchorMonth',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'anchorMonth',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'anchorMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'anchorMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'anchorMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      anchorMonthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'anchorMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryEqualTo(
    Category value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryGreaterThan(
    Category value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryLessThan(
    Category value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryBetween(
    Category lower,
    Category upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      completedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      completedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      completedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      completedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deletedAt',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      deletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> dueAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      dueAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> dueAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> dueAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      isArchivedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isArchived',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastCompletedAt',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastCompletedAt',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCompletedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      lastCompletedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCompletedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      noteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'note',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      noteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> noteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      notificationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeEqualTo(
    RepeatType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeGreaterThan(
    RepeatType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeLessThan(
    RepeatType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeBetween(
    RepeatType lower,
    RepeatType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'repeatType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'repeatType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      repeatTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'repeatType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReminderItemQueryObject
    on QueryBuilder<ReminderItem, ReminderItem, QFilterCondition> {}

extension ReminderItemQueryLinks
    on QueryBuilder<ReminderItem, ReminderItem, QFilterCondition> {}

extension ReminderItemQuerySortBy
    on QueryBuilder<ReminderItem, ReminderItem, QSortBy> {
  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByAnchorDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByAnchorMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorMonth', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByAnchorMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorMonth', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByCompletedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCount', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByCompletedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCount', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByDueAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByLastCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByLastCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByRepeatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      sortByRepeatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ReminderItemQuerySortThenBy
    on QueryBuilder<ReminderItem, ReminderItem, QSortThenBy> {
  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByAnchorDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorDay', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByAnchorMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorMonth', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByAnchorMonthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anchorMonth', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByCompletedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCount', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByCompletedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedCount', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByDeletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletedAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByDueAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByIsArchivedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isArchived', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByLastCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByLastCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCompletedAt', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'note', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByRepeatType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy>
      thenByRepeatTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repeatType', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ReminderItemQueryWhereDistinct
    on QueryBuilder<ReminderItem, ReminderItem, QDistinct> {
  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByAnchorDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anchorDay');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByAnchorMonth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anchorMonth');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct>
      distinctByCompletedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedCount');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByDeletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deletedAt');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByDueAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueAt');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByIsArchived() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isArchived');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct>
      distinctByLastCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCompletedAt');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'note', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct>
      distinctByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationId');
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByRepeatType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReminderItem, ReminderItem, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ReminderItemQueryProperty
    on QueryBuilder<ReminderItem, ReminderItem, QQueryProperty> {
  QueryBuilder<ReminderItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReminderItem, int?, QQueryOperations> anchorDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anchorDay');
    });
  }

  QueryBuilder<ReminderItem, int?, QQueryOperations> anchorMonthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anchorMonth');
    });
  }

  QueryBuilder<ReminderItem, Category, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<ReminderItem, int, QQueryOperations> completedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedCount');
    });
  }

  QueryBuilder<ReminderItem, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ReminderItem, DateTime?, QQueryOperations> deletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletedAt');
    });
  }

  QueryBuilder<ReminderItem, DateTime, QQueryOperations> dueAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueAt');
    });
  }

  QueryBuilder<ReminderItem, bool, QQueryOperations> isArchivedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isArchived');
    });
  }

  QueryBuilder<ReminderItem, DateTime?, QQueryOperations>
      lastCompletedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCompletedAt');
    });
  }

  QueryBuilder<ReminderItem, String?, QQueryOperations> noteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'note');
    });
  }

  QueryBuilder<ReminderItem, int?, QQueryOperations> notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationId');
    });
  }

  QueryBuilder<ReminderItem, RepeatType, QQueryOperations>
      repeatTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatType');
    });
  }

  QueryBuilder<ReminderItem, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ReminderItem, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
