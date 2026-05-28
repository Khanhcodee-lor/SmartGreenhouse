import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../../../greenhouse/data/models/plant_profile.dart';
import '../../../greenhouse/presentation/providers/plant_provider.dart';
import '../../../../app/app.dart';

class PlantSetupPage extends StatefulWidget {
  const PlantSetupPage({super.key});

  @override
  State<PlantSetupPage> createState() => _PlantSetupPageState();
}

class _PlantSetupPageState extends State<PlantSetupPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _plantNameController = TextEditingController();
  final _plantAgeController = TextEditingController();
  final _deviceIdController = TextEditingController();
  final _thresholdController = TextEditingController(text: '60');
  final _stopThresholdController = TextEditingController(text: '65');
  final _tempThresholdController = TextEditingController(text: '40');
  final _humidityThresholdController = TextEditingController(text: '30');

  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  String _selectedDeviceId = 'smart_greenhouse';
  bool _useCustomDevice = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _plantNameController.dispose();
    _plantAgeController.dispose();
    _deviceIdController.dispose();
    _thresholdController.dispose();
    _stopThresholdController.dispose();
    _tempThresholdController.dispose();
    _humidityThresholdController.dispose();
    super.dispose();
  }

  // ─── Navigation ─────────────────────────────────────────

  void _navigateToGreenhouse() {
    if (!_formKey.currentState!.validate() || _isNavigating) return;

    final deviceId = _useCustomDevice
        ? _deviceIdController.text.trim()
        : _selectedDeviceId;

    if (deviceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng nhập Device ID'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _isNavigating = true);

    final plantName = _plantNameController.text.trim();
    final plantAge = int.tryParse(_plantAgeController.text.trim()) ?? 0;
    final moistureThreshold = int.tryParse(_thresholdController.text.trim()) ?? 60;
    final moistureStopThreshold = int.tryParse(_stopThresholdController.text.trim()) ?? 65;
    final tempThreshold = int.tryParse(_tempThresholdController.text.trim()) ?? 40;
    final humidityThreshold = int.tryParse(_humidityThresholdController.text.trim()) ?? 30;

    final plantProvider = context.read<PlantProvider>();
    final newProfile = PlantProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: plantName,
      age: plantAge,
      deviceId: deviceId,
      moistureThreshold: moistureThreshold,
      moistureStopThreshold: moistureStopThreshold,
      tempThreshold: tempThreshold,
      humidityThreshold: humidityThreshold,
    );

    plantProvider.addOrUpdatePlant(newProfile).then((_) {
      plantProvider.setActivePlant(newProfile.id).then((_) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) => 
                const GreenhousePageWrapper(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      });
    }).whenComplete(() {
      if (mounted) setState(() => _isNavigating = false);
    });
  }

  // ─── Build ──────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      body: SlideTransition(
        position: _slideUp,
        child: FadeTransition(
          opacity: _fadeIn,
          child: CustomScrollView(
            slivers: [
              _buildHeader(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 28),
                        // ── Plant Info Section ──
                        _buildSectionTitle(
                          'Thông tin cây trồng',
                          Icons.eco_rounded,
                        ),
                        const SizedBox(height: 14),
                        _buildPlantNameField(),
                        const SizedBox(height: 14),
                        _buildPlantAgeField(),

                        const SizedBox(height: 32),
                        
                        // ── Thresholds Section ──
                        _buildSectionTitle(
                          'Cấu hình ngưỡng tự động',
                          Icons.tune_rounded,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: _buildNumberField(_thresholdController, 'Tưới khi ẩm <', Icons.water_drop_rounded, Colors.blue)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildNumberField(_stopThresholdController, 'Tắt bơm khi ẩm >', Icons.water_drop_outlined, Colors.blueAccent)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(child: _buildNumberField(_tempThresholdController, 'Báo nóng >', Icons.thermostat_rounded, Colors.orange)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildNumberField(_humidityThresholdController, 'Báo khô <', Icons.air_rounded, Colors.lightBlue)),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // ── Device Selection Section ──
                        _buildSectionTitle(
                          'Chọn thiết bị ESP32',
                          Icons.developer_board_rounded,
                        ),
                        const SizedBox(height: 14),
                        _buildDeviceOption(
                          id: 'smart_greenhouse',
                          title: 'Smart Greenhouse',
                          subtitle: 'smart_greenhouse',
                          icon: Icons.sensors_rounded,
                          selected:
                              !_useCustomDevice &&
                              _selectedDeviceId == 'smart_greenhouse',
                          onTap: () => setState(() {
                            _selectedDeviceId = 'smart_greenhouse';
                            _useCustomDevice = false;
                          }),
                        ),
                        const SizedBox(height: 10),
                        _buildDeviceOption(
                          id: 'custom',
                          title: 'Thiết bị khác',
                          subtitle: 'Nhập Device ID thủ công',
                          icon: Icons.edit_rounded,
                          selected: _useCustomDevice,
                          onTap: () => setState(() {
                            _useCustomDevice = true;
                          }),
                        ),
                        if (_useCustomDevice) ...[
                          const SizedBox(height: 14),
                          _buildCustomDeviceField(),
                        ],

                        const SizedBox(height: 40),
                        _buildStartButton(),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ─────────────────────────────────────────────

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: const Color(0xFFF5F8F5),
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        title: const Text(
          'Thiết lập cây trồng',
          style: TextStyle(
            color: Color(0xFF2E3A46),
            fontSize: 18,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB9E4C9), Color(0xFFF5F8F5)],
                ),
              ),
            ),
            // Decorative orbs
            Positioned(
              top: -40,
              right: -30,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(120),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 60,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(90),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(70),
                ),
              ),
            ),
            // Center icon
            Positioned(
              top: 52,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E7D32).withAlpha(30),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withAlpha(200),
                      width: 2.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.spa_rounded,
                    color: Color(0xFF43A047),
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Section Title ──────────────────────────────────────

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF43A047), size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2E3A46),
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  // ─── Plant Name Field ───────────────────────────────────

  Widget _buildPlantNameField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43A047).withAlpha(14),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _plantNameController,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          labelText: 'Tên cây',
          hintText: 'Ví dụ: Cây cà chua, Hoa hồng...',
          hintStyle: TextStyle(
            color: const Color(0xFF8E9EAB).withAlpha(180),
            fontSize: 14,
          ),
          labelStyle: const TextStyle(color: Color(0xFF5F6D7A)),
          prefixIcon: const Icon(
            Icons.local_florist_rounded,
            color: Color(0xFF43A047),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF43A047),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Vui lòng nhập tên cây';
          }
          return null;
        },
      ),
    );
  }

  // ─── Plant Age Field ────────────────────────────────────

  Widget _buildPlantAgeField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43A047).withAlpha(14),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: _plantAgeController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: 'Tuổi cây',
          hintText: 'Ví dụ: 3',
          hintStyle: TextStyle(
            color: const Color(0xFF8E9EAB).withAlpha(180),
            fontSize: 14,
          ),
          labelStyle: const TextStyle(color: Color(0xFF5F6D7A)),
          prefixIcon: const Icon(
            Icons.calendar_month_rounded,
            color: Color(0xFF43A047),
          ),
          suffixText: 'tháng',
          suffixStyle: const TextStyle(
            color: Color(0xFF5F6D7A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF43A047),
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Vui lòng nhập tuổi cây';
          }
          final age = int.tryParse(value.trim());
          if (age == null || age <= 0) {
            return 'Tuổi cây phải là số dương';
          }
          return null;
        },
      ),
    );
  }

  // ─── Number Field Helper ────────────────────────────────

  Widget _buildNumberField(TextEditingController controller, String label, IconData icon, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF43A047).withAlpha(14),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Ví dụ: 60',
          hintStyle: TextStyle(
            color: const Color(0xFF8E9EAB).withAlpha(180),
            fontSize: 14,
          ),
          labelStyle: const TextStyle(color: Color(0xFF5F6D7A), fontSize: 13),
          prefixIcon: Icon(icon, color: iconColor, size: 20),
          suffixText: '%',
          suffixStyle: const TextStyle(
            color: Color(0xFF5F6D7A),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF43A047), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Bắt buộc';
          final num = int.tryParse(value.trim());
          if (num == null || num <= 0 || num >= 100) return '1-99';
          
          if (label == 'Tắt bơm khi ẩm >') {
            final startNum = int.tryParse(_thresholdController.text.trim());
            if (startNum != null && num <= startNum) return '> Mức tưới';
          }
          return null;
        },
      ),
    );
  }

  // ─── Device Option Card ─────────────────────────────────

  Widget _buildDeviceOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: selected ? const Color(0xFF43A047) : const Color(0xFFE0E5E0),
          width: selected ? 1.8 : 1,
        ),
        boxShadow: [
          if (selected)
            BoxShadow(
              color: const Color(0xFF43A047).withAlpha(20),
              blurRadius: 14,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF43A047).withAlpha(25)
                        : const Color(0xFFF0F4F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: selected
                        ? const Color(0xFF43A047)
                        : const Color(0xFF8E9EAB),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFF2E3A46)
                              : const Color(0xFF5F6D7A),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: selected
                              ? const Color(0xFF43A047)
                              : const Color(0xFF8E9EAB),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: selected
                      ? Container(
                          key: const ValueKey('selected'),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF43A047),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        )
                      : Container(
                          key: const ValueKey('unselected'),
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD0D5D0),
                              width: 1.5,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Custom Device ID Field ─────────────────────────────

  Widget _buildCustomDeviceField() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF43A047).withAlpha(14),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextFormField(
          controller: _deviceIdController,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[.#$\[\]]')),
          ],
          decoration: InputDecoration(
            labelText: 'Device ID',
            hintText: 'Ví dụ: smart_greenhouse_2',
            hintStyle: TextStyle(
              color: const Color(0xFF8E9EAB).withAlpha(180),
              fontSize: 14,
            ),
            labelStyle: const TextStyle(color: Color(0xFF5F6D7A)),
            prefixIcon: const Icon(
              Icons.link_rounded,
              color: Color(0xFF43A047),
            ),
            helperText: 'Không được chứa ký tự . # \$ [ ]',
            helperStyle: TextStyle(
              color: const Color(0xFF8E9EAB).withAlpha(160),
              fontSize: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF43A047),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.red.shade300, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
          validator: (value) {
            if (_useCustomDevice &&
                (value == null || value.trim().isEmpty)) {
              return 'Vui lòng nhập Device ID';
            }
            if (value != null && RegExp(r'[.#$\[\]]').hasMatch(value)) {
              return 'Device ID không được chứa . # \$ [ ]';
            }
            return null;
          },
        ),
      ),
    );
  }

  // ─── Start Button ───────────────────────────────────────

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF43A047).withAlpha(60),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _isNavigating ? null : _navigateToGreenhouse,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: _isNavigating
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow_rounded, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Bắt đầu điều khiển',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
