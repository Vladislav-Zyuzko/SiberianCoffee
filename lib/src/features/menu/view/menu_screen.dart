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
  int activeCategoryIndex = 0;
  List<GlobalKey> categoriesKeys =
      List.generate(categoriesList.length, (index) => GlobalKey());
  List<int> orderCategories =
      List.generate(categoriesList.length, (index) => index);

  ScrollController appBarScrollController = ScrollController();
  ScrollController contentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    contentScrollController.addListener(() {
      List<double> categoriesOrdinatesList = List.generate(
          categoriesList.length, (index) => getOrdinateCategory(index));
      int nearCategoryIndex = categoriesOrdinatesList.indexOf(
        categoriesOrdinatesList
            .reduce((curr, next) => curr < next ? curr : next),
      );
      if (nearCategoryIndex != orderCategories[0]) {
        setActiveCategory(orderCategories.indexOf(nearCategoryIndex));
      }
    });
  }

  double getOrdinateCategory(index) {
    RenderBox renderBox = categoriesKeys[orderCategories[index]]
        .currentContext!
        .findAncestorRenderObjectOfType() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return offset.dy.abs();
  }

  void scrollToBeginning(ScrollController scrollController) {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void setActiveCategory(int index) {
    setState(() {
      int newActiveCategory = orderCategories.removeAt(index);
      orderCategories.insert(0, newActiveCategory);
    });
  }

  void showActiveCategory(GlobalKey categoryKey) {
    final targetContext = categoryKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
          controller: contentScrollController,
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
                    controller: appBarScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder: ((context, index) {
                      return CategoryButton(
                        onTap: () {
                          setActiveCategory(index);
                          scrollToBeginning(appBarScrollController);
                          showActiveCategory(
                              categoriesKeys[index]);
                        },
                        categoryName:
                            categoriesList[orderCategories[index]].categoryName,
                        active: index == activeCategoryIndex,
                      );
                    }),
                  ),
                ),
              ),
            ),
            ...List.generate(categoriesList.length, (index) {
              List<Product> categoryProductList =
                  productList // Фильтруем лист по виду продукта
                      .where((product) =>
                          product.productCategory ==
                          categoriesList[index].productCategory)
                      .toList();
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Text(
                      categoriesList[index].categoryName,
                      key: categoriesKeys[orderCategories[index]],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ProductCard(product: categoryProductList[index]);
                    },
                    childCount: categoryProductList.length,
                  ),
                ),
              ];
            }).expand((element) => element),
          ]),
    );
  }
}
