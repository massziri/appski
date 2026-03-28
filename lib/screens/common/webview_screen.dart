import 'package:flutter/material.dart';
import '../../config/app_theme.dart';

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;
  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.web, size: 64, color: AppColors.lightGrey),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: AppColors.darkText, fontSize: 18)),
          const SizedBox(height: 8),
          Text(url, style: const TextStyle(color: AppColors.lightGrey, fontSize: 12)),
          const SizedBox(height: 16),
          const Text('WebView will load here when\nFirebase/URL is configured',
            style: TextStyle(color: AppColors.lightGrey, fontSize: 13), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}
