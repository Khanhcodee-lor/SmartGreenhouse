import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/actuators_entity.dart';

part 'actuators_model.freezed.dart';
part 'actuators_model.g.dart';

@freezed
class ActuatorsModel with _$ActuatorsModel {
  const ActuatorsModel._();

  const factory ActuatorsModel({
    @Default(false) bool pump,
    @Default(false) bool fan,
    @Default(false) bool light,
  }) = _ActuatorsModel;

  factory ActuatorsModel.fromJson(Map<String, dynamic> json) =>
      _$ActuatorsModelFromJson(json);

  ActuatorsEntity toEntity() => ActuatorsEntity(
        pump: pump,
        fan: fan,
        light: light,
      );
}
