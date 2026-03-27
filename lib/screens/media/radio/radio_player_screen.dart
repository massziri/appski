import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class RadioPlayerScreen extends StatefulWidget {
  final String stationId;
  const RadioPlayerScreen({super.key, required this.stationId});
  @override
  State<RadioPlayerScreen> createState() => _RadioPlayerScreenState();
}

class _RadioPlayerScreenState extends State<RadioPlayerScreen> {
  bool _isPlaying = false;
  double _volume = 0.7;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final station = MockData.radioStations.firstWhere(
      (s) => s.stationId == widget.stationId,
      orElse: () => MockData.radioStations.first,
    );

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(lang == 'mk' ? 'Сега Свири' : 'Now Playing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Station logo
            Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [BoxShadow(color: AppColors.macedonianRed.withOpacity(0.3), blurRadius: 30, spreadRadius: 5)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(station.logoUrl, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.darkCard,
                    child: const Icon(Icons.radio, size: 80, color: AppColors.gold))),
              ),
            ),
            const SizedBox(height: 30),
            Text(station.name, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.success)),
              const SizedBox(width: 6),
              Text('LIVE', style: const TextStyle(color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(width: 16),
              Text('${station.region} • ${station.genre}', style: const TextStyle(color: AppColors.grey, fontSize: 13)),
            ]),
            const SizedBox(height: 40),
            // Playback controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.skip_previous, color: AppColors.white, size: 36), onPressed: () {}),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => setState(() => _isPlaying = !_isPlaying),
                  child: Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.macedonianRed,
                      boxShadow: [BoxShadow(color: AppColors.macedonianRed.withOpacity(0.4), blurRadius: 15)],
                    ),
                    child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: AppColors.white, size: 40),
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(icon: const Icon(Icons.skip_next, color: AppColors.white, size: 36), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 30),
            // Volume
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  const Icon(Icons.volume_down, color: AppColors.grey, size: 20),
                  Expanded(
                    child: Slider(
                      value: _volume, min: 0, max: 1,
                      activeColor: AppColors.gold,
                      inactiveColor: AppColors.darkCard,
                      onChanged: (v) => setState(() => _volume = v),
                    ),
                  ),
                  const Icon(Icons.volume_up, color: AppColors.grey, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              station.streamUrl.isEmpty
                ? (lang == 'mk' ? '⚠️ URL на стримот е празен — наскоро' : '⚠️ Stream URL empty — coming soon')
                : '',
              style: const TextStyle(color: AppColors.grey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
