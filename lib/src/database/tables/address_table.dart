import 'package:drift/drift.dart';

class AddressTable extends Table {
  TextColumn get address => text().named('address')();
  RealColumn get lat => real().named('lat')();
  RealColumn get lng => real().named('lng')();
}
