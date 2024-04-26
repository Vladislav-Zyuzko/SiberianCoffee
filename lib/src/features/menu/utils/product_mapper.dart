import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';

extension ProductMapper on ProductDto {
  Product toModel() {
    return Product(
      productId: id.toString(),
      categoryId: category.id,
      imagePath: imageUrl,
      productName: name,
      productCost: double.parse(prices[0].value),
    );
  }
}
