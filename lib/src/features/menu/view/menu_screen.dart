import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/data/local_categories.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:siberian_coffee/src/features/menu/data/local_products.dart';

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
      body: CustomScrollView(
        slivers: <Widget>[
              const SliverAppBar(
                pinned: true,
                expandedHeight: 36,
                backgroundColor: Colors.black45,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("App Bar"),
                ),
              ),
            ] +
            categoriesList // Добавляем к первому списку динамический список сливеров
                .map(
                  (category) {
                    List<Product> categoryProductList =
                        productList // Фильтруем лист по виду продукта
                            .where((product) =>
                                product.productCategory ==
                                category.productCategory)
                            .toList();
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            category.categoryName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 250.0,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            print("$index ${category.categoryName}");
                            return ProductCard(
                                product: categoryProductList[index]);
                          },
                          childCount: categoryProductList.length,
                        ),
                      ),
                    ];
                  },
                )
                .expand((element) => element)
                .toList(),
      ),
    );
  }
}
