import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/categories_bloc/categories_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/menu_scroll_bloc/bloc/menu_scroll_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/products_bloc/bloc/products_bloc.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/category_button.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  build(BuildContext context) {
    CategoriesBloc categoriesBloc = CategoriesBloc()
      ..add(CategoriesLoadCategoriesEvent());
    ProductsBloc productsBloc = ProductsBloc(categoriesBloc);
    MenuScrollBloc menuScrollBloc = MenuScrollBloc(categoriesBloc)
      ..add(MenuScrollAddContentListenerEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (context) => categoriesBloc,
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => productsBloc,
        ),
        BlocProvider<MenuScrollBloc>(
          create: (context) => menuScrollBloc,
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
          return state is ProductsLoadedState
          ? CustomScrollView(
              controller: menuScrollBloc.state.contentScrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 20,
                  backgroundColor: AppColors.dimWhite,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 40),
                    child: SizedBox(
                      height: 36,
                      child: BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          return state is CategoriesLoadedState
                          ? ListView.separated(
                              separatorBuilder: ((_, __) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 10),
                                );
                              }),
                              controller: menuScrollBloc
                                  .state.appBarScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categoriesList.length,
                              itemBuilder: ((context, index) {
                                return CategoryButton(
                                  onTap: () {
                                    menuScrollBloc.add(
                                        MenuScrollAppBarToBeginingEvent());
                                    menuScrollBloc.add(
                                      MenuScrollShowActiveCategoryEvent(
                                        categoryKey:
                                            state.categoriesKeys[
                                                state.orderCategories[
                                                    index]],
                                      ),
                                    );
                                    categoriesBloc.add(
                                        CategoriesSetActiveCategoryEvent(
                                            activeIndex: index));
                                  },
                                  categoryName: state
                                      .categoriesList[state
                                          .orderCategories[index]]
                                      .categoryName,
                                  active: index ==
                                      state.activeCategoryIndex,
                                );
                              }),
                            )
                          : const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                ...List.generate(
                  state.categoriesList.length,
                  (index) {
                    List<Product> categoryProductList = state
                      .productList // Фильтруем лист по виду продукта
                      .where((product) =>
                          product.categoryId ==
                          state.categoriesList[index].categoryId)
                      .toList();
                    return [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: BlocBuilder<CategoriesBloc,
                              CategoriesState>(
                            builder: (context, state) {
                              return state is CategoriesLoadedState
                              ? Text(
                                  state.categoriesList[index]
                                      .categoryName,
                                  key: state.categoriesKeys[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge,
                                )
                              : const Placeholder();
                            },
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
                ).expand((element) => element).toList(),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
