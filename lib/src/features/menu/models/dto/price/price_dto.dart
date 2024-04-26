import 'package:json_annotation/json_annotation.dart';

part 'price_dto.g.dart';

@JsonSerializable()
class PriceDto {
  final String value;
  final String currency;

  const PriceDto({
    required this.value,
    required this.currency,
  });

  factory PriceDto.fromJson(Map<String, dynamic> json) => _$PriceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDtoToJson(this);
  
}