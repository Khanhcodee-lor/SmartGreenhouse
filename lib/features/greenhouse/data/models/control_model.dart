import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/control_entity.dart';

part 'control_model.freezed.dart';
part 'control_model.g.dart';

@freezed
class ControlModel with _$ControlModel {
  const ControlModel._();

  const factory ControlModel({
    @Default(false) bool manualMode,
    @Default(false) bool pump,
    @Default(false) bool fan,
    @Default(false) bool light,
    @Default(false) bool resetWater,
    @Default(60) int soilThreshold,
    @Default(40) int tempThreshold,
    @Default(30) int humidityThreshold,
  }) = _ControlModel;

  factory ControlModel.fromJson(Map<String, dynamic> json) =>
      _$ControlModelFromJson(json);

  ControlEntity toEntity() => ControlEntity(
    manualMode: manualMode,
    pump: pump,
    fan: fan,
    light: light,
    resetWater: resetWater,
    soilThreshold: soilThreshold,
    tempThreshold: tempThreshold,
    humidityThreshold: humidityThreshold,
  );
}
