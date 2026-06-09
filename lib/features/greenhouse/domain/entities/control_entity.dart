class ControlEntity {
  final bool manualMode;
  final bool pump;
  final bool fan;
  final bool light;
  final bool resetWater;
  final int soilThreshold;
  final int tempThreshold;
  final int humidityThreshold;

  const ControlEntity({
    required this.manualMode,
    required this.pump,
    required this.fan,
    required this.light,
    required this.resetWater,
    required this.soilThreshold,
    required this.tempThreshold,
    required this.humidityThreshold,
  });
}
