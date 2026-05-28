import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'core/services/fcm_service.dart';
import 'core/services/plant_storage_service.dart';
import 'features/greenhouse/data/repositories/greenhouse_repository_impl.dart';
import 'features/greenhouse/domain/usecases/update_control.dart';
import 'features/greenhouse/presentation/providers/plant_provider.dart';
import 'features/greenhouse/data/datasources/greenhouse_remote_datasource.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Khởi tạo FCM và lưu token
  final fcmService = FCMService();
  await fcmService.initialize();

  // Khởi tạo Storage cho Plant Profiles
  final plantStorageService = await PlantStorageService.create();
  
  // Dummy repository and updateControl for the global plant provider
  // It will be updated later inside GreenhousePage
  final database = FirebaseDatabase.instance;
  final datasource = GreenhouseRemoteDatasource(database, deviceId: 'smart_greenhouse');
  final repository = GreenhouseRepositoryImpl(datasource);
  final updateControl = UpdateControl(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlantProvider(
            storageService: plantStorageService,
            updateControl: updateControl,
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
