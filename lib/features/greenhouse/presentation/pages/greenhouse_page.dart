import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/brand_splash.dart';

import '../../domain/entities/greenhouse_entity.dart';
import '../../domain/entities/sensor_history_entity.dart';
import '../providers/greenhouse_provider.dart';
import '../widgets/sensor_card.dart';
import '../widgets/device_control_tile.dart';
import '../widgets/master_control_card.dart';
import 'sensor_chart_page.dart';
import 'notification_page.dart';
import 'plant_profiles_page.dart';
import '../providers/notification_provider.dart';
import '../providers/plant_provider.dart';

class GreenhousePage extends StatelessWidget {
  const GreenhousePage({
    super.key,
    this.plantName,
    this.plantAge,
  });

  final String? plantName;
  final int? plantAge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      body: Consumer<GreenhouseProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const BrandSplash();
          }

          if (provider.error != null && !provider.hasData) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_off_rounded,
                      size: 64,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Connection Error',
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      provider.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF8E9EAB),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => provider.startWatching(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF43A047),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!provider.hasData) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco_outlined, size: 64, color: Color(0xFFC8E6C9)),
                  SizedBox(height: 16),
                  Text(
                    'No greenhouse data',
                    style: TextStyle(color: Color(0xFF8E9EAB), fontSize: 16),
                  ),
                ],
              ),
            );
          }

          final gh = provider.greenhouse!;

          return CustomScrollView(
            slivers: [
              // ─── App Bar ───
              _buildAppBar(context, gh.device.online, gh.state.manualMode),

              // ─── Error Banner ───
              if (provider.error != null)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red.shade400,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            provider.error!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // ─── Sensors Section ───
              _buildSectionHeader('Sensors'),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildListDelegate(
                    _buildSensorCards(context, gh),
                  ),
                ),
              ),

              // ─── Device Management Section ───
              _buildSectionHeader('Device Management'),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Master Switch
                    MasterControlCard(
                      manualMode: gh.control.manualMode,
                      onChanged: (val) => provider.toggleManualMode(val),
                    ),
                    // Pump
                    DeviceControlTile(
                      label: 'Water Pump',
                      icon: Icons.water_drop_rounded,
                      isRunning: gh.actuators.pump,
                      controlValue: gh.control.pump,
                      manualMode: gh.control.manualMode,
                      onChanged: (val) => provider.togglePump(val),
                    ),
                    // Fan
                    DeviceControlTile(
                      label: 'Ventilation Fan',
                      icon: Icons.air_rounded,
                      isRunning: gh.actuators.fan,
                      controlValue: gh.control.fan,
                      manualMode: gh.control.manualMode,
                      onChanged: (val) => provider.toggleFan(val),
                    ),
                    // Light
                    DeviceControlTile(
                      label: 'Grow Light',
                      icon: Icons.lightbulb_rounded,
                      isRunning: gh.actuators.light,
                      controlValue: gh.control.light,
                      manualMode: gh.control.manualMode,
                      onChanged: (val) => provider.toggleLight(val),
                    ),
                  ]),
                ),
              ),

              // ─── Reset Water Button ───
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton.icon(
                      onPressed: () => _showResetDialog(context, provider),
                      icon: const Icon(Icons.restart_alt_rounded, size: 20),
                      label: const Text(
                        'Reset Water Counter',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFEF5350),
                        backgroundColor: Colors.red.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── App Bar ─────────────────────────────────────────────

  SliverAppBar _buildAppBar(
    BuildContext context,
    bool online,
    bool manualMode,
  ) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: const Color(0xFFF5F8F5),
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF43A047).withAlpha(25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.eco_rounded,
                color: Color(0xFF43A047),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    plantName != null && plantName!.isNotEmpty
                        ? plantName!
                        : 'Smart Greenhouse',
                    style: const TextStyle(
                      color: Color(0xFF2E3A46),
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (plantAge != null && plantAge! > 0)
                    Text(
                      '$plantAge tháng tuổi',
                      style: const TextStyle(
                        color: Color(0xFF8E9EAB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  Consumer<PlantProvider>(
                    builder: (context, plantProvider, _) {
                      final active = plantProvider.activePlant;
                      if (active != null) {
                        return Text(
                          'Ngưỡng tưới: ${active.moistureThreshold}%',
                          style: const TextStyle(
                            color: Color(0xFF43A047),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Base gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFC8E6C9), // Slightly more pronounced light green
                    Color(0xFFF5F8F5), // Fades into scaffold background
                  ],
                ),
              ),
            ),
            // Decorative shapes
            Positioned(
              top: -30,
              right: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(153), // ~0.6 opacity
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 80,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(102), // ~0.4 opacity
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(77), // ~0.3 opacity
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.energy_savings_leaf_outlined),
          color: const Color(0xFF2E3A46),
          onPressed: () {
            final plantProvider = context.read<PlantProvider>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                  value: plantProvider,
                  child: const PlantProfilesPage(),
                ),
              ),
            );
          },
        ),
        // Notification Bell Icon with Badge
        Consumer<NotificationProvider>(
          builder: (context, notifProvider, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  color: const Color(0xFF2E3A46),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationPage(),
                      ),
                    );
                  },
                ),
                if (notifProvider.unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        notifProvider.unreadCount > 9
                            ? '9+'
                            : notifProvider.unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        
        // Manual mode badge
        if (manualMode)
          Container(
            margin: const EdgeInsets.only(right: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0), // light orange
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.tune_rounded, color: Color(0xFFEF6C00), size: 14),
                SizedBox(width: 4),
                Text(
                  'Manual',
                  style: TextStyle(
                    color: Color(0xFFEF6C00),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        // Online status indicator
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: online ? const Color(0xFFE8F5E9) : Colors.red.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: online ? const Color(0xFF43A047) : Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: online
                          ? const Color(0xFF43A047).withAlpha(102)
                          : Colors.red.withAlpha(102),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Text(
                online ? 'Online' : 'Offline',
                style: TextStyle(
                  color: online ? const Color(0xFF43A047) : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Section Header ──────────────────────────────────────

  SliverToBoxAdapter _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xFF43A047),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF2E3A46),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToChartPage(
      BuildContext context,
      String title,
      String unit,
      List<Color> gradientColors,
      Map<String, SensorHistoryEntity> historyMap,
      double Function(SensorHistoryEntity) valueSelector) {
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SensorChartPage(
          title: title,
          unit: unit,
          gradientColors: gradientColors,
          history: historyMap.values.toList(),
          valueSelector: valueSelector,
        ),
      ),
    );
  }

  // ─── Sensor Cards ────────────────────────────────────────

  List<Widget> _buildSensorCards(BuildContext context, GreenhouseEntity gh) {
    final sensors = gh.sensors;
    final history = gh.history;
    
    return [
      SensorCard(
        icon: Icons.thermostat_rounded,
        label: 'Temperature',
        value: sensors.temperature.toStringAsFixed(1),
        unit: '°C',
        gradientColors: const [
          Color(0xFFFFB74D),
          Color(0xFFEF5350),
        ], // Orange to Red
        progress: (sensors.temperature / 50.0).clamp(0.0, 1.0),
        onTap: () => _navigateToChartPage(
          context,
          'Nhiệt độ',
          '°C',
          const [Color(0xFFFFB74D), Color(0xFFEF5350)],
          history,
          (h) => h.temperature,
        ),
      ),
      SensorCard(
        icon: Icons.water_drop_rounded,
        label: 'Humidity',
        value: sensors.humidity.toStringAsFixed(1),
        unit: '%',
        gradientColors: const [
          Color(0xFF81D4FA),
          Color(0xFF42A5F5),
        ], // Light blue to Blue
        progress: (sensors.humidity / 100.0).clamp(0.0, 1.0),
        onTap: () => _navigateToChartPage(
          context,
          'Độ ẩm',
          '%',
          const [Color(0xFF81D4FA), Color(0xFF42A5F5)],
          history,
          (h) => h.humidity,
        ),
      ),
      SensorCard(
        icon: Icons.grass_rounded,
        label: 'Soil Moisture',
        value: sensors.soilMoisture.toStringAsFixed(0),
        unit: '%',
        gradientColors: const [
          Color(0xFFA5D6A7),
          Color(0xFF66BB6A),
        ], // Light green to Green
        progress: (sensors.soilMoisture / 100.0).clamp(0.0, 1.0),
        onTap: () => _navigateToChartPage(
          context,
          'Độ ẩm đất',
          '%',
          const [Color(0xFFA5D6A7), Color(0xFF66BB6A)],
          history,
          (h) => h.soilMoisture,
        ),
      ),
      SensorCard(
        icon: Icons.wb_sunny_rounded,
        label: 'Light Level',
        value: sensors.lightLevel.toStringAsFixed(0),
        unit: '%',
        gradientColors: const [
          Color(0xFFFFE082),
          Color(0xFFFFA726),
        ], // Yellow to Orange
        progress: (sensors.lightLevel / 100.0).clamp(0.0, 1.0),
        onTap: () => _navigateToChartPage(
          context,
          'Ánh sáng',
          '%',
          const [Color(0xFFFFE082), Color(0xFFFFA726)],
          history,
          (h) => h.lightLevel,
        ),
      ),
      SensorCard(
        icon: Icons.speed_rounded,
        label: 'Flow Rate',
        value: sensors.flowRate.toStringAsFixed(2),
        unit: ' L/min',
        gradientColors: const [Color(0xFF80DEEA), Color(0xFF26C6DA)], // Cyan
        progress: (sensors.flowRate / 5.0).clamp(
          0.0,
          1.0,
        ), // Assume max 5 L/min
        onTap: () => _navigateToChartPage(
          context,
          'Lưu lượng nước',
          'L/min',
          const [Color(0xFF80DEEA), Color(0xFF26C6DA)],
          history,
          (h) => h.flowRate,
        ),
      ),
      SensorCard(
        icon: Icons.data_usage_rounded,
        label: 'Total Water',
        value: sensors.totalLitres.toStringAsFixed(3),
        unit: ' L',
        gradientColors: const [Color(0xFFCE93D8), Color(0xFF7E57C2)], // Purple
        progress: 1.0, // Always full for total
        onTap: () => _navigateToChartPage(
          context,
          'Tổng nước tiêu thụ',
          'L',
          const [Color(0xFFCE93D8), Color(0xFF7E57C2)],
          history,
          (h) => h.totalLitres,
        ),
      ),
    ];
  }

  // ─── Reset Dialog ────────────────────────────────────────

  void _showResetDialog(BuildContext context, GreenhouseProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Reset Water Counter',
          style: TextStyle(
            color: Color(0xFF2E3A46),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          'Are you sure you want to reset the water counter? This action cannot be undone.',
          style: TextStyle(color: Color(0xFF5F6D7A), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF8E9EAB)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.resetWater();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43A047),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
