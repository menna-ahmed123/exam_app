import 'package:exam_app/config/di/injection.dart';
import 'package:exam_app/core/resources/app_theme.dart';
import 'package:exam_app/core/routing/app_router.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_view_model.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
      getIt<LoginViewModel>().login();

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