import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/sensors_entity.dart';

part 'sensors_model.freezed.dart';
part 'sensors_model.g.dart';

@freezed
class SensorsModel with _$SensorsModel {
  const SensorsModel._();

  const factory SensorsModel({
    @Default(0.0) double temperature,
    @Default(0.0) double humidity,
    @Default(0.0) double soilMoisture,
    @Default(0.0) double lightLevel,
    @Default(0.0) double flowRate,
    @Default(0.0) double totalLitres,
  }) = _SensorsModel;

  factory SensorsModel.fromJson(Map<String, dynamic> json) =>
      _$SensorsModelFromJson(json);

  SensorsEntity toEntity() => SensorsEntity(
        temperature: temperature,
        humidity: humidity,
        soilMoisture: soilMoisture,
        lightLevel: lightLevel,
        flowRate: flowRate,
        totalLitres: totalLitres,
      );
}
