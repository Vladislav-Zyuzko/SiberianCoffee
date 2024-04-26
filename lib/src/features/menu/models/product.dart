import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Product extends Classifiable {
  final String productId;
  final String imagePath;
  final String productName;
  final double productCost;

  Product({
    required super.categoryId,
    required this.productId,
    required this.imagePath,
    required this.productName,
    required this.productCost,
  });
}
