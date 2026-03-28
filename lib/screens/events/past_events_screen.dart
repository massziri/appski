import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class PastEventsScreen extends StatelessWidget {
  const PastEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Минати Настани' : 'Past Events')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.photo_library, size: 64, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Text(lang == 'mk' ? 'Архива на минати настани' : 'Past events archive',
            style: const TextStyle(color: AppColors.lightGrey, fontSize: 16)),
          const SizedBox(height: 8),
          Text(lang == 'mk' ? 'Наскоро ќе биде достапно' : 'Coming soon',
            style: const TextStyle(color: AppColors.lightGrey, fontSize: 13)),
        ]),
      ),
    );
  }
}
