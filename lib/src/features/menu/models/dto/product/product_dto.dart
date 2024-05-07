import 'package:json_annotation/json_annotation.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/category/category_dto.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/price/price_dto.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  final int id;
  final String name;
  final String description;
  final CategoryDto category;
  final String imageUrl;
  final List<PriceDto> prices;

  const ProductDto({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.prices,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

}
