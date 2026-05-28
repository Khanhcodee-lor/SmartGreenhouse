import 'package:shared_preferences/shared_preferences.dart';
import '../../features/greenhouse/data/models/plant_profile.dart';

class PlantStorageService {
  static const String _plantsKey = 'saved_plants';
  static const String _activePlantIdKey = 'active_plant_id';

  final SharedPreferences _prefs;

  PlantStorageService(this._prefs);

  static Future<PlantStorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PlantStorageService(prefs);
  }

  Future<List<PlantProfile>> getPlants() async {
    final List<String>? plantsJson = _prefs.getStringList(_plantsKey);
    if (plantsJson == null) return [];
    
    return plantsJson.map((json) => PlantProfile.fromJson(json)).toList();
  }

  Future<void> savePlant(PlantProfile plant) async {
    final plants = await getPlants();
    final index = plants.indexWhere((p) => p.id == plant.id);
    
    if (index >= 0) {
      plants[index] = plant;
    } else {
      plants.add(plant);
    }
    
    final plantsJson = plants.map((p) => p.toJson()).toList();
    await _prefs.setStringList(_plantsKey, plantsJson);
  }

  Future<void> deletePlant(String id) async {
    final plants = await getPlants();
    plants.removeWhere((p) => p.id == id);
    
    final plantsJson = plants.map((p) => p.toJson()).toList();
    await _prefs.setStringList(_plantsKey, plantsJson);
    
    // Nếu xóa đúng cây đang active thì reset
    final activeId = getActivePlantId();
    if (activeId == id) {
      await _prefs.remove(_activePlantIdKey);
    }
  }

  String? getActivePlantId() {
    return _prefs.getString(_activePlantIdKey);
  }

  Future<void> setActivePlantId(String id) async {
    await _prefs.setString(_activePlantIdKey, id);
  }
}
