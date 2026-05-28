import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/sensor_history_entity.dart';

class SensorChartPage extends StatelessWidget {
  final String title;
  final String unit;
  final List<Color> gradientColors;
  final List<SensorHistoryEntity> history;
  final double Function(SensorHistoryEntity) valueSelector;

  const SensorChartPage({
    super.key,
    required this.title,
    required this.unit,
    required this.gradientColors,
    required this.history,
    required this.valueSelector,
  });

  @override
  Widget build(BuildContext context) {
    // Sort history by time
    final sortedHistory = List<SensorHistoryEntity>.from(history)
      ..sort((a, b) => b.savedAtEpoch.compareTo(a.savedAtEpoch)); // Descending for list (newest first)

    final chartHistory = List<SensorHistoryEntity>.from(sortedHistory.reversed); // Ascending for chart

    // Prepare chart data
    final spots = chartHistory.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      return FlSpot(index.toDouble(), valueSelector(data));
    }).toList();

    double minY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    double maxY = spots.isEmpty ? 100 : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    
    // Add some padding to Y axis
    final yPadding = (maxY - minY) * 0.2;
    minY = (minY - yPadding).clamp(0, double.infinity);
    maxY = maxY + yPadding;

    if (minY == maxY) {
      minY -= 10;
      maxY += 10;
    }

    final primaryColor = gradientColors.last;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF2E3A46),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chart Section
          Container(
            margin: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withAlpha(20),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 24),
                  child: Text(
                    'Biểu đồ 100 lần đo gần nhất',
                    style: TextStyle(
                      color: Color(0xFF8E9EAB),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: chartHistory.isEmpty
                      ? const Center(
                          child: Text(
                            'Chưa có dữ liệu lịch sử',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 24, left: 8),
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: (maxY - minY) / 5,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey.withAlpha(30),
                                    strokeWidth: 1,
                                    dashArray: [5, 5],
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 30,
                                    interval: chartHistory.length > 6 ? (chartHistory.length / 5).ceilToDouble() : 1,
                                    getTitlesWidget: (value, meta) {
                                      if (value < 0 || value >= chartHistory.length) {
                                        return const SizedBox.shrink();
                                      }
                                      final time = DateTime.fromMillisecondsSinceEpoch(
                                          chartHistory[value.toInt()].savedAtEpoch * 1000);
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          DateFormat('HH:mm').format(time),
                                          style: const TextStyle(
                                            color: Color(0xFF8E9EAB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: (maxY - minY) / 5,
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          value.toStringAsFixed(1),
                                          style: const TextStyle(
                                            color: Color(0xFF8E9EAB),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      );
                                    },
                                    reservedSize: 42,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              minX: 0,
                              maxX: (chartHistory.length - 1).toDouble(),
                              minY: minY,
                              maxY: maxY,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  gradient: LinearGradient(colors: gradientColors),
                                  barWidth: 4,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: false),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: gradientColors
                                          .map((color) => color.withAlpha(30))
                                          .toList(),
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                              lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                  getTooltipColor: (_) => Colors.blueGrey.shade800,
                                  getTooltipItems: (touchedSpots) {
                                    return touchedSpots.map((spot) {
                                      final time = DateTime.fromMillisecondsSinceEpoch(
                                          chartHistory[spot.x.toInt()].savedAtEpoch * 1000);
                                      final timeStr = DateFormat('HH:mm').format(time);
                                      return LineTooltipItem(
                                        '${spot.y.toStringAsFixed(1)}$unit\n$timeStr',
                                        const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          
          // List Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.history_rounded, color: Color(0xFF8E9EAB), size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Chi tiết lịch sử',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E3A46),
                  ),
                ),
                const Spacer(),
                Text(
                  '${sortedHistory.length} bản ghi',
                  style: const TextStyle(
                    color: Color(0xFF8E9EAB),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // List View
          Expanded(
            child: sortedHistory.isEmpty
                ? const Center(
                    child: Text(
                      'Không có dữ liệu',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
                    itemCount: sortedHistory.length,
                    itemBuilder: (context, index) {
                      final item = sortedHistory[index];
                      final value = valueSelector(item);
                      final time = DateTime.fromMillisecondsSinceEpoch(item.savedAtEpoch * 1000);
                      final timeStr = DateFormat('HH:mm - dd/MM/yyyy').format(time);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(5),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: gradientColors.first,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                timeStr,
                                style: const TextStyle(
                                  color: Color(0xFF8E9EAB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              '${value.toStringAsFixed(1)} $unit',
                              style: TextStyle(
                                color: gradientColors.last,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
