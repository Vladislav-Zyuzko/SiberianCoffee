import 'package:json_annotation/json_annotation.dart';
import 'package:drift/drift.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  final int id;
  final String slug;

  const CategoryDto({
    required this.id,
    required this.slug,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  static JsonTypeConverter<CategoryDto, String> converter = TypeConverter.json(
    fromJson: (json) => CategoryDto.fromJson(json as Map<String, Object?>),
    toJson: (category) => category.toJson(),
  );
}
