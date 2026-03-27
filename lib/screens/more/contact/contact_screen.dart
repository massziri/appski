import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/app_theme.dart';
import '../../../config/app_constants.dart';
import '../../../providers/app_state.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Контактирајте Нè' : 'Contact Us')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _contactCard(Icons.email, lang == 'mk' ? 'Е-пошта' : 'Email', AppConstants.supportEmail,
            () => _launch('mailto:${AppConstants.supportEmail}'), AppColors.gold),
          _contactCard(Icons.phone, lang == 'mk' ? 'Телефон' : 'Phone', AppConstants.supportPhone,
            () => _launch('tel:${AppConstants.supportPhone}'), AppColors.success),
          _contactCard(Icons.language, lang == 'mk' ? 'Веб Страна' : 'Website', AppConstants.websiteUrl,
            () => _launch(AppConstants.websiteUrl), AppColors.info),
          const SizedBox(height: 24),
          Text(lang == 'mk' ? 'Социјални Мрежи' : 'Social Media', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _socialButton(Icons.facebook, 'Facebook', AppColors.info, () => _launch(AppConstants.facebookUrl)),
            _socialButton(Icons.camera_alt, 'Instagram', AppColors.macedonianRed, () => _launch(AppConstants.instagramUrl)),
            _socialButton(Icons.play_circle, 'YouTube', AppColors.error, () => _launch(AppConstants.youtubeUrl)),
          ]),
        ],
      ),
    );
  }

  Widget _contactCard(IconData icon, String title, String value, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: AppColors.grey, fontSize: 11)),
            Text(value, style: const TextStyle(color: AppColors.white, fontSize: 14)),
          ])),
          Icon(Icons.open_in_new, color: color, size: 18),
        ]),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(width: 56, height: 56, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: color, size: 28)),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ]),
    );
  }

  Future<void> _launch(String url) async {
    try { await launchUrl(Uri.parse(url)); } catch (_) {}
  }
}
