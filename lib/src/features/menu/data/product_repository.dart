import 'package:siberian_coffee/src/common/network/exceptions/persistance_exception.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/category.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/product.dart';
import 'package:siberian_coffee/src/features/menu/utils/product_mapper.dart';

abstract class IProductRepository {
  Future<List<Product>> loadProductsByCategory(
      {required int categoryId, page = 0, limit = 25});
  Future<List<Product>> loadProducts(List<Category> categoriesList);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource _networkProductDataSource;

  ProductRepository({
    required IProductDataSource networkProductDataSource,
  }) : _networkProductDataSource = networkProductDataSource;

  @override
  Future<List<Product>> loadProductsByCategory(
      {required int categoryId, page = 0, limit = 25}) async {
    var dtos = <ProductDto>[];
    try {
      dtos = await _networkProductDataSource.loadProducts(
          categoryId: categoryId, page: page, limit: limit);
    } catch (e) {
      throw PersistanceException("There is problem in loading products: $e");
    }
    return dtos.map((e) => e.toModel()).toList();
  }

  @override
  Future<List<Product>> loadProducts(List<Category> categoriesList) async {
    // const int pageLimit = 25;

    // List<Product> productList = <Product>[];

    // for (Category category in categoriesList) {
    //   int currentPage = 0;
    //   while (true) {
    //     List<Product> categoryProductList = await loadProductsByCategory(
    //       categoryId: category.categoryId,
    //       page: currentPage,
    //       limit: pageLimit,
    //     );
    //     productList.addAll(categoryProductList);
    //     if (categoryProductList.length < pageLimit) {
    //       currentPage = 0;
    //       break;
    //     }
    //     currentPage += 1;
    //   }
    // }
    return [];
  }
}
