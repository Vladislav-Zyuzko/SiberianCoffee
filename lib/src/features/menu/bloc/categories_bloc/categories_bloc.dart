import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:siberian_coffee/src/features/menu/data/local_categories.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesSetActiveCategoryEvent>(_setActiveCategory);
  }

  void _setActiveCategory(
      CategoriesSetActiveCategoryEvent event, Emitter emit) {
    List<int> newOrderCategories = [...state.orderCategories];
    int newActiveCategory = newOrderCategories.removeAt(event.activeIndex);
    newOrderCategories.insert(0, newActiveCategory);
    emit(CategoriesBaseState(
        categoriesKeys: state.categoriesKeys,
        orderCategories: newOrderCategories));
  }
}
