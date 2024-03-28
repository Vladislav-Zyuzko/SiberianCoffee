import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:siberian_coffee/src/app.dart';
import 'package:siberian_coffee/src/common/network/api_client.dart';

void main() {
  runZonedGuarded(() async {
    await dotenv.load(fileName: ".env");
    await ApiClient.initialize();
    runApp(const SiberianCoffeeApp());
  }, (error, stack) {
    log(error.toString(), name: 'App Error', stackTrace: stack);
  });
}
