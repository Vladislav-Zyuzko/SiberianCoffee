import 'package:siberian_coffee/src/store/api/sc_database_api.dart';
import 'package:siberian_coffee/src/features/menu/data/data_sources/products_data_source.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';

abstract interface class ISavableProductsDataSource
    implements IProductDataSource {
  Future<void> saveProducts({required List<ProductDto> products});
}

class DbProductsDataSource implements ISavableProductsDataSource {
  final ScDatabaseApi _scDatabaseApi;

  const DbProductsDataSource({required ScDatabaseApi scDatabaseApi})
      : _scDatabaseApi = scDatabaseApi;

  @override
  Future<List<ProductDto>> loadProducts({required int categoryId, page = 0, limit = 25}) async {
    return _scDatabaseApi.loadProducts(categoryId, page, limit);
  }

  @override
  Future<void> saveProducts({required List<ProductDto> products}) async {
    _scDatabaseApi.saveProducts(products: products);
  }
}
