import 'device_entity.dart';
import 'greenhouse_state_entity.dart';
import 'control_entity.dart';
import 'actuators_entity.dart';
import 'sensors_entity.dart';
import 'sensor_history_entity.dart';

class GreenhouseEntity {
  final DeviceEntity device;
  final GreenhouseStateEntity state;
  final ControlEntity control;
  final ActuatorsEntity actuators;
  final SensorsEntity sensors;
  final Map<String, SensorHistoryEntity> history;

  const GreenhouseEntity({
    required this.device,
    required this.state,
    required this.control,
    required this.actuators,
    required this.sensors,
    this.history = const {},
  });
}
