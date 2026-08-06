import 'package:exam_app/core/resources/app_palette.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _buildAvatar();
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: const BoxDecoration(
          color: AppPalette.avatarBackground,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.person, size: 50, color: AppPalette.white),
      ),
    );
  }
}
