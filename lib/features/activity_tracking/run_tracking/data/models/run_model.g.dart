// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRunModelCollection on Isar {
  IsarCollection<RunModel> get runModels => this.collection();
}

const RunModelSchema = CollectionSchema(
  name: r'Run',
  id: 2128482587533090419,
  properties: {
    r'distance': PropertySchema(
      id: 0,
      name: r'distance',
      type: IsarType.double,
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'pausedDurationMillis': PropertySchema(
      id: 2,
      name: r'pausedDurationMillis',
      type: IsarType.long,
    ),
    r'points': PropertySchema(
      id: 3,
      name: r'points',
      type: IsarType.objectList,

      target: r'RunPointModel',
    ),
    r'startTime': PropertySchema(
      id: 4,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'state': PropertySchema(
      id: 5,
      name: r'state',
      type: IsarType.string,
      enumMap: _RunModelstateEnumValueMap,
    ),
  },

  estimateSize: _runModelEstimateSize,
  serialize: _runModelSerialize,
  deserialize: _runModelDeserialize,
  deserializeProp: _runModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'RunPointModel': RunPointModelSchema},

  getId: _runModelGetId,
  getLinks: _runModelGetLinks,
  attach: _runModelAttach,
  version: '3.3.0',
);

int _runModelEstimateSize(
  RunModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.points.length * 3;
  {
    final offsets = allOffsets[RunPointModel]!;
    for (var i = 0; i < object.points.length; i++) {
      final value = object.points[i];
      bytesCount += RunPointModelSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  bytesCount += 3 + object.state.name.length * 3;
  return bytesCount;
}

void _runModelSerialize(
  RunModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.distance);
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeLong(offsets[2], object.pausedDurationMillis);
  writer.writeObjectList<RunPointModel>(
    offsets[3],
    allOffsets,
    RunPointModelSchema.serialize,
    object.points,
  );
  writer.writeDateTime(offsets[4], object.startTime);
  writer.writeString(offsets[5], object.state.name);
}

RunModel _runModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RunModel(
    reader.readDateTime(offsets[4]),
    distance: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    endTime: reader.readDateTimeOrNull(offsets[1]),
    state:
        _RunModelstateValueEnumMap[reader.readStringOrNull(offsets[5])] ??
        RunState.completed,
  );
  object.id = id;
  object.pausedDurationMillis = reader.readLong(offsets[2]);
  object.points =
      reader.readObjectList<RunPointModel>(
        offsets[3],
        RunPointModelSchema.deserialize,
        allOffsets,
        RunPointModel(),
      ) ??
      [];
  return object;
}

P _runModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectList<RunPointModel>(
                offset,
                RunPointModelSchema.deserialize,
                allOffsets,
                RunPointModel(),
              ) ??
              [])
          as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (_RunModelstateValueEnumMap[reader.readStringOrNull(offset)] ??
              RunState.completed)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RunModelstateEnumValueMap = {
  r'notStarted': r'notStarted',
  r'active': r'active',
  r'paused': r'paused',
  r'completed': r'completed',
};
const _RunModelstateValueEnumMap = {
  r'notStarted': RunState.notStarted,
  r'active': RunState.active,
  r'paused': RunState.paused,
  r'completed': RunState.completed,
};

Id _runModelGetId(RunModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _runModelGetLinks(RunModel object) {
  return [];
}

void _runModelAttach(IsarCollection<dynamic> col, Id id, RunModel object) {
  object.id = id;
}

extension RunModelQueryWhereSort on QueryBuilder<RunModel, RunModel, QWhere> {
  QueryBuilder<RunModel, RunModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RunModelQueryWhere on QueryBuilder<RunModel, RunModel, QWhereClause> {
  QueryBuilder<RunModel, RunModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RunModel, RunModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension RunModelQueryFilter
    on QueryBuilder<RunModel, RunModel, QFilterCondition> {
  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> distanceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'distance',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> distanceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'distance',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> distanceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'distance',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> distanceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'distance',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'endTime'),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'endTime', value: value),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'endTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> endTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'endTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pausedDurationMillisEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pausedDurationMillis',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pausedDurationMillisGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pausedDurationMillis',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pausedDurationMillisLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pausedDurationMillis',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pausedDurationMillisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pausedDurationMillis',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'points', length, true, length, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'points', 0, true, 0, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'points', 0, false, 999999, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'points', 0, true, length, include);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pointsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'points', length, include, 999999, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'points',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> startTimeEqualTo(
    DateTime value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'startTime', value: value),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'startTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'startTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateEqualTo(
    RunState value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateGreaterThan(
    RunState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateLessThan(
    RunState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateBetween(
    RunState lower,
    RunState upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'state',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'state',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'state',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'state', value: ''),
      );
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'state', value: ''),
      );
    });
  }
}

