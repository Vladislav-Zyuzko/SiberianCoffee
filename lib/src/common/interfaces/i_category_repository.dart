import 'package:siberian_coffee/src/features/menu/models/category.dart';

abstract class ICategoryRepository {
  Future<List<Category>> loadCategories();
}
