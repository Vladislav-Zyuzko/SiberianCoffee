import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Category extends Classifiable {
  final String categoryName;

  Category({
    required int categoryId,
    required this.categoryName,
  }) : super(categoryId: categoryId);

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(categoryId: map['id'], categoryName: map['slug']);
  }
}
