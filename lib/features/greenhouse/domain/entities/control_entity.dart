class ControlEntity {
  final bool manualMode;
  final bool pump;
  final bool fan;
  final bool light;
  final bool resetWater;

  const ControlEntity({
    required this.manualMode,
    required this.pump,
    required this.fan,
    required this.light,
    required this.resetWater,
  });
}
