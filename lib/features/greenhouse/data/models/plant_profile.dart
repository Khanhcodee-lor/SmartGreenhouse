import 'dart:convert';

class PlantProfile {
  final String id;
  final String name;
  final int age;
  final String deviceId;
  final int moistureThreshold;

  PlantProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.deviceId,
    required this.moistureThreshold,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'deviceId': deviceId,
      'moistureThreshold': moistureThreshold,
    };
  }

  factory PlantProfile.fromMap(Map<String, dynamic> map) {
    return PlantProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      deviceId: map['deviceId'] ?? 'smart_greenhouse',
      moistureThreshold: map['moistureThreshold']?.toInt() ?? 60,
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
  }) {
    return PlantProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      deviceId: deviceId ?? this.deviceId,
      moistureThreshold: moistureThreshold ?? this.moistureThreshold,
    );
  }
}
