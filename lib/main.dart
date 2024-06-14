import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siberian_coffee/src/app.dart';
import 'package:siberian_coffee/src/common/network/notifications/firebase_api.dart';
import 'package:siberian_coffee/src/common/network/rest_client.dart';
import 'package:siberian_coffee/src/store/api/sc_database_api.dart';
import 'package:siberian_coffee/src/store/api/sc_preferencies_api.dart';
import 'package:siberian_coffee/src/store/sc_database.dart';
import 'package:siberian_coffee/src/features/menu/data/address_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/category_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/order_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_addresses_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/savable/savable_user_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/order_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/product_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/user_repository.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

void main() {
  RestClient restClient = RestClient();
  runZonedGuarded(() async {
    AndroidYandexMap.useAndroidViewSurface = false;
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    await restClient.init();
    await Firebase.initializeApp();

    SiberianCoffeeDatabase scDatabase = SiberianCoffeeDatabase();
    ScDatabaseApi scDatabaseApi = ScDatabaseApi(scDatabase: scDatabase);
    ScSharedPreferencesApi scSharedPreferencesApi = ScSharedPreferencesApi();
    FirebaseApi firebaseApi = FirebaseApi(scSharedPreferenciesApi: scSharedPreferencesApi);

    firebaseApi.initNotifications();

    runApp(SiberianCoffeeApp(
      repositories: {
        "address": AddressRepository(
          networkAddressesDataSource: NetworkAddressesDataSource(
            dio: restClient.dio,
          ),
          dbAddressesDataSource: DbAddressesDataSource(
            scDatabaseApi: scDatabaseApi,
          )
        ),
        "category": CategoryRepository(
          networkCategoriesDataSource: NetworkCategoriesDataSource(
            dio: restClient.dio,
          ),
          dbCategoriesDataSource: DbCategoriesDataSource(
            scDatabaseApi: scDatabaseApi,
          ),
        ),
        "order": OrderRepository(
          networkOrderDataSource: NetworkOrderDataSource(
            dio: restClient.dio,
          ),
        ),
        "product": ProductRepository(
          networkProductDataSource: NetworkProductDataSource(
            dio: restClient.dio,
          ),
          dbProductDataSource: DbProductsDataSource(
            scDatabaseApi: scDatabaseApi,
          ),
        ),
        "user": UserRepository(
          preferencesUserDataSource: PreferencesUserDataSource(
           scSharedPreferenciesApi: scSharedPreferencesApi,
          ),
        )
      },
      apis: {
        "preferencies": ScSharedPreferencesApi(),
      },
    ));
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
