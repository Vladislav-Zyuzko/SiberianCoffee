// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceDto _$PriceDtoFromJson(Map<String, dynamic> json) => PriceDto(
      value: json['value'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$PriceDtoToJson(PriceDto instance) => <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
    };
