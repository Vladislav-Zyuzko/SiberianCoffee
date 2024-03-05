import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/theme/image_sources.dart';

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
        child: Image.asset(ImageSources.teaRed,
            height: 300, fit: BoxFit.contain),
      ),
    );
  }
}