extension RunModelQueryObject
    on QueryBuilder<RunModel, RunModel, QFilterCondition> {
  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsElement(
    FilterQuery<RunPointModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'points');
    });
  }
}

extension RunModelQueryLinks
    on QueryBuilder<RunModel, RunModel, QFilterCondition> {}

extension RunModelQuerySortBy on QueryBuilder<RunModel, RunModel, QSortBy> {
  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByPausedDurationMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedDurationMillis', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy>
  sortByPausedDurationMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedDurationMillis', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension RunModelQuerySortThenBy
    on QueryBuilder<RunModel, RunModel, QSortThenBy> {
  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByDistanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distance', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByPausedDurationMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedDurationMillis', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy>
  thenByPausedDurationMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedDurationMillis', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension RunModelQueryWhereDistinct
    on QueryBuilder<RunModel, RunModel, QDistinct> {
  QueryBuilder<RunModel, RunModel, QDistinct> distinctByDistance() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distance');
    });
  }

  QueryBuilder<RunModel, RunModel, QDistinct> distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<RunModel, RunModel, QDistinct> distinctByPausedDurationMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pausedDurationMillis');
    });
  }

  QueryBuilder<RunModel, RunModel, QDistinct> distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<RunModel, RunModel, QDistinct> distinctByState({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }
}

extension RunModelQueryProperty
    on QueryBuilder<RunModel, RunModel, QQueryProperty> {
  QueryBuilder<RunModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RunModel, double, QQueryOperations> distanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distance');
    });
  }

  QueryBuilder<RunModel, DateTime?, QQueryOperations> endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<RunModel, int, QQueryOperations> pausedDurationMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pausedDurationMillis');
    });
  }

  QueryBuilder<RunModel, List<RunPointModel>, QQueryOperations>
  pointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'points');
    });
  }

  QueryBuilder<RunModel, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<RunModel, RunState, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const RunPointModelSchema = Schema(
  name: r'RunPointModel',
  id: -2832079610438716886,
  properties: {
    r'altitude': PropertySchema(
      id: 0,
      name: r'altitude',
      type: IsarType.double,
    ),
    r'lat': PropertySchema(id: 1, name: r'lat', type: IsarType.double),
    r'lng': PropertySchema(id: 2, name: r'lng', type: IsarType.double),
    r'type': PropertySchema(
      id: 3,
      name: r'type',
      type: IsarType.string,
      enumMap: _RunPointModeltypeEnumValueMap,
    ),
  },

  estimateSize: _runPointModelEstimateSize,
  serialize: _runPointModelSerialize,
  deserialize: _runPointModelDeserialize,
  deserializeProp: _runPointModelDeserializeProp,
);

int _runPointModelEstimateSize(
  RunPointModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _runPointModelSerialize(
  RunPointModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.altitude);
  writer.writeDouble(offsets[1], object.lat);
  writer.writeDouble(offsets[2], object.lng);
  writer.writeString(offsets[3], object.type.name);
}

RunPointModel _runPointModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RunPointModel(
    altitude: reader.readDoubleOrNull(offsets[0]),
    lat: reader.readDoubleOrNull(offsets[1]),
    lng: reader.readDoubleOrNull(offsets[2]),
    type:
        _RunPointModeltypeValueEnumMap[reader.readStringOrNull(offsets[3])] ??
        PointType.active,
  );
  return object;
}

P _runPointModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (_RunPointModeltypeValueEnumMap[reader.readStringOrNull(offset)] ??
              PointType.active)
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _RunPointModeltypeEnumValueMap = {
  r'start': r'start',
  r'pause': r'pause',
  r'resume': r'resume',
  r'active': r'active',
  r'end': r'end',
};
const _RunPointModeltypeValueEnumMap = {
  r'start': PointType.start,
  r'pause': PointType.pause,
  r'resume': PointType.resume,
  r'active': PointType.active,
  r'end': PointType.end,
};

extension RunPointModelQueryFilter
    on QueryBuilder<RunPointModel, RunPointModel, QFilterCondition> {
  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'altitude'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'altitude'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'altitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'altitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'altitude',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  altitudeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'altitude',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  latIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  latIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lat'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> latEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  latGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> latLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lat',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> latBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lat',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  lngIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lng'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  lngIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lng'),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> lngEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  lngGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> lngLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lng',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> lngBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lng',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> typeEqualTo(
    PointType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeGreaterThan(
    PointType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeLessThan(
    PointType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> typeBetween(
    PointType lower,
    PointType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition> typeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<RunPointModel, RunPointModel, QAfterFilterCondition>
  typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }
}

extension RunPointModelQueryObject
    on QueryBuilder<RunPointModel, RunPointModel, QFilterCondition> {}
