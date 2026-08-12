import 'package:exam_app/core/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shown when a route that requires `extra` is opened without it.
class InvalidExtraRedirect extends StatefulWidget {
  const InvalidExtraRedirect({super.key});

  @override
  State<InvalidExtraRedirect> createState() => InvalidExtraRedirectState();
}

class InvalidExtraRedirectState extends State<InvalidExtraRedirect> {
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
