import 'package:flutter/material.dart';

class DeviceControlTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isRunning;
  final bool controlValue;
  final bool manualMode;
  final ValueChanged<bool>? onChanged;

  const DeviceControlTile({
    super.key,
    required this.label,
    required this.icon,
    required this.isRunning,
    required this.controlValue,
    required this.manualMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = const Color(0xFF43A047);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8), // ~0.03 opacity
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon with soft background
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isRunning ? activeColor.withAlpha(25) : const Color(0xFFF5F8F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isRunning ? activeColor : const Color(0xFF8E9EAB),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          // Label and Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E3A46),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isRunning ? activeColor : Colors.grey.shade400,
                        boxShadow: isRunning
                            ? [
                                BoxShadow(
                                  color: activeColor.withAlpha(102), // ~0.4
                                  blurRadius: 4,
                                )
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isRunning ? 'Running' : 'Standby',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isRunning ? activeColor : const Color(0xFF8E9EAB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Vertical divider
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade200,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
          // Switch
          Switch(
            value: controlValue,
            onChanged: manualMode ? onChanged : null,
            activeThumbColor: Colors.white,
            activeTrackColor: activeColor,
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
