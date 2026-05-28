import '../entities/greenhouse_entity.dart';
import '../repositories/greenhouse_repository.dart';

class WatchGreenhouse {
  final GreenhouseRepository repository;

  WatchGreenhouse(this.repository);

  Stream<GreenhouseEntity> call() => repository.watchGreenhouse();
}
