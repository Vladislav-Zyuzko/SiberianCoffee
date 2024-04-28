// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_database.dart';

// ignore_for_file: type=lint
class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryDtoMeta =
      const VerificationMeta('categoryDto');
  @override
  late final GeneratedColumnWithTypeConverter<CategoryDto, String> categoryDto =
      GeneratedColumn<String>('productDto', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CategoryDto>(
              $CategoryTableTable.$convertercategoryDto);
  @override
  List<GeneratedColumn> get $columns => [categoryDto];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    context.handle(_categoryDtoMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      categoryDto: $CategoryTableTable.$convertercategoryDto.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}productDto'])!),
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategoryDto, String, String> $convertercategoryDto =
      CategoryDto.converter;
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final CategoryDto categoryDto;
  const CategoryTableData({required this.categoryDto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['productDto'] = Variable<String>(
          $CategoryTableTable.$convertercategoryDto.toSql(categoryDto));
    }
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      categoryDto: Value(categoryDto),
    );
  }

  factory CategoryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      categoryDto: $CategoryTableTable.$convertercategoryDto
          .fromJson(serializer.fromJson<String>(json['categoryDto'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryDto': serializer.toJson<String>(
          $CategoryTableTable.$convertercategoryDto.toJson(categoryDto)),
    };
  }

  CategoryTableData copyWith({CategoryDto? categoryDto}) => CategoryTableData(
        categoryDto: categoryDto ?? this.categoryDto,
      );
  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('categoryDto: $categoryDto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => categoryDto.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData && other.categoryDto == this.categoryDto);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<CategoryDto> categoryDto;
  final Value<int> rowid;
  const CategoryTableCompanion({
    this.categoryDto = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    required CategoryDto categoryDto,
    this.rowid = const Value.absent(),
  }) : categoryDto = Value(categoryDto);
  static Insertable<CategoryTableData> custom({
    Expression<String>? categoryDto,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryDto != null) 'productDto': categoryDto,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<CategoryDto>? categoryDto, Value<int>? rowid}) {
    return CategoryTableCompanion(
      categoryDto: categoryDto ?? this.categoryDto,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryDto.present) {
      map['productDto'] = Variable<String>(
          $CategoryTableTable.$convertercategoryDto.toSql(categoryDto.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('categoryDto: $categoryDto, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SiberianCoffeeDatabase extends GeneratedDatabase {
  _$SiberianCoffeeDatabase(QueryExecutor e) : super(e);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categoryTable];
}
