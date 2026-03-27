import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class BusinessDetailScreen extends StatelessWidget {
  final String businessId;
  const BusinessDetailScreen({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final biz = MockData.businesses.firstWhere((b) => b.businessId == businessId, orElse: () => MockData.businesses.first);
    final appState = Provider.of<AppState>(context);
    final isFavorite = appState.favoriteBusinesses.contains(businessId);

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(biz.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.darkSurface)),
            ),
            actions: [
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: AppColors.macedonianRed),
                onPressed: () => appState.toggleFavoriteBusiness(businessId),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(biz.getName(lang), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                        child: Text(biz.category, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.star, size: 16, color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text('${biz.rating} (${biz.reviewCount} reviews)', style: const TextStyle(color: AppColors.gold, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(biz.getDescription(lang), style: const TextStyle(color: AppColors.lightGrey, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 24),
                  _infoRow(Icons.location_on, '${biz.address}, ${biz.suburb} ${biz.state}'),
                  _infoRow(Icons.phone, biz.phone),
                  _infoRow(Icons.email, biz.email),
                  if (biz.website.isNotEmpty) _infoRow(Icons.language, biz.website),
                  const SizedBox(height: 24),
                  // Map placeholder
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 48, color: AppColors.grey),
                          SizedBox(height: 8),
                          Text('Map View', style: TextStyle(color: AppColors.grey)),
                          Text('Google Maps integration placeholder', style: TextStyle(color: AppColors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl('tel:${biz.phone}'),
                          icon: const Icon(Icons.phone),
                          label: Text(lang == 'mk' ? 'Повикај' : 'Call'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _launchUrl('mailto:${biz.email}'),
                          icon: const Icon(Icons.email),
                          label: Text(lang == 'mk' ? 'Е-пошта' : 'Email'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Reviews section placeholder
                  Text(lang == 'mk' ? 'Рецензии' : 'Reviews', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Text(lang == 'mk' ? 'Рецензиите ќе бидат достапни наскоро' : 'Reviews coming soon',
                        style: const TextStyle(color: AppColors.grey)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.gold),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppColors.lightGrey, fontSize: 13))),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try { await launchUrl(Uri.parse(url)); } catch (_) {}
  }
}
