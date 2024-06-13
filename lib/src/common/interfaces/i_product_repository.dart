import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';

abstract class IProductRepository {
  Future<List<Product>> loadProducts(List<Category> categories);
}
