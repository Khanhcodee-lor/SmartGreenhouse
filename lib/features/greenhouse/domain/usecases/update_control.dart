import '../repositories/greenhouse_repository.dart';

class UpdateControl {
  final GreenhouseRepository repository;

  UpdateControl(this.repository);

  Future<void> call(Map<String, dynamic> data) =>
      repository.updateControl(data);
}
