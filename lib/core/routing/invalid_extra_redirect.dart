import 'package:exam_app/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvalidExtraRedirect extends StatefulWidget {
  const InvalidExtraRedirect({super.key});

  @override
  State<InvalidExtraRedirect> createState() => _InvalidExtraRedirectState();
}

class _InvalidExtraRedirectState extends State<InvalidExtraRedirect> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
