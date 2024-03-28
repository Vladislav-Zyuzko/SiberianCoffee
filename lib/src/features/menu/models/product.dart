import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Product extends Classifiable{
  final String imagePath;
  final String productName;
  final double productCost;

  Product({
    required int categoryId,
    required this.imagePath,
    required this.productName,
    required this.productCost,
  }) : super(categoryId: categoryId);
}
