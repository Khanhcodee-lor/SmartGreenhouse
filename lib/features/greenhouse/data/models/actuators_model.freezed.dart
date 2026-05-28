// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'actuators_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ActuatorsModel _$ActuatorsModelFromJson(Map<String, dynamic> json) {
  return _ActuatorsModel.fromJson(json);
}

/// @nodoc
mixin _$ActuatorsModel {
  bool get pump => throw _privateConstructorUsedError;
  bool get fan => throw _privateConstructorUsedError;
  bool get light => throw _privateConstructorUsedError;

  /// Serializes this ActuatorsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActuatorsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActuatorsModelCopyWith<ActuatorsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActuatorsModelCopyWith<$Res> {
  factory $ActuatorsModelCopyWith(
    ActuatorsModel value,
    $Res Function(ActuatorsModel) then,
  ) = _$ActuatorsModelCopyWithImpl<$Res, ActuatorsModel>;
  @useResult
  $Res call({bool pump, bool fan, bool light});
}

/// @nodoc
class _$ActuatorsModelCopyWithImpl<$Res, $Val extends ActuatorsModel>
    implements $ActuatorsModelCopyWith<$Res> {
  _$ActuatorsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActuatorsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? pump = null, Object? fan = null, Object? light = null}) {
    return _then(
      _value.copyWith(
            pump: null == pump
                ? _value.pump
                : pump // ignore: cast_nullable_to_non_nullable
                      as bool,
            fan: null == fan
                ? _value.fan
                : fan // ignore: cast_nullable_to_non_nullable
                      as bool,
            light: null == light
                ? _value.light
                : light // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ActuatorsModelImplCopyWith<$Res>
    implements $ActuatorsModelCopyWith<$Res> {
  factory _$$ActuatorsModelImplCopyWith(
    _$ActuatorsModelImpl value,
    $Res Function(_$ActuatorsModelImpl) then,
  ) = __$$ActuatorsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool pump, bool fan, bool light});
}

/// @nodoc
class __$$ActuatorsModelImplCopyWithImpl<$Res>
    extends _$ActuatorsModelCopyWithImpl<$Res, _$ActuatorsModelImpl>
    implements _$$ActuatorsModelImplCopyWith<$Res> {
  __$$ActuatorsModelImplCopyWithImpl(
    _$ActuatorsModelImpl _value,
    $Res Function(_$ActuatorsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActuatorsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? pump = null, Object? fan = null, Object? light = null}) {
    return _then(
      _$ActuatorsModelImpl(
        pump: null == pump
            ? _value.pump
            : pump // ignore: cast_nullable_to_non_nullable
                  as bool,
        fan: null == fan
            ? _value.fan
            : fan // ignore: cast_nullable_to_non_nullable
                  as bool,
        light: null == light
            ? _value.light
            : light // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ActuatorsModelImpl extends _ActuatorsModel {
  const _$ActuatorsModelImpl({
    this.pump = false,
    this.fan = false,
    this.light = false,
  }) : super._();

  factory _$ActuatorsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActuatorsModelImplFromJson(json);

  @override
  @JsonKey()
  final bool pump;
  @override
  @JsonKey()
  final bool fan;
  @override
  @JsonKey()
  final bool light;

  @override
  String toString() {
    return 'ActuatorsModel(pump: $pump, fan: $fan, light: $light)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActuatorsModelImpl &&
            (identical(other.pump, pump) || other.pump == pump) &&
            (identical(other.fan, fan) || other.fan == fan) &&
            (identical(other.light, light) || other.light == light));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pump, fan, light);

  /// Create a copy of ActuatorsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActuatorsModelImplCopyWith<_$ActuatorsModelImpl> get copyWith =>
      __$$ActuatorsModelImplCopyWithImpl<_$ActuatorsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ActuatorsModelImplToJson(this);
  }
}

abstract class _ActuatorsModel extends ActuatorsModel {
  const factory _ActuatorsModel({
    final bool pump,
    final bool fan,
    final bool light,
  }) = _$ActuatorsModelImpl;
  const _ActuatorsModel._() : super._();

  factory _ActuatorsModel.fromJson(Map<String, dynamic> json) =
      _$ActuatorsModelImpl.fromJson;

  @override
  bool get pump;
  @override
  bool get fan;
  @override
  bool get light;

  /// Create a copy of ActuatorsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActuatorsModelImplCopyWith<_$ActuatorsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
