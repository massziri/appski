import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class RadioListScreen extends StatelessWidget {
  const RadioListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Радио Станици' : 'Radio Stations')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: MockData.radioStations.length,
        itemBuilder: (context, i) {
          final station = MockData.radioStations[i];
          final isFav = appState.favoriteStations.contains(station.stationId);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(station.logoUrl, width: 56, height: 56, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(width: 56, height: 56, color: AppColors.darkSurface,
                    child: const Icon(Icons.radio, color: AppColors.grey))),
              ),
              title: Text(station.name, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
              subtitle: Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                  child: Text(station.genre, style: const TextStyle(color: AppColors.macedonianRed, fontSize: 10)),
                ),
                const SizedBox(width: 8),
                Text(station.region, style: const TextStyle(color: AppColors.grey, fontSize: 11)),
                const Spacer(),
                Container(width: 8, height: 8, decoration: BoxDecoration(
                  shape: BoxShape.circle, color: station.isLive ? AppColors.success : AppColors.grey)),
                const SizedBox(width: 4),
                Text(station.isLive ? 'LIVE' : 'OFF', style: TextStyle(
                  color: station.isLive ? AppColors.success : AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              ]),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: AppColors.macedonianRed, size: 20),
                  onPressed: () => appState.toggleFavoriteStation(station.stationId)),
                IconButton(icon: const Icon(Icons.play_circle_filled, color: AppColors.gold, size: 36),
                  onPressed: () => context.push('/media/radio/player', extra: {'stationId': station.stationId})),
              ]),
            ),
          );
        },
      ),
    );
  }
}
