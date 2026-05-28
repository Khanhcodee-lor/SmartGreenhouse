import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/device_entity.dart';

part 'device_model.freezed.dart';
part 'device_model.g.dart';

@freezed
class DeviceModel with _$DeviceModel {
  const DeviceModel._();

  const factory DeviceModel({
    @Default(false) bool online,
  }) = _DeviceModel;

  factory DeviceModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceModelFromJson(json);

  DeviceEntity toEntity() => DeviceEntity(
        online: online,
      );
}
