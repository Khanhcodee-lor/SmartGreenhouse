import 'dart:convert';

class PlantProfile {
  final String id;
  final String name;
  final int age;
  final String deviceId;
  final int moistureThreshold;
  final int tempThreshold;
  final int humidityThreshold;

  PlantProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.deviceId,
    required this.moistureThreshold,
    this.tempThreshold = 40,
    this.humidityThreshold = 30,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'deviceId': deviceId,
      'moistureThreshold': moistureThreshold,
      'tempThreshold': tempThreshold,
      'humidityThreshold': humidityThreshold,
    };
  }

  factory PlantProfile.fromMap(Map<String, dynamic> map) {
    return PlantProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      deviceId: map['deviceId'] ?? 'smart_greenhouse',
      moistureThreshold: map['moistureThreshold']?.toInt() ?? 60,
      tempThreshold: map['tempThreshold']?.toInt() ?? 40,
      humidityThreshold: map['humidityThreshold']?.toInt() ?? 30,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlantProfile.fromJson(String source) => PlantProfile.fromMap(json.decode(source));

  PlantProfile copyWith({
    String? id,
    String? name,
    int? age,
    String? deviceId,
    int? moistureThreshold,
    int? tempThreshold,
    int? humidityThreshold,
  }) {
    return PlantProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      deviceId: deviceId ?? this.deviceId,
      moistureThreshold: moistureThreshold ?? this.moistureThreshold,
      tempThreshold: tempThreshold ?? this.tempThreshold,
      humidityThreshold: humidityThreshold ?? this.humidityThreshold,
    );
  }
}
