// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'greenhouse_state_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GreenhouseStateModel _$GreenhouseStateModelFromJson(Map<String, dynamic> json) {
  return _GreenhouseStateModel.fromJson(json);
}

/// @nodoc
mixin _$GreenhouseStateModel {
  bool get manualMode => throw _privateConstructorUsedError;

  /// Serializes this GreenhouseStateModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GreenhouseStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GreenhouseStateModelCopyWith<GreenhouseStateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GreenhouseStateModelCopyWith<$Res> {
  factory $GreenhouseStateModelCopyWith(
    GreenhouseStateModel value,
    $Res Function(GreenhouseStateModel) then,
  ) = _$GreenhouseStateModelCopyWithImpl<$Res, GreenhouseStateModel>;
  @useResult
  $Res call({bool manualMode});
}

/// @nodoc
class _$GreenhouseStateModelCopyWithImpl<
  $Res,
  $Val extends GreenhouseStateModel
>
    implements $GreenhouseStateModelCopyWith<$Res> {
  _$GreenhouseStateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GreenhouseStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? manualMode = null}) {
    return _then(
      _value.copyWith(
            manualMode: null == manualMode
                ? _value.manualMode
                : manualMode // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GreenhouseStateModelImplCopyWith<$Res>
    implements $GreenhouseStateModelCopyWith<$Res> {
  factory _$$GreenhouseStateModelImplCopyWith(
    _$GreenhouseStateModelImpl value,
    $Res Function(_$GreenhouseStateModelImpl) then,
  ) = __$$GreenhouseStateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool manualMode});
}

/// @nodoc
class __$$GreenhouseStateModelImplCopyWithImpl<$Res>
    extends _$GreenhouseStateModelCopyWithImpl<$Res, _$GreenhouseStateModelImpl>
    implements _$$GreenhouseStateModelImplCopyWith<$Res> {
  __$$GreenhouseStateModelImplCopyWithImpl(
    _$GreenhouseStateModelImpl _value,
    $Res Function(_$GreenhouseStateModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GreenhouseStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? manualMode = null}) {
    return _then(
      _$GreenhouseStateModelImpl(
        manualMode: null == manualMode
            ? _value.manualMode
            : manualMode // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GreenhouseStateModelImpl extends _GreenhouseStateModel {
  const _$GreenhouseStateModelImpl({this.manualMode = false}) : super._();

  factory _$GreenhouseStateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GreenhouseStateModelImplFromJson(json);

  @override
  @JsonKey()
  final bool manualMode;

  @override
  String toString() {
    return 'GreenhouseStateModel(manualMode: $manualMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GreenhouseStateModelImpl &&
            (identical(other.manualMode, manualMode) ||
                other.manualMode == manualMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, manualMode);

  /// Create a copy of GreenhouseStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GreenhouseStateModelImplCopyWith<_$GreenhouseStateModelImpl>
  get copyWith =>
      __$$GreenhouseStateModelImplCopyWithImpl<_$GreenhouseStateModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GreenhouseStateModelImplToJson(this);
  }
}

abstract class _GreenhouseStateModel extends GreenhouseStateModel {
  const factory _GreenhouseStateModel({final bool manualMode}) =
      _$GreenhouseStateModelImpl;
  const _GreenhouseStateModel._() : super._();

  factory _GreenhouseStateModel.fromJson(Map<String, dynamic> json) =
      _$GreenhouseStateModelImpl.fromJson;

  @override
  bool get manualMode;

  /// Create a copy of GreenhouseStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GreenhouseStateModelImplCopyWith<_$GreenhouseStateModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
