import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siberian_coffee/src/features/menu/bloc/addresses_bloc/addresses_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/categories_bloc/categories_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/menu_scroll_bloc/bloc/menu_scroll_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/order_bloc/order_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/products_bloc/bloc/products_bloc.dart';
import 'package:siberian_coffee/src/features/menu/bloc/user_bloc/user_bloc.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/coffee_shop_address_panel.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/order_bottom_sheet.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/order_details_button.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/product_card.dart';
import 'package:siberian_coffee/src/features/menu/view/widgets/category_button.dart';
import 'package:siberian_coffee/src/theme/app_colors.dart';

class MenuScreen extends StatelessWidget {
  final Map repositories;
  const MenuScreen({super.key, required this.repositories});

  @override
  build(BuildContext context) {
    AddressesBloc addressesBloc = AddressesBloc(
      addressRepository: repositories["address"],
      userRepository: repositories["user"],
    )..add(AddressesLoadAddressesEvent());
    CategoriesBloc categoriesBloc = CategoriesBloc(
      categoryRepository: repositories["category"],
    )..add(CategoriesLoadCategoriesEvent());
    ProductsBloc productsBloc = ProductsBloc(
      categoriesBloc: categoriesBloc,
      productRepository: repositories["product"],
    );
    MenuScrollBloc menuScrollBloc = MenuScrollBloc(
      categoriesBloc,
    )..add(MenuScrollAddContentListenerEvent());
    OrderBloc orderBloc = OrderBloc(orderRepository: repositories["order"]);
    UserBloc userBloc = UserBloc(
      addressesBloc: addressesBloc,
      userRepository: repositories["user"],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressesBloc>(
          create: (context) => addressesBloc,
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => categoriesBloc,
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => productsBloc,
        ),
        BlocProvider<MenuScrollBloc>(
          create: (context) => menuScrollBloc,
        ),
        BlocProvider<OrderBloc>(
          create: (context) => orderBloc,
        ),
        BlocProvider<UserBloc>(
          create: (context) => userBloc,
        )
      ],
      child: Scaffold(
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return state is ProductsLoadedState
            ? Stack(
                children: [
                  CustomScrollView(
                    controller:
                        menuScrollBloc.state.contentScrollController,
                    slivers: <Widget>[
                      SliverAppBar(
                        surfaceTintColor: AppColors.primaryWhite,
                        pinned: true,
                        collapsedHeight: 106,
                        backgroundColor: AppColors.dimWhite,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 40),
                          child: Column(
                            children: [
                              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                                return state is UserLoadedState
                                ? CoffeeShopAddressPanel(
                                  coffeeShopAddress: state.user.userCoffeeShopAddress?.address ?? "",
                                )
                                : const Placeholder();
                              }),
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              SizedBox(
                                height: 36,
                                child: BlocBuilder<CategoriesBloc,
                                    CategoriesState>(
                                  builder: (context, state) {
                                    return state is CategoriesLoadedState
                                    ? ListView.separated(
                                        cacheExtent: double.infinity,
                                        separatorBuilder: ((_, __) {
                                          return const Padding(
                                            padding: EdgeInsets.only(
                                                left: 10),
                                          );
                                        }),
                                        physics: state
                                                .categoriesIsAnimated
                                            ? const NeverScrollableScrollPhysics()
                                            : null,
                                        controller: categoriesBloc
                                            .appBarScrollController,
                                        scrollDirection:
                                            Axis.horizontal,
                                        itemCount:
                                            state.categoriesList.length,
                                        itemBuilder: ((context, index) {
                                          return CategoryButton(
                                            key: state
                                                    .categoryButtonsKeys[
                                                state.orderCategories[
                                                    index]],
                                            onTap: state
                                                    .categoriesIsAnimated
                                                ? () => {}
                                                : () {
                                                    menuScrollBloc.add(
                                                      MenuScrollShowActiveCategoryEvent(
                                                        categoryKey: state
                                                                .categoriesKeys[
                                                            state.orderCategories[
                                                                index]],
                                                      ),
                                                    );
                                                    categoriesBloc.add(
                                                      CategoriesSetActiveCategoryEvent(
                                                          activeIndex: index,
                                                      ),
                                                    );
                                                  },
                                            categoryName: state
                                                .categoriesList[state
                                                        .orderCategories[
                                                    index]]
                                                .categoryName,
                                            active: index ==
                                                state
                                                    .activeCategoryIndex,
                                          );
                                        }),
                                      )
                                    : const CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ],
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
                                            key:
                                                state.categoriesKeys[index],
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
                  ),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is OrderSendSuccessState ||
                          state is OrderSendErrorState) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              backgroundColor: AppColors.darkGrey7D,
                              content: Text(
                                state is OrderSendSuccessState
                                    ? AppLocalizations.of(context)!
                                        .orderCreated
                                    : AppLocalizations.of(context)!
                                        .orderWithError,
                                style:
                                    Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          );
                        });
                      }
                      bool orderActive = state is OrderActiveState;
                      return AnimatedPositioned(
                        top: MediaQuery.of(context).size.height * 0.9,
                        right: orderActive ? 20 : -99,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.bounceOut,
                        child: OrderDetailsButton(
                          onPressed: orderActive
                              ? () => {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: ((BuildContext context) {
                                        return OrderBottomSheet(
                                          orderBloc: orderBloc,
                                        );
                                      }),
                                    )
                                  }
                              : () => {},
                          orderAmount: orderActive ? state.amountOrder : 0,
                        ),
                      );
                    },
                  ),
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
