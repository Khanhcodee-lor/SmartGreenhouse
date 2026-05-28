// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SensorHistoryModelImpl _$$SensorHistoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$SensorHistoryModelImpl(
  temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
  humidity: (json['humidity'] as num?)?.toDouble() ?? 0.0,
  soilMoisture: (json['soilMoisture'] as num?)?.toDouble() ?? 0.0,
  lightLevel: (json['lightLevel'] as num?)?.toDouble() ?? 0.0,
  flowRate: (json['flowRate'] as num?)?.toDouble() ?? 0.0,
  totalLitres: (json['totalLitres'] as num?)?.toDouble() ?? 0.0,
  savedAtEpoch: (json['savedAtEpoch'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SensorHistoryModelImplToJson(
  _$SensorHistoryModelImpl instance,
) => <String, dynamic>{
  'temperature': instance.temperature,
  'humidity': instance.humidity,
  'soilMoisture': instance.soilMoisture,
  'lightLevel': instance.lightLevel,
  'flowRate': instance.flowRate,
  'totalLitres': instance.totalLitres,
  'savedAtEpoch': instance.savedAtEpoch,
};
