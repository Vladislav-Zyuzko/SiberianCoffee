import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/store/sc_database.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/address/address_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';

abstract interface class IScDatabaseApi {
  Future<void> saveAddresses({required List<AddressDto> addresses});
  Future<void> saveCategories({required List<CategoryDto> categories});
  Future<void> saveProducts({required List<ProductDto> products});
  Future<List<AddressDto>> loadAddresses();
  Future<List<CategoryDto>> loadCategories();
  Future<List<ProductDto>> loadProducts(int categoryId, int page, int limit);
}

class ScDatabaseApi implements IScDatabaseApi {
  final SiberianCoffeeDatabase _scDatabase;

  const ScDatabaseApi({required SiberianCoffeeDatabase scDatabase})
      : _scDatabase = scDatabase;

  @override
  Future<void> saveAddresses({required List<AddressDto> addresses}) async {
    _scDatabase.addressTable.deleteAll();
    List<AddressTableCompanion> rows = addresses
        .map(
          (address) => AddressTableCompanion.insert(
            address: address.address,
            lat: address.lat,
            lng: address.lng,
          ),
        )
        .toList();
    await _scDatabase.batch(
      (batch) => batch.insertAll(_scDatabase.addressTable, rows),
    );
  }

  @override
  Future<void> saveCategories({required List<CategoryDto> categories}) async {
    await _scDatabase.categoryTable.deleteAll();
    List<CategoryTableCompanion> rows = categories
        .map(
          (category) => CategoryTableCompanion.insert(
              id: Value(category.id), slug: category.slug),
        )
        .toList();
    await _scDatabase.batch(
      (batch) => batch.insertAll(_scDatabase.categoryTable, rows),
    );
  }

  @override
  Future<void> saveProducts({required List<ProductDto> products}) async {
    List<ProductTableCompanion> rows = products
        .map(
          (product) => ProductTableCompanion.insert(
            id: Value(product.id),
            name: product.name,
            description: product.description,
            category: product.category.id,
            imageUrl: product.imageUrl,
            prices: product.prices,
          ),
        )
        .toList();
    await _scDatabase.batch(
      (batch) =>
          batch.insertAllOnConflictUpdate(_scDatabase.productTable, rows),
    );
  }

  @override
  Future<List<AddressDto>> loadAddresses() async {
    List<AddressTableData> rows =
        await _scDatabase.select(_scDatabase.addressTable).get();
    return rows
        .map((addressData) => AddressDto(
              address: addressData.address,
              lat: addressData.lat,
              lng: addressData.lng,
            ))
        .toList();
  }

  @override
  Future<List<CategoryDto>> loadCategories() async {
    List<CategoryTableData> rows =
        await _scDatabase.select(_scDatabase.categoryTable).get();
    return rows
        .map((categoryData) =>
            CategoryDto(id: categoryData.id, slug: categoryData.slug))
        .toList();
  }

  @override
  Future<List<ProductDto>> loadProducts(
      int categoryId, int page, int limit) async {
    CategoryTableData categoryData =
        await (_scDatabase.select(_scDatabase.categoryTable)
              ..where((tbl) => tbl.id.equals(categoryId)))
            .getSingle();
    List<ProductTableData> rows =
        await (_scDatabase.select(_scDatabase.productTable)
              ..where((tbl) => tbl.category.equals(categoryId))
              ..limit(limit, offset: page * limit))
            .get();
    return rows
        .map((productData) => ProductDto(
              id: productData.id,
              name: productData.name,
              description: productData.description,
              category: CategoryDto(
                id: categoryData.id,
                slug: categoryData.slug,
              ),
              imageUrl: productData.imageUrl,
              prices: productData.prices,
            ))
        .toList();
  }
}
