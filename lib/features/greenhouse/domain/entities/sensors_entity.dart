class SensorsEntity {
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final double lightLevel;
  final double flowRate;
  final double totalLitres;

  const SensorsEntity({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.lightLevel,
    required this.flowRate,
    required this.totalLitres,
  });
}
