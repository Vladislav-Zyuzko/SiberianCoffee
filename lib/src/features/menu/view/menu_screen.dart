import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:siberian_coffee/src/features/menu/data/local_data.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProductCard(product: productList[18]),
      ),
    );
  }
}
