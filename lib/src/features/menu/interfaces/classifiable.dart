import 'package:siberian_coffee/src/features/menu/data/enums/product_categories.dart';

abstract class Classifiable {
  ProductCategory productCategory;

  Classifiable({required this.productCategory});
}
