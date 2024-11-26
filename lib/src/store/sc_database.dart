import 'package:drift/drift.dart';

import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:siberian_coffee/src/store/tables/address_table.dart';
import 'package:siberian_coffee/src/store/tables/category_table.dart';
import 'package:siberian_coffee/src/store/tables/product_table.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/price/price_dto.dart';
import 'package:siberian_coffee/src/features/menu/utils/price_dtos_converter.dart';

import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'sc_database.g.dart';

@DriftDatabase(tables: [AddressTable, CategoryTable, ProductTable])
class SiberianCoffeeDatabase extends _$SiberianCoffeeDatabase {
  SiberianCoffeeDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
