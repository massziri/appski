import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsId;
  const NewsDetailScreen({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lang = appState.language;
    final article = MockData.news.firstWhere((n) => n.newsId == newsId, orElse: () => MockData.news.first);

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250, pinned: true,
            actions: [
              TextButton(
                onPressed: () => appState.setLanguage(lang == 'en' ? 'mk' : 'en'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(8)),
                  child: Text(lang == 'en' ? 'МК' : 'EN', style: const TextStyle(color: AppColors.warmBg, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
              IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(background: Image.network(article.featuredImage, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.warmSurface))),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                    child: Text(article.category, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 12),
                  Text(article.getTitle(lang), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 12),
                  Row(children: [
                    const Icon(Icons.person, size: 14, color: AppColors.lightGrey),
                    const SizedBox(width: 4),
                    Text(article.author, style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today, size: 14, color: AppColors.lightGrey),
                    const SizedBox(width: 4),
                    Text(DateFormat('MMM d, yyyy').format(article.publishedAt), style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
                    const SizedBox(width: 16),
                    const Icon(Icons.timer, size: 14, color: AppColors.lightGrey),
                    const SizedBox(width: 4),
                    Text('${article.readingTime} min read', style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
                  ]),
                  const SizedBox(height: 20),
                  const Divider(color: AppColors.warmCard),
                  const SizedBox(height: 16),
                  Text(article.getBody(lang), style: const TextStyle(color: AppColors.bodyText, fontSize: 15, height: 1.7)),
                  const SizedBox(height: 30),
                  // Related Articles
                  Text(lang == 'mk' ? 'Поврзани Статии' : 'Related Articles', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  ...MockData.news.where((n) => n.newsId != newsId).take(3).map((related) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
                    child: Text(related.getTitle(lang), style: const TextStyle(color: AppColors.darkText, fontSize: 13)),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
