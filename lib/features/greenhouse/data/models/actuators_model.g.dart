// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actuators_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActuatorsModelImpl _$$ActuatorsModelImplFromJson(Map<String, dynamic> json) =>
    _$ActuatorsModelImpl(
      pump: json['pump'] as bool? ?? false,
      fan: json['fan'] as bool? ?? false,
      light: json['light'] as bool? ?? false,
    );

Map<String, dynamic> _$$ActuatorsModelImplToJson(
  _$ActuatorsModelImpl instance,
) => <String, dynamic>{
  'pump': instance.pump,
  'fan': instance.fan,
  'light': instance.light,
};
