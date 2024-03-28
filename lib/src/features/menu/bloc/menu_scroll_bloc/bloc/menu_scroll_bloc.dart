import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/bloc/categories_bloc/categories_bloc.dart';

part 'menu_scroll_event.dart';
part 'menu_scroll_state.dart';

class MenuScrollBloc extends Bloc<MenuScrollEvent, MenuScrollState> {
  final CategoriesBloc categoriesBloc;

  MenuScrollBloc(this.categoriesBloc) : super(MenuScrollInitialState()) {
    on<MenuScrollAddContentListenerEvent>(_addContentListener);
    on<MenuScrollAppBarToBeginingEvent>(_scrollAppBarToBegining);
    on<MenuScrollShowActiveCategoryEvent>(_showActiveCategory);
  }

  void _addContentListener(
      MenuScrollAddContentListenerEvent event, Emitter emit) {
    state.contentScrollController.addListener(
      () {
        CategoriesLoadedState categoriesLoadedState =
            categoriesBloc.state as CategoriesLoadedState;
        List<double> categoriesOrdinatesList = List.generate(
            categoriesLoadedState.orderCategories.length,
            (index) => getOrdinateCategory(index, categoriesBloc.state));
        int nearCategoryIndex = categoriesOrdinatesList.indexOf(
          categoriesOrdinatesList
              .reduce((curr, next) => curr < next ? curr : next),
        );
        if (nearCategoryIndex != categoriesLoadedState.orderCategories[0]) {
          categoriesBloc.add(CategoriesSetActiveCategoryEvent(
              activeIndex: categoriesLoadedState.orderCategories
                  .indexOf(nearCategoryIndex)));
        }
      },
    );
  }

  void _scrollAppBarToBegining(
      MenuScrollAppBarToBeginingEvent event, Emitter emit) {
    state.appBarScrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  double getOrdinateCategory(index, state) {
    RenderBox renderBox = state
        .categoriesKeys[state.orderCategories[index]].currentContext!
        .findAncestorRenderObjectOfType() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    return offset.dy.abs();
  }

  void _showActiveCategory(
      MenuScrollShowActiveCategoryEvent event, Emitter emit) {
    final targetContext = event.categoryKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
