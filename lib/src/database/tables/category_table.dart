import 'package:drift/drift.dart';

class CategoryTable extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get slug => text().named('slug')();

  @override
  Set<Column> get primaryKey => {id};
}
