import 'package:drift/drift.dart';
import 'package:siberian_coffee/src/features/menu/models/dto/price/price_dto.dart';

JsonTypeConverter<List<PriceDto>, String> pricesConverter = TypeConverter.json(
  fromJson: (json) => (json['prices'] as List<dynamic>)
          .map((e) => PriceDto.fromJson(e as Map<String, dynamic>))
          .toList(),
  toJson: (prices) => <String, dynamic>{'prices': prices},
);