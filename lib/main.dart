import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:new_app/router/application.dart';
import 'package:new_app/router/routers.dart';

void main() {
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: Application.router?.generator,
      initialRoute: Routes.home,
    );
  }
}
