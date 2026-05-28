class SensorHistoryEntity {
  final double temperature;
  final double humidity;
  final double soilMoisture;
  final double lightLevel;
  final double flowRate;
  final double totalLitres;
  final int savedAtEpoch;

  const SensorHistoryEntity({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.lightLevel,
    required this.flowRate,
    required this.totalLitres,
    required this.savedAtEpoch,
  });
}
