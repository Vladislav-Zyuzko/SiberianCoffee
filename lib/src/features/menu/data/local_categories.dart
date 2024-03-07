import 'package:siberian_coffee/src/features/menu/data/enums/product_categories.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';

List<Category> categoriesList = [
  Category(
    productCategory: ProductCategory.blackCoffee,
    categoryName: "Черный кофе",
  ),
  Category(
    productCategory: ProductCategory.cofeeWithMilk,
    categoryName: "Кофе с молоком",
  ),
  Category(
    productCategory: ProductCategory.teaDrink,
    categoryName: "Чай",
  ),
  Category(
    productCategory: ProductCategory.authorDrink,
    categoryName: "Авторские напитки",
  ),
];
