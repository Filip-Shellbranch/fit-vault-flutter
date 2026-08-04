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
    r'startTime': PropertySchema(
      id: 3,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'state': PropertySchema(
      id: 4,
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
  links: {
    r'points': LinkSchema(
      id: -6420975297085469834,
      name: r'points',
      target: r'RunPoint',
      single: false,
    ),
  },
  embeddedSchemas: {},

  getId: _runModelGetId,
  getLinks: _runModelGetLinks,
  attach: _runModelAttach,
  version: '3.3.2',
);

int _runModelEstimateSize(
  RunModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
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
  writer.writeDateTime(offsets[3], object.startTime);
  writer.writeString(offsets[4], object.state.name);
}

RunModel _runModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RunModel(
    reader.readDateTime(offsets[3]),
    distance: reader.readDoubleOrNull(offsets[0]) ?? 0.0,
    endTime: reader.readDateTimeOrNull(offsets[1]),
    state:
        _RunModelstateValueEnumMap[reader.readStringOrNull(offsets[4])] ??
        RunState.completed,
  );
  object.id = id;
  object.pausedDurationMillis = reader.readLong(offsets[2]);
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
      return (reader.readDateTime(offset)) as P;
    case 4:
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
  return [object.points];
}

void _runModelAttach(IsarCollection<dynamic> col, Id id, RunModel object) {
  object.id = id;
  object.points.attach(
    col,
    col.isar.collection<RunPointModel>(),
    r'points',
    id,
  );
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
    on QueryBuilder<RunModel, RunModel, QFilterCondition> {}

extension RunModelQueryLinks
    on QueryBuilder<RunModel, RunModel, QFilterCondition> {
  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> points(
    FilterQuery<RunPointModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'points');
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthEqualTo(
    int length,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'points', length, true, length, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'points', 0, true, 0, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'points', 0, false, 999999, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'points', 0, true, length, include);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition>
  pointsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'points', length, include, 999999, true);
    });
  }

  QueryBuilder<RunModel, RunModel, QAfterFilterCondition> pointsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'points',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

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
