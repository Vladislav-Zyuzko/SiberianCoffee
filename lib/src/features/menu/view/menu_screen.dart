import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/data/local_categories.dart';
import 'package:siberian_coffee/src/features/menu/data/local_products.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/category_button.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<int> orderCategories =
      List.generate(categoriesList.length, (index) => index);
  int activeCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void setActiveCategory(int index) {
    setState(() {
      int newActiveCategory = orderCategories.removeAt(index);
      orderCategories.insert(0, newActiveCategory);
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 20,
                backgroundColor: AppColors.dimWhite,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 40),
                  child: SizedBox(
                    height: 36,
                    child: ListView.separated(
                      separatorBuilder: ((_, __) {
                        return const Padding(
                          padding: EdgeInsets.only(left: 10),
                        );
                      }),
                      scrollDirection: Axis.horizontal,
                      itemCount: orderCategories.length,
                      itemBuilder: ((context, index) {
                        return CategoryButton(
                          onTap: () => setActiveCategory(index),
                          categoryName: categoriesList[orderCategories[index]].categoryName,
                          active: index == activeCategoryIndex,
                        );
                      }),
                    ),
                  ),
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
                          maxCrossAxisExtent: 200.0,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
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
