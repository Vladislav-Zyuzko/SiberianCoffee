
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';

extension CategoryMapper on CategoryDto {
  Category toModel() {
    return Category(categoryId: id, categoryName: slug);
  }
}
