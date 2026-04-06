// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_type_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExerciseTypeModelCollection on Isar {
  IsarCollection<ExerciseTypeModel> get exerciseTypeModels => this.collection();
}

const ExerciseTypeModelSchema = CollectionSchema(
  name: r'ExerciseType',
  id: -4918275660044535898,
  properties: {
    r'isBodyWeight': PropertySchema(
      id: 0,
      name: r'isBodyWeight',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
  },

  estimateSize: _exerciseTypeModelEstimateSize,
  serialize: _exerciseTypeModelSerialize,
  deserialize: _exerciseTypeModelDeserialize,
  deserializeProp: _exerciseTypeModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _exerciseTypeModelGetId,
  getLinks: _exerciseTypeModelGetLinks,
  attach: _exerciseTypeModelAttach,
  version: '3.3.0',
);

int _exerciseTypeModelEstimateSize(
  ExerciseTypeModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _exerciseTypeModelSerialize(
  ExerciseTypeModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isBodyWeight);
  writer.writeString(offsets[1], object.name);
}

ExerciseTypeModel _exerciseTypeModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExerciseTypeModel(
    reader.readString(offsets[1]),
    reader.readBool(offsets[0]),
  );
  object.id = id;
  return object;
}

P _exerciseTypeModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _exerciseTypeModelGetId(ExerciseTypeModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _exerciseTypeModelGetLinks(
  ExerciseTypeModel object,
) {
  return [];
}

void _exerciseTypeModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ExerciseTypeModel object,
) {
  object.id = id;
}

extension ExerciseTypeModelByIndex on IsarCollection<ExerciseTypeModel> {
  Future<ExerciseTypeModel?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  ExerciseTypeModel? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<ExerciseTypeModel?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<ExerciseTypeModel?> getAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'name', values);
  }

  Future<int> deleteAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'name', values);
  }

  int deleteAllByNameSync(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'name', values);
  }

  Future<Id> putByName(ExerciseTypeModel object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(ExerciseTypeModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<ExerciseTypeModel> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(
    List<ExerciseTypeModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension ExerciseTypeModelQueryWhereSort
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QWhere> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ExerciseTypeModelQueryWhere
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QWhereClause> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
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

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  idBetween(
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

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterWhereClause>
  nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [name],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'name',
                lower: [],
                upper: [name],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ExerciseTypeModelQueryFilter
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QFilterCondition> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
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

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  idBetween(
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

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  isBodyWeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isBodyWeight', value: value),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }
}

extension ExerciseTypeModelQueryObject
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QFilterCondition> {}

extension ExerciseTypeModelQueryLinks
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QFilterCondition> {}

extension ExerciseTypeModelQuerySortBy
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QSortBy> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  sortByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  sortByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ExerciseTypeModelQuerySortThenBy
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QSortThenBy> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  thenByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  thenByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ExerciseTypeModelQueryWhereDistinct
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QDistinct> {
  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QDistinct>
  distinctByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBodyWeight');
    });
  }

  QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ExerciseTypeModelQueryProperty
    on QueryBuilder<ExerciseTypeModel, ExerciseTypeModel, QQueryProperty> {
  QueryBuilder<ExerciseTypeModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExerciseTypeModel, bool, QQueryOperations>
  isBodyWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBodyWeight');
    });
  }

  QueryBuilder<ExerciseTypeModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
