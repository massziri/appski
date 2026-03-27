import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _newsNotif = true;
  bool _eventNotif = true;
  bool _feastNotif = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lang = appState.language;

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Поставки' : 'Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language
          Text(lang == 'mk' ? 'Јазик' : 'Language', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Expanded(child: GestureDetector(
                onTap: () => appState.setLanguage('en'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: lang == 'en' ? AppColors.macedonianRed : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text('English', style: TextStyle(color: AppColors.white, fontWeight: lang == 'en' ? FontWeight.bold : FontWeight.normal))),
                ),
              )),
              Expanded(child: GestureDetector(
                onTap: () => appState.setLanguage('mk'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: lang == 'mk' ? AppColors.macedonianRed : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text('Македонски', style: TextStyle(color: AppColors.white, fontWeight: lang == 'mk' ? FontWeight.bold : FontWeight.normal))),
                ),
              )),
            ]),
          ),
          const SizedBox(height: 24),
          // Notifications
          Text(lang == 'mk' ? 'Известувања' : 'Notifications', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          _notifToggle(lang == 'mk' ? 'Вести' : 'News Alerts', _newsNotif, (v) => setState(() => _newsNotif = v)),
          _notifToggle(lang == 'mk' ? 'Настани' : 'Event Reminders', _eventNotif, (v) => setState(() => _eventNotif = v)),
          _notifToggle(lang == 'mk' ? 'Празници' : 'Feast Day Alerts', _feastNotif, (v) => setState(() => _feastNotif = v)),
          const SizedBox(height: 24),
          // Clear cache
          SizedBox(width: double.infinity, child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(lang == 'mk' ? 'Кешот е избришан' : 'Cache cleared')));
            },
            icon: const Icon(Icons.delete_outline),
            label: Text(lang == 'mk' ? 'Избриши Кеш' : 'Clear Cache'),
          )),
        ],
      ),
    );
  }

  Widget _notifToggle(String title, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: AppColors.white, fontSize: 14)),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.macedonianRed,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
