import 'package:flutter/foundation.dart';
import '../../../../core/services/plant_storage_service.dart';
import '../../domain/usecases/update_control.dart';
import '../../data/models/plant_profile.dart';

class PlantProvider extends ChangeNotifier {
  final PlantStorageService _storageService;
  final UpdateControl _updateControl;

  List<PlantProfile> _plants = [];
  String? _activePlantId;
  bool _isLoading = true;

  PlantProvider({
    required PlantStorageService storageService,
    required UpdateControl updateControl,
  })  : _storageService = storageService,
        _updateControl = updateControl {
    _init();
  }

  List<PlantProfile> get plants => _plants;
  String? get activePlantId => _activePlantId;
  bool get isLoading => _isLoading;

  PlantProfile? get activePlant {
    if (_activePlantId == null) return null;
    try {
      return _plants.firstWhere((p) => p.id == _activePlantId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _init() async {
    _plants = await _storageService.getPlants();
    _activePlantId = _storageService.getActivePlantId();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addOrUpdatePlant(PlantProfile plant) async {
    await _storageService.savePlant(plant);
    _plants = await _storageService.getPlants();
    
    // Nếu cây vừa sửa đang là active, cập nhật lại Firebase
    if (_activePlantId == plant.id) {
      await _syncThresholdToFirebase(plant);
    }
    
    notifyListeners();
  }

  Future<void> deletePlant(String id) async {
    await _storageService.deletePlant(id);
    _plants = await _storageService.getPlants();
    
    if (_activePlantId == id) {
      _activePlantId = null;
    }
    
    notifyListeners();
  }

  Future<void> setActivePlant(String id) async {
    final plant = _plants.firstWhere((p) => p.id == id);
    
    await _storageService.setActivePlantId(id);
    _activePlantId = id;
    
    await _syncThresholdToFirebase(plant);
    notifyListeners();
  }

  Future<void> _syncThresholdToFirebase(PlantProfile plant) async {
    try {
      await _updateControl({
        'soilThreshold': plant.moistureThreshold,
        'tempThreshold': plant.tempThreshold,
        'humidityThreshold': plant.humidityThreshold,
      });
    } catch (e) {
      debugPrint('Failed to sync threshold: $e');
    }
  }
}
