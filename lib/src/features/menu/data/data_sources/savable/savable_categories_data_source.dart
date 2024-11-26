import 'package:siberian_coffee/src/store/api/sc_database_api.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';

abstract interface class ISavableCategoriesDataSource
    implements ICategoriesDataSource {
  Future<void> saveCategories({required List<CategoryDto> categories});
}

class DbCategoriesDataSource implements ISavableCategoriesDataSource {
  final IScDatabaseApi _scDatabaseApi;

  const DbCategoriesDataSource({required IScDatabaseApi scDatabaseApi})
      : _scDatabaseApi = scDatabaseApi;

  @override
  Future<List<CategoryDto>> loadCategories() {
    return _scDatabaseApi.loadCategories();
  }

  @override
  Future<void> saveCategories({required List<CategoryDto> categories}) async {
    await _scDatabaseApi.saveCategories(categories: categories);
  }
}
