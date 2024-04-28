import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';

class CategoryTable extends Table {
  TextColumn get categoryDto => text().map(CategoryDto.converter).named('productDto')();
}
