import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/common/data_source/category_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/utils/index_wrapper.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final ScrollController appBarScrollController = ScrollController();
  CategoriesBloc() : super(CategoriesLoadingState()) {
    on<CategoriesSetActiveCategoryEvent>(_setActiveCategory);
    on<CategoriesLoadCategoriesEvent>(_loadCategories);
  }

  void _setActiveCategory(CategoriesSetActiveCategoryEvent event,
      Emitter<CategoriesState> emit) async {
    if (state is CategoriesLoadedState) {
      CategoriesLoadedState categoriesLoadedState =
          state as CategoriesLoadedState;
      if (!categoriesLoadedState.categoriesIsAnimated) {
        IndexWrapper indexWrapper =
            IndexWrapper(activeIndex: event.activeIndex);
        List<int> sortedOrderCategories =
            _moveUnrenderedCateogriesToEnd(categoriesLoadedState, indexWrapper);
        emit(
          categoriesLoadedState.copyWith(
            orderCategories: sortedOrderCategories,
            activeCategoryIndex: indexWrapper.activeIndex,
            categoriesIsAnimated: true,
          ),
        );
        categoriesLoadedState = state as CategoriesLoadedState;
        appBarScrollController.animateTo(
          _getAbscissCategory(categoriesLoadedState.categoryButtonsKeys[
                  sortedOrderCategories[indexWrapper.activeIndex]]) +
              appBarScrollController.position.extentBefore -
              10,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        await Future.delayed(const Duration(milliseconds: 1500));
        sortedOrderCategories =
            _moveUnrenderedCateogriesToEnd(categoriesLoadedState, indexWrapper);
        emit(
          categoriesLoadedState.copyWith(
            orderCategories: sortedOrderCategories,
            activeCategoryIndex: indexWrapper.activeIndex,
            categoriesIsAnimated: false,
          ),
        );
      }
    }
  }

  List<int> _moveUnrenderedCateogriesToEnd(
      CategoriesLoadedState categoriesLoadedState, IndexWrapper indexWrapper) {
    List<double> categoryPositions = List.generate(
        categoriesLoadedState.categoriesList.length,
        (index) =>
            _getAbscissCategory(categoriesLoadedState.categoryButtonsKeys[
                categoriesLoadedState.orderCategories[index]]) -
            10);
    double lastNonPositiveCategoryPosition =
        _getLastNonPositiveCategoryPosition(categoryPositions);
    List<int> sortedOrderCategories =
        List<int>.from(categoriesLoadedState.orderCategories);
    for (int i = 0; i < sortedOrderCategories.length; i++) {
      if (categoryPositions[0] < 0 &&
          categoryPositions[0] != lastNonPositiveCategoryPosition) {
        _moveToEnd(categoryPositions, 0);
        _moveToEnd(sortedOrderCategories, 0);
        indexWrapper.activeIndex -= 1;
      } else {
        break;
      }
    }
    appBarScrollController.jumpTo(lastNonPositiveCategoryPosition.abs());
    return sortedOrderCategories;
  }

  double _getAbscissCategory(GlobalKey categoryKey) {
    BuildContext? currentContext = categoryKey.currentContext;
    if (currentContext != null) {
      RenderBox renderBox =
          currentContext.findAncestorRenderObjectOfType() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      return offset.dx;
    } else {
      return -1;
    }
  }

  void _moveToEnd(List<dynamic> list, int index) {
    var element = list.removeAt(0);
    list.add(element);
  }

  double _getLastNonPositiveCategoryPosition(List<double> categoryPositions) {
    for (int i = 0; i < categoryPositions.length - 1; i++) {
      if (categoryPositions[i + 1] > 1) {
        return categoryPositions[i];
      }
    }
    return 0.0;
  }

  void _loadCategories(
      CategoriesLoadCategoriesEvent event, Emitter emit) async {
    emit(CategoriesLoadingState());
    List<Category> categoriesList = await _categoryRepository.loadCategories();
    emit(
      CategoriesLoadedState(
        activeCategoryIndex: 0,
        categoriesKeys:
            List.generate(categoriesList.length, (index) => GlobalKey()),
        categoryButtonsKeys:
            List.generate(categoriesList.length, (index) => GlobalKey()),
        orderCategories: List.generate(categoriesList.length, (index) => index),
        categoriesList: categoriesList,
        categoriesIsAnimated: false,
      ),
    );
  }
}
