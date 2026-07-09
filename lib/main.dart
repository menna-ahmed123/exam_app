import 'package:exam_app/core/di/service_locator.dart';
import 'package:exam_app/core/resources/app_theme.dart';
import 'package:exam_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}