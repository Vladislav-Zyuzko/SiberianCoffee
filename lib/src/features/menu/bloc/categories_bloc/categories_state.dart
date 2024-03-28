part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoryLoadingErrorState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final int activeCategoryIndex = 0;
  final List<GlobalKey> categoriesKeys;
  final List<int> orderCategories;
  final List<Category> categoriesList;
  CategoriesLoadedState(
      {required this.categoriesKeys,
      required this.orderCategories,
      required this.categoriesList});

  CategoriesLoadedState copyWith({
    List<GlobalKey>? categoriesKeys,
    List<int>? orderCategories,
    List<Category>? categoriesList,
  }) {
    return CategoriesLoadedState(
      categoriesKeys: categoriesKeys ?? this.categoriesKeys,
      orderCategories: orderCategories ?? this.orderCategories,
      categoriesList: categoriesList ?? this.categoriesList,
    );
  }
}
