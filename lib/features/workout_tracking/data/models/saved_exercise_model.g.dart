// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_exercise_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedExerciseModelCollection on Isar {
  IsarCollection<SavedExerciseModel> get savedExerciseModels =>
      this.collection();
}

const SavedExerciseModelSchema = CollectionSchema(
  name: r'SavedExercise',
  id: -945901310980603662,
  properties: {
    r'isBodyWeight': PropertySchema(
      id: 0,
      name: r'isBodyWeight',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(id: 1, name: r'name', type: IsarType.string),
  },

  estimateSize: _savedExerciseModelEstimateSize,
  serialize: _savedExerciseModelSerialize,
  deserialize: _savedExerciseModelDeserialize,
  deserializeProp: _savedExerciseModelDeserializeProp,
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

  getId: _savedExerciseModelGetId,
  getLinks: _savedExerciseModelGetLinks,
  attach: _savedExerciseModelAttach,
  version: '3.3.0',
);

int _savedExerciseModelEstimateSize(
  SavedExerciseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _savedExerciseModelSerialize(
  SavedExerciseModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isBodyWeight);
  writer.writeString(offsets[1], object.name);
}

SavedExerciseModel _savedExerciseModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedExerciseModel(
    reader.readString(offsets[1]),
    reader.readBool(offsets[0]),
  );
  object.id = id;
  return object;
}

P _savedExerciseModelDeserializeProp<P>(
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

Id _savedExerciseModelGetId(SavedExerciseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedExerciseModelGetLinks(
  SavedExerciseModel object,
) {
  return [];
}

void _savedExerciseModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  SavedExerciseModel object,
) {
  object.id = id;
}

extension SavedExerciseModelByIndex on IsarCollection<SavedExerciseModel> {
  Future<SavedExerciseModel?> getByName(String name) {
    return getByIndex(r'name', [name]);
  }

  SavedExerciseModel? getByNameSync(String name) {
    return getByIndexSync(r'name', [name]);
  }

  Future<bool> deleteByName(String name) {
    return deleteByIndex(r'name', [name]);
  }

  bool deleteByNameSync(String name) {
    return deleteByIndexSync(r'name', [name]);
  }

  Future<List<SavedExerciseModel?>> getAllByName(List<String> nameValues) {
    final values = nameValues.map((e) => [e]).toList();
    return getAllByIndex(r'name', values);
  }

  List<SavedExerciseModel?> getAllByNameSync(List<String> nameValues) {
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

  Future<Id> putByName(SavedExerciseModel object) {
    return putByIndex(r'name', object);
  }

  Id putByNameSync(SavedExerciseModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'name', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByName(List<SavedExerciseModel> objects) {
    return putAllByIndex(r'name', objects);
  }

  List<Id> putAllByNameSync(
    List<SavedExerciseModel> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'name', objects, saveLinks: saveLinks);
  }
}

extension SavedExerciseModelQueryWhereSort
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QWhere> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SavedExerciseModelQueryWhere
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QWhereClause> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
  nameEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'name', value: [name]),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterWhereClause>
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

extension SavedExerciseModelQueryFilter
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QFilterCondition> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
  isBodyWeightEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isBodyWeight', value: value),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
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

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }
}

extension SavedExerciseModelQueryObject
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QFilterCondition> {}

extension SavedExerciseModelQueryLinks
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QFilterCondition> {}

extension SavedExerciseModelQuerySortBy
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QSortBy> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  sortByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  sortByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SavedExerciseModelQuerySortThenBy
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QSortThenBy> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.asc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenByIsBodyWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isBodyWeight', Sort.desc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QAfterSortBy>
  thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension SavedExerciseModelQueryWhereDistinct
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QDistinct> {
  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QDistinct>
  distinctByIsBodyWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isBodyWeight');
    });
  }

  QueryBuilder<SavedExerciseModel, SavedExerciseModel, QDistinct>
  distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension SavedExerciseModelQueryProperty
    on QueryBuilder<SavedExerciseModel, SavedExerciseModel, QQueryProperty> {
  QueryBuilder<SavedExerciseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedExerciseModel, bool, QQueryOperations>
  isBodyWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isBodyWeight');
    });
  }

  QueryBuilder<SavedExerciseModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
