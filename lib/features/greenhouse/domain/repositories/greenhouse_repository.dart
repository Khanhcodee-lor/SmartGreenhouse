import '../entities/greenhouse_entity.dart';

abstract class GreenhouseRepository {
  /// Watches the entire greenhouse data path for realtime updates.
  Stream<GreenhouseEntity> watchGreenhouse();

  /// Updates control values at /smart_greenhouse/control/.
  Future<void> updateControl(Map<String, dynamic> data);
}
