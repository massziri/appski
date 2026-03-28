import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../models/models.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle article;
  final String lang;
  final VoidCallback onTap;

  const NewsCard({super.key, required this.article, required this.lang, required this.onTap});

  @override
  Widget build(BuildContext context) {
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
              child: Image.network(
                article.featuredImage,
                width: 110,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 110, height: 100, color: AppColors.warmSurface,
                  child: const Icon(Icons.image, color: AppColors.lightGrey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.macedonianRed.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(article.category, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 10, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.getTitle(lang),
                      style: const TextStyle(color: AppColors.darkText, fontSize: 13, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${article.readingTime} min read',
                      style: const TextStyle(color: AppColors.lightGrey, fontSize: 11),
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
