import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/data/enums/product_categories.dart';
import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Category extends Classifiable {
  final String categoryName;
  final GlobalKey categoryKey;

  Category({
    required ProductCategory productCategory,
    required this.categoryName,
    required this.categoryKey,
  }) : super(productCategory: productCategory);
}
