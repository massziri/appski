import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../models/models.dart';

class BusinessCard extends StatelessWidget {
  final Business business;
  final String lang;
  final VoidCallback onTap;
  final bool isHorizontal;

  const BusinessCard({super.key, required this.business, required this.lang, required this.onTap, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 180,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.warmCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(business.imageUrl, height: 110, width: 180, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(height: 110, width: 180, color: AppColors.warmSurface, child: const Icon(Icons.store, color: AppColors.lightGrey))),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.getName(lang), style: const TextStyle(color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text('${business.rating}', style: const TextStyle(color: AppColors.gold, fontSize: 11)),
                        const SizedBox(width: 6),
                        Text(business.category, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.warmCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(business.imageUrl, width: 100, height: 100, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(width: 100, height: 100, color: AppColors.warmSurface, child: const Icon(Icons.store, color: AppColors.lightGrey))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.getName(lang), style: const TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text('${business.rating}', style: const TextStyle(color: AppColors.gold, fontSize: 12)),
                        const SizedBox(width: 4),
                        Text('(${business.reviewCount})', style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                          child: Text(business.category, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(width: 8),
                        Text('${business.suburb}, ${business.state}', style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
