import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/plant_provider.dart';
import '../../data/models/plant_profile.dart';

class PlantProfilesPage extends StatefulWidget {
  const PlantProfilesPage({super.key});

  @override
  State<PlantProfilesPage> createState() => _PlantProfilesPageState();
}

class _PlantProfilesPageState extends State<PlantProfilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      appBar: AppBar(
        title: const Text('Quản lý cây & Ngưỡng tưới'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<PlantProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF43A047)),
            );
          }

          if (provider.plants.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            itemCount: provider.plants.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final plant = provider.plants[index];
              final isActive = plant.id == provider.activePlantId;
              return _buildPlantCard(context, plant, isActive, provider);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPlantDialog(context),
        backgroundColor: const Color(0xFF43A047),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Thêm cây mới',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.eco_outlined,
              size: 64,
              color: Color(0xFFC8E6C9),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Chưa có hồ sơ cây nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2E3A46),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Bấm "Thêm cây mới" để tạo ngưỡng tưới.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8E9EAB),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantCard(
    BuildContext context,
    PlantProfile plant,
    bool isActive,
    PlantProvider provider,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? const Color(0xFF43A047) : Colors.transparent,
          width: isActive ? 2 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: isActive 
                ? const Color(0xFF43A047).withAlpha(30)
                : Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFFE8F5E9) : const Color(0xFFF0F4F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_florist_rounded,
                  color: isActive ? const Color(0xFF43A047) : const Color(0xFF8E9EAB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  plant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E3A46),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF43A047),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ĐANG ÁP DỤNG',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined, size: 16, color: Color(0xFF5F6D7A)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Tuổi: ${plant.age} tháng',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF5F6D7A)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.developer_board_outlined, size: 16, color: Color(0xFF5F6D7A)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Device ID: ${plant.deviceId}',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF5F6D7A)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.water_drop_outlined, size: 16, color: Colors.blue),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Ngưỡng tưới: < ${plant.moistureThreshold}%',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F6D7A),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.thermostat_outlined, size: 16, color: Colors.orange),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Ngưỡng báo nóng: > ${plant.tempThreshold}°C',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F6D7A),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.air_outlined, size: 16, color: Colors.lightBlueAccent),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Ngưỡng báo khô: < ${plant.humidityThreshold}%',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5F6D7A),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isActive)
                ElevatedButton(
                  onPressed: () => provider.setActivePlant(plant.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8F5E9),
                    foregroundColor: const Color(0xFF2E7D32),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: const Size(80, 36),
                  ),
                  child: const Text('ÁP DỤNG'),
                ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Color(0xFF43A047)),
                onPressed: () => _showPlantDialog(context, plant),
                tooltip: 'Sửa',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                onPressed: () => _showDeleteConfirmDialog(context, plant, provider),
                tooltip: 'Xóa',
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPlantDialog(BuildContext context, [PlantProfile? existingPlant]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: _PlantFormBottomSheet(existingPlant: existingPlant),
      ),
    );
  }

  void _showDeleteConfirmDialog(BuildContext context, PlantProfile plant, PlantProvider provider) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xóa hồ sơ?'),
        content: Text('Bạn có chắc muốn xóa hồ sơ "${plant.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Color(0xFF8E9EAB))),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deletePlant(plant.id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
  }
}

class _PlantFormBottomSheet extends StatefulWidget {
  final PlantProfile? existingPlant;

  const _PlantFormBottomSheet({this.existingPlant});

  @override
  State<_PlantFormBottomSheet> createState() => _PlantFormBottomSheetState();
}

