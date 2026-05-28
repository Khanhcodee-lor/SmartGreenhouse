// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'control_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ControlModel _$ControlModelFromJson(Map<String, dynamic> json) {
  return _ControlModel.fromJson(json);
}

/// @nodoc
mixin _$ControlModel {
  bool get manualMode => throw _privateConstructorUsedError;
  bool get pump => throw _privateConstructorUsedError;
  bool get fan => throw _privateConstructorUsedError;
  bool get light => throw _privateConstructorUsedError;
  bool get resetWater => throw _privateConstructorUsedError;

  /// Serializes this ControlModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ControlModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ControlModelCopyWith<ControlModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ControlModelCopyWith<$Res> {
  factory $ControlModelCopyWith(
    ControlModel value,
    $Res Function(ControlModel) then,
  ) = _$ControlModelCopyWithImpl<$Res, ControlModel>;
  @useResult
  $Res call({
    bool manualMode,
    bool pump,
    bool fan,
    bool light,
    bool resetWater,
  });
}

/// @nodoc
class _$ControlModelCopyWithImpl<$Res, $Val extends ControlModel>
    implements $ControlModelCopyWith<$Res> {
  _$ControlModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ControlModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manualMode = null,
    Object? pump = null,
    Object? fan = null,
    Object? light = null,
    Object? resetWater = null,
  }) {
    return _then(
      _value.copyWith(
            manualMode: null == manualMode
                ? _value.manualMode
                : manualMode // ignore: cast_nullable_to_non_nullable
                      as bool,
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
            resetWater: null == resetWater
                ? _value.resetWater
                : resetWater // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ControlModelImplCopyWith<$Res>
    implements $ControlModelCopyWith<$Res> {
  factory _$$ControlModelImplCopyWith(
    _$ControlModelImpl value,
    $Res Function(_$ControlModelImpl) then,
  ) = __$$ControlModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool manualMode,
    bool pump,
    bool fan,
    bool light,
    bool resetWater,
  });
}

/// @nodoc
class __$$ControlModelImplCopyWithImpl<$Res>
    extends _$ControlModelCopyWithImpl<$Res, _$ControlModelImpl>
    implements _$$ControlModelImplCopyWith<$Res> {
  __$$ControlModelImplCopyWithImpl(
    _$ControlModelImpl _value,
    $Res Function(_$ControlModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ControlModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manualMode = null,
    Object? pump = null,
    Object? fan = null,
    Object? light = null,
    Object? resetWater = null,
  }) {
    return _then(
      _$ControlModelImpl(
        manualMode: null == manualMode
            ? _value.manualMode
            : manualMode // ignore: cast_nullable_to_non_nullable
                  as bool,
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
        resetWater: null == resetWater
            ? _value.resetWater
            : resetWater // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ControlModelImpl extends _ControlModel {
  const _$ControlModelImpl({
    this.manualMode = false,
    this.pump = false,
    this.fan = false,
    this.light = false,
    this.resetWater = false,
  }) : super._();

  factory _$ControlModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ControlModelImplFromJson(json);

  @override
  @JsonKey()
  final bool manualMode;
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
  @JsonKey()
  final bool resetWater;

  @override
  String toString() {
    return 'ControlModel(manualMode: $manualMode, pump: $pump, fan: $fan, light: $light, resetWater: $resetWater)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ControlModelImpl &&
            (identical(other.manualMode, manualMode) ||
                other.manualMode == manualMode) &&
            (identical(other.pump, pump) || other.pump == pump) &&
            (identical(other.fan, fan) || other.fan == fan) &&
            (identical(other.light, light) || other.light == light) &&
            (identical(other.resetWater, resetWater) ||
                other.resetWater == resetWater));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, manualMode, pump, fan, light, resetWater);

  /// Create a copy of ControlModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ControlModelImplCopyWith<_$ControlModelImpl> get copyWith =>
      __$$ControlModelImplCopyWithImpl<_$ControlModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ControlModelImplToJson(this);
  }
}

abstract class _ControlModel extends ControlModel {
  const factory _ControlModel({
    final bool manualMode,
    final bool pump,
    final bool fan,
    final bool light,
    final bool resetWater,
  }) = _$ControlModelImpl;
  const _ControlModel._() : super._();

  factory _ControlModel.fromJson(Map<String, dynamic> json) =
      _$ControlModelImpl.fromJson;

  @override
  bool get manualMode;
  @override
  bool get pump;
  @override
  bool get fan;
  @override
  bool get light;
  @override
  bool get resetWater;

  /// Create a copy of ControlModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ControlModelImplCopyWith<_$ControlModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
