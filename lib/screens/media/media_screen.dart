import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Медиуми' : 'Media')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _mediaCard(context, Icons.radio, lang == 'mk' ? 'Македонско Радио' : 'Macedonian Radio',
              lang == 'mk' ? 'Слушај радио станици во живо' : 'Listen to live radio stations', '/media/radio', AppColors.macedonianRed),
            const SizedBox(height: 16),
            _mediaCard(context, Icons.tv, lang == 'mk' ? 'ТВ во Живо' : 'TV Live Stream',
              lang == 'mk' ? '24/7 Македонска телевизија' : '24/7 Macedonian television', '/media/tv', AppColors.gold),
            const SizedBox(height: 16),
            _mediaCard(context, Icons.newspaper, lang == 'mk' ? 'Вести' : 'News',
              lang == 'mk' ? 'Двојазични вести' : 'Bilingual news feed', '/media/news', AppColors.info),
          ],
        ),
      ),
    );
  }

  Widget _mediaCard(BuildContext context, IconData icon, String title, String subtitle, String route, Color color) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(width: 60, height: 60,
              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 30)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: AppColors.grey, fontSize: 12)),
            ])),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}
