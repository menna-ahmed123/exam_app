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
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      shadowColor: AppPalette.border,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          SubjectIcon(iconUrl: subject.icon),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              subject.name,
              style: AppTextStyles.styleMedium16(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectIcon extends StatelessWidget {
  const SubjectIcon({super.key, required this.iconUrl});

  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    if (iconUrl.isEmpty) return _fallbackIcon();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        iconUrl,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _fallbackIcon(),
      ),
    );
  }

  Widget _fallbackIcon() {
    return const Icon(
      Icons.menu_book_outlined,
      size: 40,
      color: AppPalette.primaryBlue,
    );
  }
}
