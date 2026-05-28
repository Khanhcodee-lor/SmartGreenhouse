// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensors_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SensorsModel _$SensorsModelFromJson(Map<String, dynamic> json) {
  return _SensorsModel.fromJson(json);
}

/// @nodoc
mixin _$SensorsModel {
  double get temperature => throw _privateConstructorUsedError;
  double get humidity => throw _privateConstructorUsedError;
  double get soilMoisture => throw _privateConstructorUsedError;
  double get lightLevel => throw _privateConstructorUsedError;
  double get flowRate => throw _privateConstructorUsedError;
  double get totalLitres => throw _privateConstructorUsedError;

  /// Serializes this SensorsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SensorsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SensorsModelCopyWith<SensorsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorsModelCopyWith<$Res> {
  factory $SensorsModelCopyWith(
    SensorsModel value,
    $Res Function(SensorsModel) then,
  ) = _$SensorsModelCopyWithImpl<$Res, SensorsModel>;
  @useResult
  $Res call({
    double temperature,
    double humidity,
    double soilMoisture,
    double lightLevel,
    double flowRate,
    double totalLitres,
  });
}

/// @nodoc
class _$SensorsModelCopyWithImpl<$Res, $Val extends SensorsModel>
    implements $SensorsModelCopyWith<$Res> {
  _$SensorsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SensorsModel
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SensorsModelImplCopyWith<$Res>
    implements $SensorsModelCopyWith<$Res> {
  factory _$$SensorsModelImplCopyWith(
    _$SensorsModelImpl value,
    $Res Function(_$SensorsModelImpl) then,
  ) = __$$SensorsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double temperature,
    double humidity,
    double soilMoisture,
    double lightLevel,
    double flowRate,
    double totalLitres,
  });
}

/// @nodoc
class __$$SensorsModelImplCopyWithImpl<$Res>
    extends _$SensorsModelCopyWithImpl<$Res, _$SensorsModelImpl>
    implements _$$SensorsModelImplCopyWith<$Res> {
  __$$SensorsModelImplCopyWithImpl(
    _$SensorsModelImpl _value,
    $Res Function(_$SensorsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SensorsModel
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
  }) {
    return _then(
      _$SensorsModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SensorsModelImpl extends _SensorsModel {
  const _$SensorsModelImpl({
    this.temperature = 0.0,
    this.humidity = 0.0,
    this.soilMoisture = 0.0,
    this.lightLevel = 0.0,
    this.flowRate = 0.0,
    this.totalLitres = 0.0,
  }) : super._();

  factory _$SensorsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SensorsModelImplFromJson(json);

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
  String toString() {
    return 'SensorsModel(temperature: $temperature, humidity: $humidity, soilMoisture: $soilMoisture, lightLevel: $lightLevel, flowRate: $flowRate, totalLitres: $totalLitres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SensorsModelImpl &&
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
                other.totalLitres == totalLitres));
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
  );

  /// Create a copy of SensorsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SensorsModelImplCopyWith<_$SensorsModelImpl> get copyWith =>
      __$$SensorsModelImplCopyWithImpl<_$SensorsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SensorsModelImplToJson(this);
  }
}

abstract class _SensorsModel extends SensorsModel {
  const factory _SensorsModel({
    final double temperature,
    final double humidity,
    final double soilMoisture,
    final double lightLevel,
    final double flowRate,
    final double totalLitres,
  }) = _$SensorsModelImpl;
  const _SensorsModel._() : super._();

  factory _SensorsModel.fromJson(Map<String, dynamic> json) =
      _$SensorsModelImpl.fromJson;

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

  /// Create a copy of SensorsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SensorsModelImplCopyWith<_$SensorsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
