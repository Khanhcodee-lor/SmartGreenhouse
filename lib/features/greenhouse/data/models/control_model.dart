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
  }) = _ControlModel;

  factory ControlModel.fromJson(Map<String, dynamic> json) =>
      _$ControlModelFromJson(json);

  ControlEntity toEntity() => ControlEntity(
        manualMode: manualMode,
        pump: pump,
        fan: fan,
        light: light,
        resetWater: resetWater,
      );
}
