import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Повеќе' : 'More')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuItem(context, Icons.calendar_month, lang == 'mk' ? 'Православен Календар' : 'Orthodox Calendar',
            lang == 'mk' ? 'Светци, празници, пост' : 'Saints, feasts, fasting', '/more/calendar', AppColors.gold),
          _menuItem(context, Icons.cloud, lang == 'mk' ? 'Временска Прогноза' : 'Weather',
            lang == 'mk' ? 'Прогноза за Македонија' : 'Macedonia forecast', '/more/weather', AppColors.info),
          _menuItem(context, Icons.add_circle_outline, lang == 'mk' ? 'Поднеси Листинг' : 'Submit a Listing',
            lang == 'mk' ? 'Додадете бизнис или организација' : 'Add a business or organisation', '/more/submit', AppColors.success),
          const Divider(color: AppColors.darkCard, height: 32),
          _menuItem(context, Icons.settings, lang == 'mk' ? 'Поставки' : 'Settings',
            lang == 'mk' ? 'Јазик, известувања' : 'Language, notifications', '/more/settings', AppColors.lightGrey),
          _menuItem(context, Icons.info_outline, lang == 'mk' ? 'За Заедницата' : 'About Community',
            lang == 'mk' ? 'Македонска Заедница на Австралија' : 'Macedonian Community of Australia', '/more/about', AppColors.macedonianRed),
          _menuItem(context, Icons.mail_outline, lang == 'mk' ? 'Контактирајте Нè' : 'Contact Us',
            lang == 'mk' ? 'Е-пошта, телефон, социјални мрежи' : 'Email, phone, social media', '/more/contact', AppColors.gold),
          const Divider(color: AppColors.darkCard, height: 32),
          _menuItem(context, Icons.privacy_tip_outlined, lang == 'mk' ? 'Политика за Приватност' : 'Privacy Policy',
            '', '/webview', AppColors.grey, extra: {'title': 'Privacy Policy', 'url': 'https://macedoniancommunity.org.au/privacy'}),
          _menuItem(context, Icons.description_outlined, lang == 'mk' ? 'Услови за Користење' : 'Terms of Use',
            '', '/webview', AppColors.grey, extra: {'title': 'Terms of Use', 'url': 'https://macedoniancommunity.org.au/terms'}),
          const SizedBox(height: 30),
          Center(child: Text('Appski v1.0.0', style: const TextStyle(color: AppColors.grey, fontSize: 11))),
          Center(child: Text('© 2026 Macedonian Community of Australia Inc.', style: const TextStyle(color: AppColors.grey, fontSize: 10))),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, String subtitle, String route, Color color, {Map<String, String>? extra}) {
    return GestureDetector(
      onTap: () {
        if (extra != null) {
          context.push(route, extra: extra);
        } else {
          context.push(route);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w600)),
            if (subtitle.isNotEmpty) Text(subtitle, style: const TextStyle(color: AppColors.grey, fontSize: 11)),
          ])),
          const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),
        ]),
      ),
    );
  }
}
