import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/database/sc_database.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';

abstract interface class IScDatabaseApi {
  Future<void> saveCategories({required List<CategoryDto> categories});
  Future<List<CategoryDto>> loadCategories();
}

class ScDatabaseApi implements IScDatabaseApi {
  final SiberianCoffeeDatabase _scDatabase;

  const ScDatabaseApi({required SiberianCoffeeDatabase scDatabase})
      : _scDatabase = scDatabase;

  @override
  Future<void> saveCategories({required List<CategoryDto> categories}) async {
    _scDatabase.categoryTable.deleteAll();
    List<CategoryTableCompanion> rows = categories.map(
      (category) => CategoryTableCompanion.insert(categoryDto: category),
    ).toList();
    await _scDatabase.batch((batch) => batch.insertAll(_scDatabase.categoryTable, rows));
  }

  @override
  Future<List<CategoryDto>> loadCategories() async {
    List<CategoryTableData> rows =
        await _scDatabase.select(_scDatabase.categoryTable).get();
    return rows.map((categoryData) => categoryData.categoryDto).toList();
  }
}
