import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class TourismHubScreen extends StatelessWidget {
  const TourismHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Туризам Македонија' : 'Tourism Macedonia')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.tourismPlaces.length,
        itemBuilder: (context, i) {
          final place = MockData.tourismPlaces[i];
          return GestureDetector(
            onTap: () => context.push('/discover/tourism/${place.placeId}'),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(image: NetworkImage(place.imageUrl), fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)]),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(6)),
                      child: Text(place.category, style: const TextStyle(color: AppColors.warmBg, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    Text(place.getName(lang), style: const TextStyle(color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(place.region, style: const TextStyle(color: AppColors.bodyText, fontSize: 12)),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
