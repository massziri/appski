import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});
  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  int _selectedChannel = 0;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final channel = MockData.tvChannels[_selectedChannel];

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'ТВ во Живо' : 'TV Live Stream')),
      body: Column(
        children: [
          // Video player placeholder
          Container(
            height: 220,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.live_tv, size: 64, color: AppColors.lightGrey),
                  const SizedBox(height: 12),
                  Text(channel.name, style: const TextStyle(color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.macedonianRed, borderRadius: BorderRadius.circular(4)),
                    child: const Text('LIVE', style: TextStyle(color: AppColors.darkText, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    channel.streamUrl.isEmpty
                      ? (lang == 'mk' ? 'Стримот ќе биде достапен наскоро' : 'Stream coming soon')
                      : '',
                    style: const TextStyle(color: AppColors.lightGrey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Channel selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(lang == 'mk' ? 'Канали' : 'Channels', style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: 12),
          ...MockData.tvChannels.asMap().entries.map((entry) {
            final i = entry.key;
            final ch = entry.value;
            final isSelected = i == _selectedChannel;
            return GestureDetector(
              onTap: () => setState(() => _selectedChannel = i),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.macedonianRed.withOpacity(0.2) : AppColors.darkCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isSelected ? AppColors.macedonianRed : Colors.transparent),
                ),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(ch.logoUrl, width: 48, height: 48, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(width: 48, height: 48, color: AppColors.warmSurface, child: const Icon(Icons.tv, color: AppColors.lightGrey))),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(ch.name, style: const TextStyle(color: AppColors.darkText, fontWeight: FontWeight.w600)),
                    Text(lang == 'mk' ? ch.descriptionMk : ch.descriptionEn, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                  ])),
                  Container(width: 8, height: 8, decoration: BoxDecoration(
                    shape: BoxShape.circle, color: ch.active ? AppColors.success : AppColors.grey)),
                ]),
              ),
            );
          }),
        ],
      ),
    );
  }
}
