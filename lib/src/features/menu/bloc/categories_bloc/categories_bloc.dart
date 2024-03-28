import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/common/data_source/category_repository.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRepository _categoryRepository = CategoryRepository();
  CategoriesBloc() : super(CategoriesLoadingState()) {
    on<CategoriesSetActiveCategoryEvent>(_setActiveCategory);
    on<CategoriesLoadCategoriesEvent>(_loadCategories);
  }

  void _setActiveCategory(
      CategoriesSetActiveCategoryEvent event, Emitter<CategoriesState> emit) {
    if (state is CategoriesLoadedState) {
      CategoriesLoadedState categoriesLoadedState = state as CategoriesLoadedState;
          List<int> newOrderCategories = [...categoriesLoadedState.orderCategories];
    int newActiveCategory = newOrderCategories.removeAt(event.activeIndex);
    newOrderCategories.insert(0, newActiveCategory);
    emit(
      categoriesLoadedState.copyWith(orderCategories: newOrderCategories),
    );
    }
  }

  void _loadCategories(CategoriesLoadCategoriesEvent event, Emitter emit) async {
    emit(CategoriesLoadingState());
    List<Category> categoriesList = await _categoryRepository.loadCategories();
    emit(
      CategoriesLoadedState(
          categoriesKeys: List.generate(categoriesList.length, (index) => GlobalKey()),
          orderCategories: List.generate(categoriesList.length, (index) => index),
          categoriesList: categoriesList,
        ),
    );
  }
}
