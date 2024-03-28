part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}

class CategoriesSetActiveCategoryEvent extends CategoriesEvent {
  final int activeIndex;

  CategoriesSetActiveCategoryEvent({required this.activeIndex});
}

class CategoriesLoadCategoriesEvent extends CategoriesEvent {}
