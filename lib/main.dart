import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siberian_coffee/src/app.dart';
import 'package:siberian_coffee/src/common/data_source/category_repository.dart';
import 'package:siberian_coffee/src/common/data_source/order_repository.dart';
import 'package:siberian_coffee/src/common/data_source/product_repository.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';

void main() {
  runZonedGuarded(() async {
    await dotenv.load(fileName: ".env");
    await ApiClient.initialize();
    runApp(SiberianCoffeeApp(
      repositories: {
        "category": CategoryRepository(),
        "order": OrderRepository(),
        "product": ProductRepository(),
      },
    ));
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
