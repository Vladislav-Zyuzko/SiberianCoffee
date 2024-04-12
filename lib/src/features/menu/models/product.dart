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

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        productId: map['id'].toString(),
        categoryId: map['category']['id'],
        imagePath: map['imageUrl'],
        productName: map['name'],
        productCost: double.parse(map['prices'][0]['value']));
  }
}
