import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/greenhouse_state_entity.dart';

part 'greenhouse_state_model.freezed.dart';
part 'greenhouse_state_model.g.dart';

@freezed
class GreenhouseStateModel with _$GreenhouseStateModel {
  const GreenhouseStateModel._();

  const factory GreenhouseStateModel({
    @Default(false) bool manualMode,
  }) = _GreenhouseStateModel;

  factory GreenhouseStateModel.fromJson(Map<String, dynamic> json) =>
      _$GreenhouseStateModelFromJson(json);

  GreenhouseStateEntity toEntity() => GreenhouseStateEntity(
        manualMode: manualMode,
      );
}
