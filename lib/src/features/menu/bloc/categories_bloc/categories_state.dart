part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoryLoadingErrorState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final int activeCategoryIndex;
  final List<GlobalKey> categoriesKeys;
  final List<GlobalKey> categoryButtonsKeys;
  final List<int> orderCategories;
  final List<Category> categoriesList;
  final bool categoriesIsAnimated;
  CategoriesLoadedState({
    required this.activeCategoryIndex,
    required this.categoriesKeys,
    required this.categoryButtonsKeys,
    required this.orderCategories,
    required this.categoriesList,
    required this.categoriesIsAnimated,
  });

  CategoriesLoadedState copyWith({
    int? activeCategoryIndex,
    List<GlobalKey>? categoriesKeys,
    List<GlobalKey>? categoryButtonsKeys,
    List<int>? orderCategories,
    List<Category>? categoriesList,
    bool? categoriesIsAnimated,
  }) {
    return CategoriesLoadedState(
      activeCategoryIndex: activeCategoryIndex ?? this.activeCategoryIndex,
      categoriesKeys: categoriesKeys ?? this.categoriesKeys,
      categoryButtonsKeys: categoryButtonsKeys ?? this.categoryButtonsKeys,
      orderCategories: orderCategories ?? this.orderCategories,
      categoriesList: categoriesList ?? this.categoriesList,
      categoriesIsAnimated: categoriesIsAnimated ?? this.categoriesIsAnimated,
    );
  }
}
