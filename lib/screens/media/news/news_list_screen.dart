import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';
import '../../../widgets/news_card.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});
  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final filtered = _selectedCategory == 'All'
      ? MockData.news
      : MockData.news.where((n) => n.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(
        title: Text(lang == 'mk' ? 'Вести' : 'News'),
        actions: [
          TextButton(
            onPressed: () {
              final appState = Provider.of<AppState>(context, listen: false);
              appState.setLanguage(lang == 'en' ? 'mk' : 'en');
            },
            child: Text(lang == 'en' ? 'МК' : 'EN', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.newsCategories.length,
              itemBuilder: (context, i) {
                final cat = AppConstants.newsCategories[i];
                final selected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(label: Text(cat), selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    backgroundColor: AppColors.darkCard, selectedColor: AppColors.macedonianRed,
                    labelStyle: TextStyle(color: selected ? AppColors.white : AppColors.lightGrey, fontSize: 12)),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) => NewsCard(
                article: filtered[i],
                lang: lang,
                onTap: () => context.push('/media/news/${filtered[i].newsId}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
