import 'package:siberian_coffee/src/common/network/exceptions/persistance_exception.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';
import 'package:siberian_coffee/src/features/menu/utils/category_mapper.dart';

abstract class ICategoryRepository {
  Future<List<Category>> loadCategories();
}

class CategoryRepository implements ICategoryRepository {
  final ICategoriesDataSource _networkCategoriesDataSource;

  CategoryRepository({
    required ICategoriesDataSource networkCategoriesDataSource,
  }) : _networkCategoriesDataSource = networkCategoriesDataSource;

  @override
  Future<List<Category>> loadCategories() async {
    var dtos = <CategoryDto>[];
    try {
      dtos = await _networkCategoriesDataSource.loadCategories();
    } catch (e) {
      throw PersistanceException("There is problem in loading categories: $e");
    }
    return dtos.map((e) => e.toModel()).toList();
  }
}
