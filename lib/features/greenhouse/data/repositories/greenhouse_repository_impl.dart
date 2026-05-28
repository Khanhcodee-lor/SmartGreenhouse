import '../../domain/entities/greenhouse_entity.dart';
import '../../domain/repositories/greenhouse_repository.dart';
import '../datasources/greenhouse_remote_datasource.dart';

class GreenhouseRepositoryImpl implements GreenhouseRepository {
  final GreenhouseRemoteDatasource _datasource;

  GreenhouseRepositoryImpl(this._datasource);

  @override
  Stream<GreenhouseEntity> watchGreenhouse() {
    return _datasource.watchGreenhouse().map((model) => model.toEntity());
  }

  @override
  Future<void> updateControl(Map<String, dynamic> data) {
    return _datasource.updateControl(data);
  }
}
