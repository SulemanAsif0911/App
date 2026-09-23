import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/networking/connectivity_service.dart';
import 'core/security/app_lock_controller.dart';
import 'core/storage/prefs.dart';
import 'data/database/app_database.dart';
import 'data/repositories/app_repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = await AppPrefs.init();
  final db = await AppDatabase.open();
  final repos = AppRepositories(db);
  await repos.seedIfNeeded();
  final connectivity = ConnectivityService();
  connectivity.start();
  final lock = AppLockController(prefs);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: prefs),
        ChangeNotifierProvider.value(value: connectivity),
        ChangeNotifierProvider.value(value: lock),
        Provider.value(value: repos),
      ],
      child: const CyberHayatApp(),
    ),
  );
}
