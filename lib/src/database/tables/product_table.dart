import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/database/tables/category_table.dart';
import 'package:siberian_coffee/src/features/menu/utils/price_dtos_converter.dart';

class ProductTable extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();
  IntColumn get category => integer().named('category').references(CategoryTable, #id)();
  TextColumn get imageUrl => text().named('imageUrl')();
  TextColumn get prices => text().map(pricesConverter).named('prices')();

  @override
  Set<Column> get primaryKey => {id};
}
