import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class TourismDetailScreen extends StatelessWidget {
  final String placeId;
  const TourismDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final place = MockData.tourismPlaces.firstWhere((p) => p.placeId == placeId, orElse: () => MockData.tourismPlaces.first);
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(expandedHeight: 300, pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(place.getName(lang), style: const TextStyle(fontSize: 16)),
              background: Image.network(place.imageUrl, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.warmSurface)))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                      child: Text(place.category, style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 16, color: AppColors.macedonianRed),
                    const SizedBox(width: 4),
                    Text(place.region, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 13)),
                  ]),
                  const SizedBox(height: 20),
                  Text(place.getDescription(lang), style: const TextStyle(color: AppColors.bodyText, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 24),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(16)),
                    child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.map, size: 48, color: AppColors.lightGrey),
                      SizedBox(height: 8),
                      Text('Map View', style: TextStyle(color: AppColors.lightGrey)),
                    ])),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
