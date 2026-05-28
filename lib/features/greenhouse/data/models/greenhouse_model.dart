import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/greenhouse_entity.dart';
import 'device_model.dart';
import 'greenhouse_state_model.dart';
import 'control_model.dart';
import 'actuators_model.dart';
import 'sensors_model.dart';
import 'sensor_history_model.dart';

part 'greenhouse_model.freezed.dart';
part 'greenhouse_model.g.dart';

@freezed
class GreenhouseModel with _$GreenhouseModel {
  const GreenhouseModel._();

  const factory GreenhouseModel({
    @Default(DeviceModel()) DeviceModel device,
    @Default(GreenhouseStateModel()) GreenhouseStateModel state,
    @Default(ControlModel()) ControlModel control,
    @Default(ActuatorsModel()) ActuatorsModel actuators,
    @Default(SensorsModel()) SensorsModel sensors,
    @Default({}) Map<String, SensorHistoryModel> history,
  }) = _GreenhouseModel;

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) =>
      _$GreenhouseModelFromJson(json);

  GreenhouseEntity toEntity() => GreenhouseEntity(
        device: device.toEntity(),
        state: state.toEntity(),
        control: control.toEntity(),
        actuators: actuators.toEntity(),
        sensors: sensors.toEntity(),
        history: history.map((k, v) => MapEntry(k, v.toEntity())),
      );
}
