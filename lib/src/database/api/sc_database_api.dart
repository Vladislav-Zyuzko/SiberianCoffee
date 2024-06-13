import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/database/sc_database.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/product/product_dto.dart';

abstract interface class IScDatabaseApi {
  Future<void> saveCategories({required List<CategoryDto> categories});
  Future<void> saveProducts({required List<ProductDto> products});
  Future<List<CategoryDto>> loadCategories();
  Future<void> loadProducts(int categoryId, int page, int limit);
}

class ScDatabaseApi implements IScDatabaseApi {
  final SiberianCoffeeDatabase _scDatabase;

  const ScDatabaseApi({required SiberianCoffeeDatabase scDatabase})
      : _scDatabase = scDatabase;

  @override
  Future<void> saveCategories({required List<CategoryDto> categories}) async {
    _scDatabase.categoryTable.deleteAll();
    List<CategoryTableCompanion> rows = categories.map(
      (category) => CategoryTableCompanion.insert(id: Value(category.id), slug: category.slug),
    ).toList();
    await _scDatabase.batch((batch) => batch.insertAll(_scDatabase.categoryTable, rows));
  }

  @override
  Future<void> saveProducts({required List<ProductDto> products}) async {
    List<ProductTableCompanion> rows = products.map(
          (product) => ProductTableCompanion.insert(
            id: Value(product.id),
            name: product.name,
            description: product.description,
            category: product.category.id,
            imageUrl: product.imageUrl,
            prices: product.prices,
          ),
    ).toList();
    await _scDatabase.batch((batch) => batch.insertAllOnConflictUpdate(_scDatabase.productTable, rows));
  }

  @override
  Future<List<CategoryDto>> loadCategories() async {
    List<CategoryTableData> rows =
        await _scDatabase.select(_scDatabase.categoryTable).get();
    return rows.map((categoryData) => CategoryDto(id: categoryData.id, slug: categoryData.slug)).toList();
  }

  @override
  Future<List<ProductDto>> loadProducts(int categoryId, int page, int limit) async {
    CategoryTableData categoryData = await (
      _scDatabase.select(_scDatabase.categoryTable)
      ..where((tbl) => tbl.id.equals(categoryId))
    ).getSingle();
    List<ProductTableData> rows = await (
      _scDatabase.select(_scDatabase.productTable)
      ..where((tbl) => tbl.category.equals(categoryId))
      ..limit(limit, offset: page * limit)
    ).get();
    return rows.map((productData) => ProductDto(
      id: productData.id, 
      name: productData.name, 
      description: productData.description, 
      category: CategoryDto(
        id: categoryData.id,
        slug: categoryData.slug,
      ), 
      imageUrl: productData.imageUrl, 
      prices: productData.prices,
    )).toList();
  }
}
