import 'package:siberian_coffee/src/features/menu/interfaces/classifiable.dart';

class Category extends Classifiable {
  final String categoryName;

  Category({
    required int categoryId,
    required this.categoryName,
  }) : super(categoryId: categoryId);

}
