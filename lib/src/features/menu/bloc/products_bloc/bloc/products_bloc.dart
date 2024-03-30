import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:siberian_coffee/src/common/data_source/product_repository.dart';
import 'package:siberian_coffee/src/features/menu/bloc/categories_bloc/categories_bloc.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  CategoriesBloc categoriesBloc;
  late final StreamSubscription _categoriesBlocSubscription;
  final ProductRepository _productRepository = ProductRepository();
  ProductsBloc(this.categoriesBloc) : super(ProductsUnloadedState()) {
    on<ProductsLoadProductsEvent>(_loadProducts);
    _categoriesBlocSubscription = categoriesBloc.stream.listen((state) {
      if (state is CategoriesLoadedState && this.state is ProductsUnloadedState) {
        add(ProductsLoadProductsEvent());
      }
    });
  }

  @override
  Future<void> close() async {
    _categoriesBlocSubscription.cancel();
    return super.close();
  }

  void _loadProducts(ProductsLoadProductsEvent event, Emitter emit) async {
    emit(ProductsLoadingState());
    CategoriesLoadedState categoriesLoadedState =
        categoriesBloc.state as CategoriesLoadedState;
    List<Product> productList = await _productRepository
        .loadProducts(categoriesLoadedState.categoriesList);
    emit(ProductsLoadedState(productList: productList, categoriesList: categoriesLoadedState.categoriesList));
  }
}
