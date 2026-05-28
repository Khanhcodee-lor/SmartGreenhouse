import 'package:flutter/material.dart';

class MasterControlCard extends StatelessWidget {
  final bool manualMode;
  final ValueChanged<bool> onChanged;

  const MasterControlCard({
    super.key,
    required this.manualMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: manualMode
            ? const LinearGradient(
                colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: manualMode
                ? const Color(0xFFFF9800).withAlpha(38)
                : Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: manualMode ? const Color(0xFFFFB74D) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: manualMode ? Colors.white.withAlpha(153) : const Color(0xFFF5F8F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.tune_rounded,
              color: manualMode ? const Color(0xFFF57C00) : const Color(0xFF8E9EAB),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Manual Control',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: manualMode ? const Color(0xFFE65100) : const Color(0xFF2E3A46),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  manualMode ? 'You have full control' : 'System running on auto',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: manualMode ? const Color(0xFFF57C00) : const Color(0xFF8E9EAB),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: manualMode,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFFF57C00),
            inactiveThumbColor: Colors.grey.shade400,
            inactiveTrackColor: Colors.grey.shade200,
          ),
        ],
      ),
    );
  }
}
