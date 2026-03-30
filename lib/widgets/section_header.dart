import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: AppColors.darkText, fontSize: 16, fontWeight: FontWeight.w600)),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Row(
                children: [
                  Text('See All', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 11, color: AppColors.primary),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
