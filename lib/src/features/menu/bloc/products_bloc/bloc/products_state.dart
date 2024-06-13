part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsLoadingState extends ProductsState {}

final class ProductsUnloadedState extends ProductsState {}

final class ProductsLoadedState extends ProductsState {
  final List<Product> productList;
  final List<Category> categoriesList;

  ProductsLoadedState({required this.productList, required this.categoriesList});
}
