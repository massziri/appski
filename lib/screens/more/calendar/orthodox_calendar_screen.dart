import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class OrthodoxCalendarScreen extends StatefulWidget {
  const OrthodoxCalendarScreen({super.key});
  @override
  State<OrthodoxCalendarScreen> createState() => _OrthodoxCalendarScreenState();
}

class _OrthodoxCalendarScreenState extends State<OrthodoxCalendarScreen> {
  DateTime _selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final todayEntry = MockData.getTodayCalendar();

    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(
        title: Text(lang == 'mk' ? 'Православен Календар' : 'Orthodox Calendar'),
        actions: [
          IconButton(icon: const Icon(Icons.person_search, color: AppColors.gold),
            onPressed: () => context.push('/more/calendar/namedays')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today's entry highlight
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.darkCard, AppColors.macedonianRed.withOpacity(0.15)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text('✝️', style: TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(lang == 'mk' ? 'Денес' : 'Today', style: const TextStyle(color: AppColors.gold, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(DateFormat('MMM d, yyyy').format(DateTime.now()), style: const TextStyle(color: AppColors.grey, fontSize: 12)),
                ]),
                const SizedBox(height: 12),
                ...todayEntry.getSaints(lang).map((s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('• $s', style: const TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                )),
                const SizedBox(height: 12),
                Row(children: [
                  _calBadge(_feastLabel(todayEntry.feastType, lang), _feastColor(todayEntry.feastType)),
                  const SizedBox(width: 8),
                  _calBadge(_fastLabel(todayEntry.fastingRule, lang), AppColors.info),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Calendar month view
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.white),
              onPressed: () => setState(() => _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1))),
            Text(DateFormat('MMMM yyyy').format(_selectedMonth), style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.white),
              onPressed: () => setState(() => _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1))),
          ]),
          const SizedBox(height: 16),
          // Legend
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _legendDot(AppColors.macedonianRed, lang == 'mk' ? 'Голем Празник' : 'Great Feast'),
            const SizedBox(width: 16),
            _legendDot(AppColors.info, lang == 'mk' ? 'Пост' : 'Fast'),
            const SizedBox(width: 16),
            _legendDot(AppColors.white, lang == 'mk' ? 'Обичен' : 'Regular'),
          ]),
          const SizedBox(height: 20),
          // Sample calendar entries
          ...MockData.orthodoxCalendar.entries.map((entry) {
            final day = entry.value;
            return GestureDetector(
              onTap: () => context.push('/more/calendar/day/${day.dateKey}'),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: _feastColor(day.feastType), width: 3))),
                child: Row(children: [
                  SizedBox(width: 60, child: Column(children: [
                    Text(DateFormat('MMM').format(DateTime.parse(day.dateKey)), style: const TextStyle(color: AppColors.grey, fontSize: 10)),
                    Text(DateFormat('d').format(DateTime.parse(day.dateKey)), style: const TextStyle(color: AppColors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  ])),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(day.getSaints(lang).first, style: const TextStyle(color: AppColors.white, fontSize: 13, fontWeight: FontWeight.w500), maxLines: 2),
                    const SizedBox(height: 4),
                    Row(children: [
                      _calBadge(_feastLabel(day.feastType, lang), _feastColor(day.feastType)),
                      const SizedBox(width: 6),
                      _calBadge(_fastLabel(day.fastingRule, lang), AppColors.info),
                    ]),
                  ])),
                  const Icon(Icons.chevron_right, color: AppColors.grey, size: 18),
                ]),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _calBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(children: [
      Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
      const SizedBox(width: 6),
      Text(label, style: const TextStyle(color: AppColors.grey, fontSize: 10)),
    ]);
  }

  Color _feastColor(String type) {
    switch (type) {
      case 'great_feast': return AppColors.macedonianRed;
      case 'fast': return AppColors.info;
      default: return AppColors.white;
    }
  }

  String _feastLabel(String type, String lang) {
    switch (type) {
      case 'great_feast': return lang == 'mk' ? 'Голем Празник' : 'Great Feast';
      case 'fast': return lang == 'mk' ? 'Пост' : 'Fast';
      default: return lang == 'mk' ? 'Обичен' : 'Regular';
    }
  }

  String _fastLabel(String rule, String lang) {
    switch (rule) {
      case 'strict': return lang == 'mk' ? 'Строг Пост' : 'Strict Fast';
      case 'oil_allowed': return lang == 'mk' ? 'Масло Дозволено' : 'Oil Allowed';
      case 'fish': return lang == 'mk' ? 'Риба Дозволена' : 'Fish Allowed';
      default: return lang == 'mk' ? 'Без Пост' : 'No Fast';
    }
  }
}
