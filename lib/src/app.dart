import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/menu_screen.dart';

class SiberianCoffeeApp extends StatelessWidget {
  const SiberianCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SiberianCoffee',
      home: MenuScreen(),
    );
  }
}
