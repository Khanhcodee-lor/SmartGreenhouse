// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'greenhouse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GreenhouseModel _$GreenhouseModelFromJson(Map<String, dynamic> json) {
  return _GreenhouseModel.fromJson(json);
}

/// @nodoc
mixin _$GreenhouseModel {
  DeviceModel get device => throw _privateConstructorUsedError;
  GreenhouseStateModel get state => throw _privateConstructorUsedError;
  ControlModel get control => throw _privateConstructorUsedError;
  ActuatorsModel get actuators => throw _privateConstructorUsedError;
  SensorsModel get sensors => throw _privateConstructorUsedError;
  Map<String, SensorHistoryModel> get history =>
      throw _privateConstructorUsedError;

  /// Serializes this GreenhouseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GreenhouseModelCopyWith<GreenhouseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GreenhouseModelCopyWith<$Res> {
  factory $GreenhouseModelCopyWith(
    GreenhouseModel value,
    $Res Function(GreenhouseModel) then,
  ) = _$GreenhouseModelCopyWithImpl<$Res, GreenhouseModel>;
  @useResult
  $Res call({
    DeviceModel device,
    GreenhouseStateModel state,
    ControlModel control,
    ActuatorsModel actuators,
    SensorsModel sensors,
    Map<String, SensorHistoryModel> history,
  });

  $DeviceModelCopyWith<$Res> get device;
  $GreenhouseStateModelCopyWith<$Res> get state;
  $ControlModelCopyWith<$Res> get control;
  $ActuatorsModelCopyWith<$Res> get actuators;
  $SensorsModelCopyWith<$Res> get sensors;
}

