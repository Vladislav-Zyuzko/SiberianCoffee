import 'package:siberian_coffee/src/features/menu/data/enums/product_categories.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/theme/image_sources.dart';

List<Product> productList = [
  Product(
    imagePath: ImageSources.authorCoffeeCaramel,
    productName: "Кофе с карамельным мороженым и солью",
    productCost: 249.00,
    productCategory: ProductCategory.authorDrink,
  ),
  Product(
    imagePath: ImageSources.authorOleato,
    productName: "Олеато",
    productCost: 199.00,
    productCategory: ProductCategory.authorDrink,
  ),
  Product(
    imagePath: ImageSources.authorSpanishCoffee,
    productName: "Кофе по-испански",
    productCost: 219.00,
    productCategory: ProductCategory.authorDrink,
  ),
  Product(
    imagePath: ImageSources.authorWhiskeyIce,
    productName: "Кофе с виски и льдом",
    productCost: 339.00,
    productCategory: ProductCategory.authorDrink,
  ),
  Product(
    imagePath: ImageSources.blackCoffeeAmericano,
    productName: "Американо",
    productCost: 149.00,
    productCategory: ProductCategory.blackCoffee,
  ),
  Product(
    imagePath: ImageSources.blackCoffeeConPanna,
    productName: "Кон панна",
    productCost: 169.00,
    productCategory: ProductCategory.blackCoffee,
  ),
  Product(
    imagePath: ImageSources.blackCoffeeEspresso,
    productName: "Эспрессо",
    productCost: 129.00,
    productCategory: ProductCategory.blackCoffee,
  ),
  Product(
    imagePath: ImageSources.blackCoffeeRistretto,
    productName: "Ристретто",
    productCost: 149.00,
    productCategory: ProductCategory.blackCoffee,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeCappuccino,
    productName: "Капучино",
    productCost: 169.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeFlatWhite,
    productName: "Флэт уайт",
    productCost: 179.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeGlace,
    productName: "Глясе",
    productCost: 199.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeLatte,
    productName: "Латте",
    productCost: 149.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeMacchiato,
    productName: "Макиато",
    productCost: 169.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.milkCoffeeMarocchino,
    productName: "Марочино",
    productCost: 179.00,
    productCategory: ProductCategory.cofeeWithMilk,
  ),
  Product(
    imagePath: ImageSources.teaBlack,
    productName: "Черный чай",
    productCost: 69.00,
    productCategory: ProductCategory.teaDrink,
  ),
  Product(
    imagePath: ImageSources.teaGreen,
    productName: "Зеленый чай",
    productCost: 69.00,
    productCategory: ProductCategory.teaDrink,
  ),
  Product(
    imagePath: ImageSources.teaMint,
    productName: "Чай с мятой",
    productCost: 79.00,
    productCategory: ProductCategory.teaDrink,
  ),
  Product(
    imagePath: ImageSources.teaRaspberry,
    productName: "Чай с малиной",
    productCost: 79.00,
    productCategory: ProductCategory.teaDrink,
  ),
  Product(
    imagePath: ImageSources.teaRed,
    productName: "Красный чай",
    productCost: 79.00,
    productCategory: ProductCategory.teaDrink,
  )
];