class _PlantFormBottomSheetState extends State<_PlantFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _thresholdController;
  late TextEditingController _tempThresholdController;
  late TextEditingController _humidityThresholdController;
  late TextEditingController _customDeviceIdController;

  bool _isCustomDevice = false;
  String _selectedDeviceId = 'smart_greenhouse';

  @override
  void initState() {
    super.initState();
    final p = widget.existingPlant;
    _nameController = TextEditingController(text: p?.name ?? '');
    _ageController = TextEditingController(text: p != null ? p.age.toString() : '');
    _thresholdController = TextEditingController(text: p != null ? p.moistureThreshold.toString() : '60');
    _tempThresholdController = TextEditingController(text: p != null ? p.tempThreshold.toString() : '40');
    _humidityThresholdController = TextEditingController(text: p != null ? p.humidityThreshold.toString() : '30');
    
    String initialDevice = p?.deviceId ?? 'smart_greenhouse';
    if (initialDevice != 'smart_greenhouse') {
      _isCustomDevice = true;
      _selectedDeviceId = 'custom';
      _customDeviceIdController = TextEditingController(text: initialDevice);
    } else {
      _isCustomDevice = false;
      _selectedDeviceId = 'smart_greenhouse';
      _customDeviceIdController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _thresholdController.dispose();
    _tempThresholdController.dispose();
    _humidityThresholdController.dispose();
    _customDeviceIdController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final deviceId = _isCustomDevice ? _customDeviceIdController.text.trim() : _selectedDeviceId;
    if (deviceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: const Text('Vui lòng chọn hoặc nhập Device ID'), backgroundColor: Colors.red.shade400),
      );
      return;
    }

    final newPlant = PlantProfile(
      id: widget.existingPlant?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      deviceId: deviceId,
      moistureThreshold: int.parse(_thresholdController.text.trim()),
      tempThreshold: int.parse(_tempThresholdController.text.trim()),
      humidityThreshold: int.parse(_humidityThresholdController.text.trim()),
    );

    context.read<PlantProvider>().addOrUpdatePlant(newPlant);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                widget.existingPlant != null ? 'Sửa thông tin cây' : 'Thêm cây mới',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E3A46)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Tên cây (VD: Cà chua)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.local_florist_rounded),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Tuổi (tháng)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.calendar_month_rounded),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Bắt buộc';
                        if (int.tryParse(val) == null) return 'Sai định dạng';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _thresholdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Tưới khi ẩm <',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.water_drop_rounded),
                        suffixText: '%',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Bắt buộc';
                        final num = int.tryParse(val.trim());
                        if (num == null || num <= 0 || num >= 100) return '1-99';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tempThresholdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Báo nóng >',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.thermostat_rounded, color: Colors.orange),
                        suffixText: '°C',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Bắt buộc';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _humidityThresholdController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Báo khô <',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        prefixIcon: const Icon(Icons.air_rounded, color: Colors.lightBlue),
                        suffixText: '%',
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) return 'Bắt buộc';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Chọn thiết bị', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2E3A46))),
              const SizedBox(height: 12),
              _buildDeviceOption(
                id: 'smart_greenhouse',
                title: 'Smart Greenhouse',
                subtitle: 'Thiết bị mặc định',
                icon: Icons.sensors_rounded,
                selected: !_isCustomDevice && _selectedDeviceId == 'smart_greenhouse',
                onTap: () => setState(() {
                  _selectedDeviceId = 'smart_greenhouse';
                  _isCustomDevice = false;
                }),
              ),
              const SizedBox(height: 12),
              _buildDeviceOption(
                id: 'custom',
                title: 'Thiết bị khác',
                subtitle: 'Nhập Device ID thủ công',
                icon: Icons.edit_rounded,
                selected: _isCustomDevice,
                onTap: () => setState(() {
                  _isCustomDevice = true;
                  _selectedDeviceId = 'custom';
                }),
              ),
              if (_isCustomDevice) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customDeviceIdController,
                  decoration: InputDecoration(
                    labelText: 'Nhập Device ID của bạn',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.developer_board_rounded),
                  ),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập Device ID' : null,
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('LƯU HỒ SƠ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F5E9) : Colors.white,
          border: Border.all(
            color: selected ? const Color(0xFF43A047) : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? const Color(0xFF43A047) : Colors.grey.shade600),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: selected ? const Color(0xFF2E7D32) : const Color(0xFF2E3A46))),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                ],
              ),
            ),
            if (selected) const Icon(Icons.check_circle_rounded, color: Color(0xFF43A047)),
          ],
        ),
      ),
    );
  }
}
