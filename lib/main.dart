import 'package:alarm/alarm.dart';
import 'package:fluro/fluro.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_app/data/local/hive_service.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:flutter/material.dart';
import 'package:new_app/commons/app_environment.dart';
import 'package:new_app/commons/app_themes.dart';
import 'package:new_app/router/application.dart';
import 'package:new_app/router/routers.dart';

void main() async {
  await loadApp();
}

Future<void> loadApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Init router
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;

  /// Init hive
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');
  await HiveService.registerAdapter();

  /// Init alarm
  await Alarm.init();

  /// Run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.theme,
      debugShowCheckedModeBanner: currentEnvironment == Environment.dev,
      onGenerateRoute: Application.router?.generator,
      initialRoute: Routes.home,
    );
  }
}
