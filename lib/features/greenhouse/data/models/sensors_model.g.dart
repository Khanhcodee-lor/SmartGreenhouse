// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensors_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorsModelImpl _$$SensorsModelImplFromJson(Map<String, dynamic> json) =>
    _$SensorsModelImpl(
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
      soilMoisture: (json['soilMoisture'] as num?)?.toDouble() ?? 0.0,
      lightLevel: (json['lightLevel'] as num?)?.toDouble() ?? 0.0,
      flowRate: (json['flowRate'] as num?)?.toDouble() ?? 0.0,
      totalLitres: (json['totalLitres'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SensorsModelImplToJson(_$SensorsModelImpl instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'soilMoisture': instance.soilMoisture,
      'lightLevel': instance.lightLevel,
      'flowRate': instance.flowRate,
      'totalLitres': instance.totalLitres,
    };
