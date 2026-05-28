// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greenhouse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GreenhouseModelImpl _$$GreenhouseModelImplFromJson(
  Map<String, dynamic> json,
) => _$GreenhouseModelImpl(
  device: json['device'] == null
      ? const DeviceModel()
      : DeviceModel.fromJson(json['device'] as Map<String, dynamic>),
  state: json['state'] == null
      ? const GreenhouseStateModel()
      : GreenhouseStateModel.fromJson(json['state'] as Map<String, dynamic>),
  control: json['control'] == null
      ? const ControlModel()
      : ControlModel.fromJson(json['control'] as Map<String, dynamic>),
  actuators: json['actuators'] == null
      ? const ActuatorsModel()
      : ActuatorsModel.fromJson(json['actuators'] as Map<String, dynamic>),
  sensors: json['sensors'] == null
      ? const SensorsModel()
      : SensorsModel.fromJson(json['sensors'] as Map<String, dynamic>),
  history:
      (json['history'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, SensorHistoryModel.fromJson(e as Map<String, dynamic>)),
      ) ??
      const {},
);

Map<String, dynamic> _$$GreenhouseModelImplToJson(
  _$GreenhouseModelImpl instance,
) => <String, dynamic>{
  'device': instance.device,
  'state': instance.state,
  'control': instance.control,
  'actuators': instance.actuators,
  'sensors': instance.sensors,
  'history': instance.history,
};