/// @nodoc
class _$GreenhouseModelCopyWithImpl<$Res, $Val extends GreenhouseModel>
    implements $GreenhouseModelCopyWith<$Res> {
  _$GreenhouseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? device = null,
    Object? state = null,
    Object? control = null,
    Object? actuators = null,
    Object? sensors = null,
    Object? history = null,
  }) {
    return _then(
      _value.copyWith(
            device: null == device
                ? _value.device
                : device // ignore: cast_nullable_to_non_nullable
                      as DeviceModel,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as GreenhouseStateModel,
            control: null == control
                ? _value.control
                : control // ignore: cast_nullable_to_non_nullable
                      as ControlModel,
            actuators: null == actuators
                ? _value.actuators
                : actuators // ignore: cast_nullable_to_non_nullable
                      as ActuatorsModel,
            sensors: null == sensors
                ? _value.sensors
                : sensors // ignore: cast_nullable_to_non_nullable
                      as SensorsModel,
            history: null == history
                ? _value.history
                : history // ignore: cast_nullable_to_non_nullable
                      as Map<String, SensorHistoryModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceModelCopyWith<$Res> get device {
    return $DeviceModelCopyWith<$Res>(_value.device, (value) {
      return _then(_value.copyWith(device: value) as $Val);
    });
  }

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GreenhouseStateModelCopyWith<$Res> get state {
    return $GreenhouseStateModelCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ControlModelCopyWith<$Res> get control {
    return $ControlModelCopyWith<$Res>(_value.control, (value) {
      return _then(_value.copyWith(control: value) as $Val);
    });
  }

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ActuatorsModelCopyWith<$Res> get actuators {
    return $ActuatorsModelCopyWith<$Res>(_value.actuators, (value) {
      return _then(_value.copyWith(actuators: value) as $Val);
    });
  }

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SensorsModelCopyWith<$Res> get sensors {
    return $SensorsModelCopyWith<$Res>(_value.sensors, (value) {
      return _then(_value.copyWith(sensors: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GreenhouseModelImplCopyWith<$Res>
    implements $GreenhouseModelCopyWith<$Res> {
  factory _$$GreenhouseModelImplCopyWith(
    _$GreenhouseModelImpl value,
    $Res Function(_$GreenhouseModelImpl) then,
  ) = __$$GreenhouseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DeviceModel device,
    GreenhouseStateModel state,
    ControlModel control,
    ActuatorsModel actuators,
    SensorsModel sensors,
    Map<String, SensorHistoryModel> history,
  });

  @override
  $DeviceModelCopyWith<$Res> get device;
  @override
  $GreenhouseStateModelCopyWith<$Res> get state;
  @override
  $ControlModelCopyWith<$Res> get control;
  @override
  $ActuatorsModelCopyWith<$Res> get actuators;
  @override
  $SensorsModelCopyWith<$Res> get sensors;
}

/// @nodoc
class __$$GreenhouseModelImplCopyWithImpl<$Res>
    extends _$GreenhouseModelCopyWithImpl<$Res, _$GreenhouseModelImpl>
    implements _$$GreenhouseModelImplCopyWith<$Res> {
  __$$GreenhouseModelImplCopyWithImpl(
    _$GreenhouseModelImpl _value,
    $Res Function(_$GreenhouseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? device = null,
    Object? state = null,
    Object? control = null,
    Object? actuators = null,
    Object? sensors = null,
    Object? history = null,
  }) {
    return _then(
      _$GreenhouseModelImpl(
        device: null == device
            ? _value.device
            : device // ignore: cast_nullable_to_non_nullable
                  as DeviceModel,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as GreenhouseStateModel,
        control: null == control
            ? _value.control
            : control // ignore: cast_nullable_to_non_nullable
                  as ControlModel,
        actuators: null == actuators
            ? _value.actuators
            : actuators // ignore: cast_nullable_to_non_nullable
                  as ActuatorsModel,
        sensors: null == sensors
            ? _value.sensors
            : sensors // ignore: cast_nullable_to_non_nullable
                  as SensorsModel,
        history: null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as Map<String, SensorHistoryModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GreenhouseModelImpl extends _GreenhouseModel {
  const _$GreenhouseModelImpl({
    this.device = const DeviceModel(),
    this.state = const GreenhouseStateModel(),
    this.control = const ControlModel(),
    this.actuators = const ActuatorsModel(),
    this.sensors = const SensorsModel(),
    final Map<String, SensorHistoryModel> history = const {},
  }) : _history = history,
       super._();

  factory _$GreenhouseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GreenhouseModelImplFromJson(json);

  @override
  @JsonKey()
  final DeviceModel device;
  @override
  @JsonKey()
  final GreenhouseStateModel state;
  @override
  @JsonKey()
  final ControlModel control;
  @override
  @JsonKey()
  final ActuatorsModel actuators;
  @override
  @JsonKey()
  final SensorsModel sensors;
  final Map<String, SensorHistoryModel> _history;
  @override
  @JsonKey()
  Map<String, SensorHistoryModel> get history {
    if (_history is EqualUnmodifiableMapView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_history);
  }

  @override
  String toString() {
    return 'GreenhouseModel(device: $device, state: $state, control: $control, actuators: $actuators, sensors: $sensors, history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GreenhouseModelImpl &&
            (identical(other.device, device) || other.device == device) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.control, control) || other.control == control) &&
            (identical(other.actuators, actuators) ||
                other.actuators == actuators) &&
            (identical(other.sensors, sensors) || other.sensors == sensors) &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    device,
    state,
    control,
    actuators,
    sensors,
    const DeepCollectionEquality().hash(_history),
  );

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GreenhouseModelImplCopyWith<_$GreenhouseModelImpl> get copyWith =>
      __$$GreenhouseModelImplCopyWithImpl<_$GreenhouseModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GreenhouseModelImplToJson(this);
  }
}

abstract class _GreenhouseModel extends GreenhouseModel {
  const factory _GreenhouseModel({
    final DeviceModel device,
    final GreenhouseStateModel state,
    final ControlModel control,
    final ActuatorsModel actuators,
    final SensorsModel sensors,
    final Map<String, SensorHistoryModel> history,
  }) = _$GreenhouseModelImpl;
  const _GreenhouseModel._() : super._();

  factory _GreenhouseModel.fromJson(Map<String, dynamic> json) =
      _$GreenhouseModelImpl.fromJson;

  @override
  DeviceModel get device;
  @override
  GreenhouseStateModel get state;
  @override
  ControlModel get control;
  @override
  ActuatorsModel get actuators;
  @override
  SensorsModel get sensors;
  @override
  Map<String, SensorHistoryModel> get history;

  /// Create a copy of GreenhouseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GreenhouseModelImplCopyWith<_$GreenhouseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
