import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sensor_history_entity.dart';

part 'sensor_history_model.freezed.dart';
part 'sensor_history_model.g.dart';

@freezed
class SensorHistoryModel with _$SensorHistoryModel {
  const SensorHistoryModel._();

  const factory SensorHistoryModel({
    @Default(0.0) double temperature,
    @Default(0.0) double humidity,
    @Default(0.0) double soilMoisture,
    @Default(0.0) double lightLevel,
    @Default(0.0) double flowRate,
    @Default(0.0) double totalLitres,
    @Default(0) int savedAtEpoch,
  }) = _SensorHistoryModel;

  factory SensorHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$SensorHistoryModelFromJson(json);

  SensorHistoryEntity toEntity() => SensorHistoryEntity(
        temperature: temperature.toDouble(),
        humidity: humidity.toDouble(),
        soilMoisture: soilMoisture.toDouble(),
        lightLevel: lightLevel.toDouble(),
        flowRate: flowRate.toDouble(),
        totalLitres: totalLitres.toDouble(),
        savedAtEpoch: savedAtEpoch,
      );
}

