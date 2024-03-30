import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Product extends Classifiable {
  final String imagePath;
  final String productName;
  final double productCost;

  Product({
    required int categoryId,
    required this.imagePath,
    required this.productName,
    required this.productCost,
  }) : super(categoryId: categoryId);

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      categoryId: map['category']['id'],
      imagePath: map['imageUrl'],
      productName: map['name'],
      productCost: double.parse(map['prices'][0]['value'])
    );
  }
}
