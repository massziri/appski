import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'За Заедницата' : 'About Community')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(colors: [AppColors.gold, AppColors.macedonianRed]),
              boxShadow: [BoxShadow(color: AppColors.macedonianRed.withOpacity(0.3), blurRadius: 20)],
            ),
            child: const Center(child: Text('☀', style: TextStyle(fontSize: 50))),
          )),
          const SizedBox(height: 20),
          Text(AppConstants.orgName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          Text(
            lang == 'mk'
              ? 'Македонската Заедница на Австралија е посветена на зачувување и промовирање на македонската култура, јазик и традиции за сегашните и идните генерации во Австралија.\n\nОснована за да служи како мост помеѓу македонската дијаспора и нивното наследство, организацијата нуди широк спектар на културни, образовни и социјални програми.'
              : 'The Macedonian Community of Australia Inc. is dedicated to preserving and promoting Macedonian culture, language, and traditions for current and future generations in Australia.\n\nEstablished to serve as a bridge between the Macedonian diaspora and their heritage, the organization offers a wide range of cultural, educational, and social programs.',
            style: const TextStyle(color: AppColors.lightGrey, fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 24),
          _infoTile(Icons.email, AppConstants.supportEmail),
          _infoTile(Icons.phone, AppConstants.supportPhone),
          _infoTile(Icons.language, AppConstants.websiteUrl),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _socialIcon(Icons.facebook, AppColors.info),
            const SizedBox(width: 20),
            _socialIcon(Icons.camera_alt, AppColors.macedonianRed),
            const SizedBox(width: 20),
            _socialIcon(Icons.play_circle, AppColors.error),
          ]),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.gold), const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: AppColors.lightGrey, fontSize: 13))),
      ]));
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, color: color, size: 24));
  }
}
