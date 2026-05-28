// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_history_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SensorHistoryModel _$SensorHistoryModelFromJson(Map<String, dynamic> json) {
  return _SensorHistoryModel.fromJson(json);
}

/// @nodoc
mixin _$SensorHistoryModel {
  double get temperature => throw _privateConstructorUsedError;
  double get humidity => throw _privateConstructorUsedError;
  double get soilMoisture => throw _privateConstructorUsedError;
  double get lightLevel => throw _privateConstructorUsedError;
  double get flowRate => throw _privateConstructorUsedError;
  double get totalLitres => throw _privateConstructorUsedError;
  int get savedAtEpoch => throw _privateConstructorUsedError;

  /// Serializes this SensorHistoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SensorHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SensorHistoryModelCopyWith<SensorHistoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorHistoryModelCopyWith<$Res> {
  factory $SensorHistoryModelCopyWith(
    SensorHistoryModel value,
    $Res Function(SensorHistoryModel) then,
  ) = _$SensorHistoryModelCopyWithImpl<$Res, SensorHistoryModel>;
  @useResult
  $Res call({
    double temperature,
    double humidity,
    double soilMoisture,
    double lightLevel,
    double flowRate,
    double totalLitres,
    int savedAtEpoch,
  });
}

/// @nodoc
class _$SensorHistoryModelCopyWithImpl<$Res, $Val extends SensorHistoryModel>
    implements $SensorHistoryModelCopyWith<$Res> {
  _$SensorHistoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SensorHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? humidity = null,
    Object? soilMoisture = null,
    Object? lightLevel = null,
    Object? flowRate = null,
    Object? totalLitres = null,
    Object? savedAtEpoch = null,
  }) {
    return _then(
      _value.copyWith(
            temperature: null == temperature
                ? _value.temperature
                : temperature // ignore: cast_nullable_to_non_nullable
                      as double,
            humidity: null == humidity
                ? _value.humidity
                : humidity // ignore: cast_nullable_to_non_nullable
                      as double,
            soilMoisture: null == soilMoisture
                ? _value.soilMoisture
                : soilMoisture // ignore: cast_nullable_to_non_nullable
                      as double,
            lightLevel: null == lightLevel
                ? _value.lightLevel
                : lightLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            flowRate: null == flowRate
                ? _value.flowRate
                : flowRate // ignore: cast_nullable_to_non_nullable
                      as double,
            totalLitres: null == totalLitres
                ? _value.totalLitres
                : totalLitres // ignore: cast_nullable_to_non_nullable
                      as double,
            savedAtEpoch: null == savedAtEpoch
                ? _value.savedAtEpoch
                : savedAtEpoch // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SensorHistoryModelImplCopyWith<$Res>
    implements $SensorHistoryModelCopyWith<$Res> {
  factory _$$SensorHistoryModelImplCopyWith(
    _$SensorHistoryModelImpl value,
    $Res Function(_$SensorHistoryModelImpl) then,
  ) = __$$SensorHistoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double temperature,
    double humidity,
    double soilMoisture,
    double lightLevel,
    double flowRate,
    double totalLitres,
    int savedAtEpoch,
  });
}

/// @nodoc
class __$$SensorHistoryModelImplCopyWithImpl<$Res>
    extends _$SensorHistoryModelCopyWithImpl<$Res, _$SensorHistoryModelImpl>
    implements _$$SensorHistoryModelImplCopyWith<$Res> {
  __$$SensorHistoryModelImplCopyWithImpl(
    _$SensorHistoryModelImpl _value,
    $Res Function(_$SensorHistoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SensorHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? humidity = null,
    Object? soilMoisture = null,
    Object? lightLevel = null,
    Object? flowRate = null,
    Object? totalLitres = null,
    Object? savedAtEpoch = null,
  }) {
    return _then(
      _$SensorHistoryModelImpl(
        temperature: null == temperature
            ? _value.temperature
            : temperature // ignore: cast_nullable_to_non_nullable
                  as double,
        humidity: null == humidity
            ? _value.humidity
            : humidity // ignore: cast_nullable_to_non_nullable
                  as double,
        soilMoisture: null == soilMoisture
            ? _value.soilMoisture
            : soilMoisture // ignore: cast_nullable_to_non_nullable
                  as double,
        lightLevel: null == lightLevel
            ? _value.lightLevel
            : lightLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        flowRate: null == flowRate
            ? _value.flowRate
            : flowRate // ignore: cast_nullable_to_non_nullable
                  as double,
        totalLitres: null == totalLitres
            ? _value.totalLitres
            : totalLitres // ignore: cast_nullable_to_non_nullable
                  as double,
        savedAtEpoch: null == savedAtEpoch
            ? _value.savedAtEpoch
            : savedAtEpoch // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SensorHistoryModelImpl extends _SensorHistoryModel {
  const _$SensorHistoryModelImpl({
    this.temperature = 0.0,
    this.humidity = 0.0,
    this.soilMoisture = 0.0,
    this.lightLevel = 0.0,
    this.flowRate = 0.0,
    this.totalLitres = 0.0,
    this.savedAtEpoch = 0,
  }) : super._();

  factory _$SensorHistoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorHistoryModelImplFromJson(json);

  @override
  @JsonKey()
  final double temperature;
  @override
  @JsonKey()
  final double humidity;
  @override
  @JsonKey()
  final double soilMoisture;
  @override
  @JsonKey()
  final double lightLevel;
  @override
  @JsonKey()
  final double flowRate;
  @override
  @JsonKey()
  final double totalLitres;
  @override
  @JsonKey()
  final int savedAtEpoch;

  @override
  String toString() {
    return 'SensorHistoryModel(temperature: $temperature, humidity: $humidity, soilMoisture: $soilMoisture, lightLevel: $lightLevel, flowRate: $flowRate, totalLitres: $totalLitres, savedAtEpoch: $savedAtEpoch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorHistoryModelImpl &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.soilMoisture, soilMoisture) ||
                other.soilMoisture == soilMoisture) &&
            (identical(other.lightLevel, lightLevel) ||
                other.lightLevel == lightLevel) &&
            (identical(other.flowRate, flowRate) ||
                other.flowRate == flowRate) &&
            (identical(other.totalLitres, totalLitres) ||
                other.totalLitres == totalLitres) &&
            (identical(other.savedAtEpoch, savedAtEpoch) ||
                other.savedAtEpoch == savedAtEpoch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    temperature,
    humidity,
    soilMoisture,
    lightLevel,
    flowRate,
    totalLitres,
    savedAtEpoch,
  );

  /// Create a copy of SensorHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorHistoryModelImplCopyWith<_$SensorHistoryModelImpl> get copyWith =>
      __$$SensorHistoryModelImplCopyWithImpl<_$SensorHistoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorHistoryModelImplToJson(this);
  }
}

abstract class _SensorHistoryModel extends SensorHistoryModel {
  const factory _SensorHistoryModel({
    final double temperature,
    final double humidity,
    final double soilMoisture,
    final double lightLevel,
    final double flowRate,
    final double totalLitres,
    final int savedAtEpoch,
  }) = _$SensorHistoryModelImpl;
  const _SensorHistoryModel._() : super._();

  factory _SensorHistoryModel.fromJson(Map<String, dynamic> json) =
      _$SensorHistoryModelImpl.fromJson;

  @override
  double get temperature;
  @override
  double get humidity;
  @override
  double get soilMoisture;
  @override
  double get lightLevel;
  @override
  double get flowRate;
  @override
  double get totalLitres;
  @override
  int get savedAtEpoch;

  /// Create a copy of SensorHistoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SensorHistoryModelImplCopyWith<_$SensorHistoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
