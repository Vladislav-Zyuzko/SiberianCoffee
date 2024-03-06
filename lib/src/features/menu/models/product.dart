enum ProductCategory {
  authorDrink,
  blackCoffee,
  cofeeWithMilk,
  teaDrink,
}

class Product {
  final String imagePath;
  final String productName;
  final double productCost;
  final ProductCategory productCategory;

  const Product({
    required this.imagePath,
    required this.productName,
    required this.productCost,
    required this.productCategory,
  });
}
