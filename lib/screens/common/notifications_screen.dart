import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Известувања' : 'Notifications')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.notifications_none, size: 64, color: AppColors.grey),
          const SizedBox(height: 16),
          Text(lang == 'mk' ? 'Нема нови известувања' : 'No new notifications',
            style: const TextStyle(color: AppColors.grey, fontSize: 16)),
        ]),
      ),
    );
  }
}
