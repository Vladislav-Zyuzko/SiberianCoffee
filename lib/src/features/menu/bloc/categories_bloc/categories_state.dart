part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {
  final int activeCategoryIndex = 0; 
  final List<GlobalKey> categoriesKeys;
  final List<int> orderCategories;

  const CategoriesState({required this.categoriesKeys, required this.orderCategories});
}

class CategoriesInitialState extends CategoriesState {
  CategoriesInitialState()
      : super(
            categoriesKeys:
                List.generate(categoriesList.length, (index) => GlobalKey()),
            orderCategories:
                List.generate(categoriesList.length, (index) => index)); 
}

class CategoriesBaseState extends CategoriesState {
  const CategoriesBaseState({required super.categoriesKeys, required super.orderCategories});
}
