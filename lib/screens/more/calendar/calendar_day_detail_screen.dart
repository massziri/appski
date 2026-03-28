import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class CalendarDayDetailScreen extends StatelessWidget {
  final String dateKey;
  const CalendarDayDetailScreen({super.key, required this.dateKey});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final day = MockData.orthodoxCalendar[dateKey];

    if (day == null) {
      return Scaffold(
        backgroundColor: AppColors.warmBg,
        appBar: AppBar(title: Text(dateKey)),
        body: Center(child: Text(lang == 'mk' ? 'Нема податоци' : 'No data available', style: const TextStyle(color: AppColors.lightGrey))),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(title: Text(dateKey)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Date header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.darkCard, AppColors.gold.withOpacity(0.1)]),
              borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              const Text('✝️', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(lang == 'mk' ? 'Грегоријански: $dateKey' : 'Gregorian: $dateKey', style: const TextStyle(color: AppColors.bodyText, fontSize: 13)),
              Text(lang == 'mk' ? 'Јулијански: ${day.julianDate}' : 'Julian: ${day.julianDate}', style: const TextStyle(color: AppColors.gold, fontSize: 13)),
            ]),
          ),
          const SizedBox(height: 20),
          // Saints
          Text(lang == 'mk' ? 'Светци' : 'Saints', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          ...day.getSaints(lang).map((s) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Text('☦️', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Expanded(child: Text(s, style: const TextStyle(color: AppColors.darkText, fontSize: 14))),
            ]),
          )),
          const SizedBox(height: 20),
          // Fasting
          Text(lang == 'mk' ? 'Пост' : 'Fasting', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.restaurant, color: AppColors.gold),
              const SizedBox(width: 12),
              Text(day.fastingRule.replaceAll('_', ' ').toUpperCase(), style: const TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w600)),
            ]),
          ),
          if (day.readings.isNotEmpty) ...[
            const SizedBox(height: 20),
            Text(lang == 'mk' ? 'Читања' : 'Readings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            ...day.readings.map((r) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(12)),
              child: Row(children: [
                const Icon(Icons.book, color: AppColors.info, size: 18),
                const SizedBox(width: 12),
                Text(r, style: const TextStyle(color: AppColors.bodyText, fontSize: 14)),
              ]),
            )),
          ],
        ],
      ),
    );
  }
}
