import 'package:siberian_coffee/src/features/menu/data/enums/product_categories.dart';
import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Category extends Classifiable {
  final String categoryName;

  Category({
    required ProductCategory productCategory,
    required this.categoryName,
  }) : super(productCategory: productCategory);
}
