import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(
        title: Text(lang == 'mk' ? 'Откриј' : 'Discover'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => context.push('/search')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _discoverCard(context, Icons.store, lang == 'mk' ? 'Бизниси' : 'Businesses', lang == 'mk' ? 'Директориум на бизниси' : 'Business Directory', '/discover/businesses', AppColors.macedonianRed),
            _discoverCard(context, Icons.people, lang == 'mk' ? 'Организации' : 'Organisations', lang == 'mk' ? 'Цркви, клубови, здруженија' : 'Churches, clubs, groups', '/discover/organisations', AppColors.info),
            _discoverCard(context, Icons.restaurant_menu, lang == 'mk' ? 'Рецепти' : 'Recipes', lang == 'mk' ? 'Традиционална кујна' : 'Traditional cuisine', '/discover/recipes', AppColors.gold),
            _discoverCard(context, Icons.flight, lang == 'mk' ? 'Туризам' : 'Tourism', lang == 'mk' ? 'Откријте ја Македонија' : 'Discover Macedonia', '/discover/tourism', AppColors.success),
          ],
        ),
      ),
    );
  }

  Widget _discoverCard(BuildContext context, IconData icon, String title, String subtitle, String route, Color color) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: AppColors.white, fontSize: 15, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: AppColors.grey, fontSize: 11), textAlign: TextAlign.center, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
