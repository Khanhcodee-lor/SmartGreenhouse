import 'package:flutter/material.dart';
import '../features/plant_setup/presentation/pages/plant_setup_page.dart';
import 'package:provider/provider.dart';
import '../features/greenhouse/presentation/providers/notification_provider.dart';
import '../features/greenhouse/presentation/providers/plant_provider.dart';
import '../features/greenhouse/presentation/pages/greenhouse_page.dart';
import '../features/greenhouse/presentation/providers/greenhouse_provider.dart';
import '../features/greenhouse/domain/usecases/watch_greenhouse.dart';
import '../features/greenhouse/domain/usecases/update_control.dart';
import '../features/greenhouse/data/repositories/greenhouse_repository_impl.dart';
import '../features/greenhouse/data/datasources/greenhouse_remote_datasource.dart';
import 'package:firebase_database/firebase_database.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NotificationProvider.instance,
      child: Consumer<PlantProvider>(
        builder: (context, plantProvider, _) {
          return MaterialApp(
            title: 'Smart Greenhouse',
            debugShowCheckedModeBanner: false,
            theme: _buildLightTheme(),
            home: plantProvider.activePlant != null 
                ? const GreenhousePageWrapper() 
                : const PlantSetupPage(),
          );
        }
      ),
    );
  }

  ThemeData _buildLightTheme() {
    const primaryGreen = Color(0xFF43A047);
    const lightGreen = Color(0xFFE8F5E9);

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F8F5),
      primaryColor: primaryGreen,
      colorScheme: const ColorScheme.light(
        primary: primaryGreen,
        secondary: Color(0xFF66BB6A),
        surface: Colors.white,
        error: Color(0xFFE53935),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: primaryGreen),
        titleTextStyle: TextStyle(
          color: Color(0xFF2E3A46),
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryGreen;
          }
          return Colors.grey.shade400;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return lightGreen;
          }
          return Colors.grey.shade200;
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class GreenhousePageWrapper extends StatefulWidget {
  const GreenhousePageWrapper({super.key});

  @override
  State<GreenhousePageWrapper> createState() => _GreenhousePageWrapperState();
}

class _GreenhousePageWrapperState extends State<GreenhousePageWrapper> {
  GreenhouseProvider? _greenhouseProvider;
  String? _currentDeviceId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final plant = context.watch<PlantProvider>().activePlant;
    if (plant != null && plant.deviceId != _currentDeviceId) {
      _currentDeviceId = plant.deviceId;
      
      final database = FirebaseDatabase.instance;
      final datasource = GreenhouseRemoteDatasource(database, deviceId: plant.deviceId);
      final repository = GreenhouseRepositoryImpl(datasource);
      final watchGreenhouse = WatchGreenhouse(repository);
      final updateControl = UpdateControl(repository);
      
      _greenhouseProvider?.dispose();
      
      _greenhouseProvider = GreenhouseProvider(
        watchGreenhouse: watchGreenhouse,
        updateControl: updateControl,
      )..startWatching();
    }
  }

  @override
  Widget build(BuildContext context) {
    final plant = context.watch<PlantProvider>().activePlant;
    if (plant == null || _greenhouseProvider == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Color(0xFF43A047))),
      );
    }
    
    return ChangeNotifierProvider.value(
      value: _greenhouseProvider!,
      child: GreenhousePage(
        plantName: plant.name,
        plantAge: plant.age,
      ),
    );
  }

  @override
  void dispose() {
    _greenhouseProvider?.dispose();
    super.dispose();
  }
}
