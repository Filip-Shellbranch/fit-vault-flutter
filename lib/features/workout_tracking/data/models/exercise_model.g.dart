// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseModelCollection on Isar {
  IsarCollection<ExerciseModel> get exerciseModels => this.collection();
}

const ExerciseModelSchema = CollectionSchema(
  name: r'Exercise',
  id: 2972066467915231902,
  properties: {
    r'sets': PropertySchema(
      id: 0,
      name: r'sets',
      type: IsarType.objectList,

      target: r'ExerciseSetModel',
    ),
  },

  estimateSize: _exerciseModelEstimateSize,
  serialize: _exerciseModelSerialize,
  deserialize: _exerciseModelDeserialize,
  deserializeProp: _exerciseModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'exerciseType': LinkSchema(
      id: 7586781420917896036,
      name: r'exerciseType',
      target: r'ExerciseType',
      single: true,
    ),
    r'workout': LinkSchema(
      id: 838888609456381733,
      name: r'workout',
      target: r'Workout',
      single: true,
      linkName: r'exercises',
    ),
  },
  embeddedSchemas: {r'ExerciseSetModel': ExerciseSetModelSchema},

  getId: _exerciseModelGetId,
  getLinks: _exerciseModelGetLinks,
  attach: _exerciseModelAttach,
  version: '3.3.0',
);

int _exerciseModelEstimateSize(
  ExerciseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sets.length * 3;
  {
    final offsets = allOffsets[ExerciseSetModel]!;
    for (var i = 0; i < object.sets.length; i++) {
      final value = object.sets[i];
      bytesCount += ExerciseSetModelSchema.estimateSize(
        value,
        offsets,
        allOffsets,
      );
    }
  }
  return bytesCount;
}

void _exerciseModelSerialize(
  ExerciseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<ExerciseSetModel>(
    offsets[0],
    allOffsets,
    ExerciseSetModelSchema.serialize,
    object.sets,
  );
}

ExerciseModel _exerciseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseModel();
  object.id = id;
  object.sets =
      reader.readObjectList<ExerciseSetModel>(
        offsets[0],
        ExerciseSetModelSchema.deserialize,
        allOffsets,
        ExerciseSetModel(),
      ) ??
      [];
  return object;
}

P _exerciseModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<ExerciseSetModel>(
                offset,
                ExerciseSetModelSchema.deserialize,
                allOffsets,
                ExerciseSetModel(),
              ) ??
              [])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exerciseModelGetId(ExerciseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _exerciseModelGetLinks(ExerciseModel object) {
  return [object.exerciseType, object.workout];
}

void _exerciseModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ExerciseModel object,
) {
  object.id = id;
  object.exerciseType.attach(
    col,
    col.isar.collection<ExerciseTypeModel>(),
    r'exerciseType',
    id,
  );
  object.workout.attach(
    col,
    col.isar.collection<WorkoutModel>(),
    r'workout',
    id,
  );
}

extension ExerciseModelQueryWhereSort
    on QueryBuilder<ExerciseModel, ExerciseModel, QWhere> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExerciseModelQueryWhere
    on QueryBuilder<ExerciseModel, ExerciseModel, QWhereClause> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterWhereClause> idBetween(
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

extension ExerciseModelQueryFilter
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', length, true, length, true);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, true, 0, true);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, false, 999999, true);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', 0, true, length, include);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'sets', length, include, 999999, true);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  setsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sets',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ExerciseModelQueryObject
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> setsElement(
    FilterQuery<ExerciseSetModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sets');
    });
  }
}

extension ExerciseModelQueryLinks
    on QueryBuilder<ExerciseModel, ExerciseModel, QFilterCondition> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  exerciseType(FilterQuery<ExerciseTypeModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'exerciseType');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  exerciseTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'exerciseType', 0, true, 0, true);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition> workout(
    FilterQuery<WorkoutModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'workout');
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterFilterCondition>
  workoutIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'workout', 0, true, 0, true);
    });
  }
}

extension ExerciseModelQuerySortBy
    on QueryBuilder<ExerciseModel, ExerciseModel, QSortBy> {}

extension ExerciseModelQuerySortThenBy
    on QueryBuilder<ExerciseModel, ExerciseModel, QSortThenBy> {
  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseModel, ExerciseModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ExerciseModelQueryWhereDistinct
    on QueryBuilder<ExerciseModel, ExerciseModel, QDistinct> {}

extension ExerciseModelQueryProperty
    on QueryBuilder<ExerciseModel, ExerciseModel, QQueryProperty> {
  QueryBuilder<ExerciseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExerciseModel, List<ExerciseSetModel>, QQueryOperations>
  setsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sets');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ExerciseSetModelSchema = Schema(
  name: r'ExerciseSetModel',
  id: 2220170523711916600,
  properties: {
    r'reps': PropertySchema(id: 0, name: r'reps', type: IsarType.long),
    r'weight': PropertySchema(id: 1, name: r'weight', type: IsarType.double),
  },

  estimateSize: _exerciseSetModelEstimateSize,
  serialize: _exerciseSetModelSerialize,
  deserialize: _exerciseSetModelDeserialize,
  deserializeProp: _exerciseSetModelDeserializeProp,
);

int _exerciseSetModelEstimateSize(
  ExerciseSetModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _exerciseSetModelSerialize(
  ExerciseSetModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.reps);
  writer.writeDouble(offsets[1], object.weight);
}

ExerciseSetModel _exerciseSetModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseSetModel(
    reps: reader.readLongOrNull(offsets[0]),
    weight: reader.readDoubleOrNull(offsets[1]),
  );
  return object;
}

P _exerciseSetModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ExerciseSetModelQueryFilter
    on QueryBuilder<ExerciseSetModel, ExerciseSetModel, QFilterCondition> {
  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'reps'),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reps', value: value),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'reps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'reps',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  repsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'reps',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'weight'),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'weight',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<ExerciseSetModel, ExerciseSetModel, QAfterFilterCondition>
  weightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'weight',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }
}

extension ExerciseSetModelQueryObject
    on QueryBuilder<ExerciseSetModel, ExerciseSetModel, QFilterCondition> {}
