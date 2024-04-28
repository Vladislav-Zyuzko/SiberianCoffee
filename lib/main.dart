import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siberian_coffee/src/app.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';
import 'package:siberian_coffee/src/common/network/rest_client.dart';
import 'package:siberian_coffee/src/database/api/sc_database_api.dart';
import 'package:siberian_coffee/src/database/sc_database.dart';
import 'package:siberian_coffee/src/features/menu/data/category_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_catogories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/order_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/product_repository.dart';

void main() {
  RestClient restClient = RestClient();
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await restClient.init();
    await ApiClient.initialize();

    SiberianCoffeeDatabase scDatabase = SiberianCoffeeDatabase();
    ScDatabaseApi scDatabaseApi = ScDatabaseApi(scDatabase: scDatabase);

    runApp(SiberianCoffeeApp(
      repositories: {
        "category": CategoryRepository(
            networkCategoriesDataSource: NetworkCategoriesDataSource(
              dio: restClient.dio,
            ),
            dbCategoriesDataSource: DbCategoriesDataSource(
              scDatabaseApi: scDatabaseApi,
            ),),
        "order": OrderRepository(
            networkOrderDataSource: NetworkOrderDataSource(
          dio: restClient.dio,
        )),
        "product": ProductRepository(
            networkProductDataSource: NetworkProductDataSource(
          dio: restClient.dio,
        )),
      },
    ));
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
