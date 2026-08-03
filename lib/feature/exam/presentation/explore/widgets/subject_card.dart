import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  final SubjectEntity subject;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppPalette.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      shadowColor: AppPalette.border,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              _SubjectIcon(iconUrl: subject.icon),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  subject.name,
                  style: AppTextStyles.styleMedium18(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubjectIcon extends StatelessWidget {
  const _SubjectIcon({required this.iconUrl});

  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 56,
        height: 56,
        child: iconUrl.isEmpty
            ? const ColoredBox(
                color: AppPalette.lightBlue,
                child: Icon(Icons.menu_book, color: AppPalette.primaryBlue),
              )
            : Image.network(
                iconUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const ColoredBox(
                  color: AppPalette.lightBlue,
                  child: Icon(Icons.menu_book, color: AppPalette.primaryBlue),
                ),
              ),
      ),
    );
  }
}
