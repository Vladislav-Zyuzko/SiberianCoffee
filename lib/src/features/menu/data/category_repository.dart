import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';
import 'package:siberian_coffee/src/features/menu/utils/category_mapper.dart';

abstract class ICategoryRepository {
  Future<List<Category>> loadCategories();
}

class CategoryRepository implements ICategoryRepository {
  final ICategoriesDataSource _networkCategoriesDataSource;
  final ISavableCategoriesDataSource _dbCategoriesDataSource;

  CategoryRepository({
    required ICategoriesDataSource networkCategoriesDataSource,
    required ISavableCategoriesDataSource dbCategoriesDataSource,
  })  : _networkCategoriesDataSource = networkCategoriesDataSource,
        _dbCategoriesDataSource = dbCategoriesDataSource;

  @override
  Future<List<Category>> loadCategories() async {
    var dtos = <CategoryDto>[];
    try {
      dtos = await _networkCategoriesDataSource.loadCategories();
      await _dbCategoriesDataSource.saveCategories(categories: dtos);
    } catch(_) {
      dtos = await _dbCategoriesDataSource.loadCategories();
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
