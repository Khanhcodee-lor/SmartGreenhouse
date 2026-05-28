import 'package:firebase_database/firebase_database.dart';
import '../../../../core/utils/map_converter.dart';
import '../models/greenhouse_model.dart';

class GreenhouseRemoteDatasource {
  final FirebaseDatabase _database;
  final String deviceId;

  GreenhouseRemoteDatasource(this._database, {this.deviceId = 'smart_greenhouse'});

  /// Listens to the entire /smart_greenhouse path for realtime changes.
  Stream<GreenhouseModel> watchGreenhouse() {
    return _database.ref(deviceId).onValue.map((event) {
      if (event.snapshot.value == null) {
        return const GreenhouseModel();
      }
      final raw = event.snapshot.value as Map<Object?, Object?>;
      final data = convertFirebaseMap(raw);
      
      // Firebase treats sequential numerical keys (0, 1, 2...) as Arrays/Lists.
      // Since history is keyed by hour (0..23), it might come back as a List.
      // We must convert it back to a Map for json_serializable.
      if (data['history'] is List) {
        final List historyList = data['history'] as List;
        final Map<String, dynamic> historyMap = {};
        for (int i = 0; i < historyList.length; i++) {
          if (historyList[i] != null) {
            historyMap[i.toString()] = historyList[i];
          }
        }
        data['history'] = historyMap;
      }
      
      return GreenhouseModel.fromJson(data);
    });
  }

  /// Updates specific control fields at /smart_greenhouse/control/.
  Future<void> updateControl(Map<String, dynamic> data) {
    return _database.ref('$deviceId/control').update(data);
  }
}
