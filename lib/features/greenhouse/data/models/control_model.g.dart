// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ControlModelImpl _$$ControlModelImplFromJson(Map<String, dynamic> json) =>
    _$ControlModelImpl(
      manualMode: json['manualMode'] as bool? ?? false,
      pump: json['pump'] as bool? ?? false,
      fan: json['fan'] as bool? ?? false,
      light: json['light'] as bool? ?? false,
      resetWater: json['resetWater'] as bool? ?? false,
    );

Map<String, dynamic> _$$ControlModelImplToJson(_$ControlModelImpl instance) =>
    <String, dynamic>{
      'manualMode': instance.manualMode,
      'pump': instance.pump,
      'fan': instance.fan,
      'light': instance.light,
      'resetWater': instance.resetWater,
    };
