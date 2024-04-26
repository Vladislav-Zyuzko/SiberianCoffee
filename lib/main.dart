import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siberian_coffee/src/app.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';
import 'package:siberian_coffee/src/common/network/rest_client.dart';
import 'package:siberian_coffee/src/features/menu/data/category_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/categories_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/data/order_repository.dart';
import 'package:siberian_coffee/src/features/menu/data/product_repository.dart';

void main() {
  RestClient restClient = RestClient();
  runZonedGuarded(() async {
    await dotenv.load(fileName: ".env");
    await restClient.init();
    await ApiClient.initialize();

    runApp(SiberianCoffeeApp(
      repositories: {
        "category": CategoryRepository(
          networkCategoriesDataSource: NetworkCategoriesDataSource(
            dio: restClient.dio,
          ),
        ),
        "order": OrderRepository(),
        "product": ProductRepository(
          networkProductDataSource: NetworkProductDataSource(
            dio: restClient.dio,
          )
        ),
      },
    ));
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
