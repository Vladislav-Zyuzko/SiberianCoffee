import 'package:drift/drift.dart';

class PriceTable extends Table {
  IntColumn get id => integer().autoIncrement().named('id')();
  TextColumn get value => text().named('value')();
  TextColumn get currency => text().named('currency')();
}
