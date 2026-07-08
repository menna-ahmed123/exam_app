import 'package:exam_app/core/widgets/app_back_header.dart';
import 'package:flutter/material.dart';

/// Temporary screen shown until feature pages are implemented.
class RoutePlaceholder extends StatelessWidget {
  const RoutePlaceholder({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackHeader(title: title),
              const Spacer(),
              Center(
                child: Text(
                  '$title screen',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
