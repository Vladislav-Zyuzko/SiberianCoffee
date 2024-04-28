import 'package:drift/drift.dart';

class ProductTable extends Table {
  IntColumn get id => integer().named('id')();

  TextColumn get name => text().named('name')();
  TextColumn get description => text().named('description')();

  @override
  Set<Column> get primaryKey => {id};
}
