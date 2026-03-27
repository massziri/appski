import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/mock_data.dart';

class EventsCalendarScreen extends StatefulWidget {
  const EventsCalendarScreen({super.key});
  @override
  State<EventsCalendarScreen> createState() => _EventsCalendarScreenState();
}

class _EventsCalendarScreenState extends State<EventsCalendarScreen> {
  DateTime _selectedMonth = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.darkNavy,
      appBar: AppBar(title: Text(lang == 'mk' ? 'Календар Настани' : 'Events Calendar')),
      body: Column(
        children: [
          // Month navigation
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.white),
                  onPressed: () => setState(() => _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1))),
                Text(DateFormat('MMMM yyyy').format(_selectedMonth),
                  style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.white),
                  onPressed: () => setState(() => _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1))),
              ],
            ),
          ),
          // Calendar grid
          _buildCalendarGrid(),
          const Divider(color: AppColors.darkCard),
          // Events for selected day
          Expanded(
            child: _selectedDay == null
              ? Center(child: Text(lang == 'mk' ? 'Изберете ден' : 'Select a day', style: const TextStyle(color: AppColors.grey)))
              : _buildDayEvents(lang),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateUtils.getDaysInMonth(_selectedMonth.year, _selectedMonth.month);
    final firstDay = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
    final startWeekday = firstDay.weekday % 7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(children: ['S','M','T','W','T','F','S'].map((d) =>
            Expanded(child: Center(child: Text(d, style: const TextStyle(color: AppColors.grey, fontSize: 12, fontWeight: FontWeight.w600))))).toList()),
          const SizedBox(height: 8),
          ...List.generate(6, (week) {
            return Row(
              children: List.generate(7, (day) {
                final dayNum = week * 7 + day - startWeekday + 1;
                if (dayNum < 1 || dayNum > daysInMonth) return const Expanded(child: SizedBox(height: 40));
                final date = DateTime(_selectedMonth.year, _selectedMonth.month, dayNum);
                final hasEvent = MockData.events.any((e) => e.startDate.year == date.year && e.startDate.month == date.month && e.startDate.day == date.day);
                final isSelected = _selectedDay?.day == dayNum && _selectedDay?.month == _selectedMonth.month;
                final isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedDay = date),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.macedonianRed : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: isToday ? Border.all(color: AppColors.gold, width: 1.5) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$dayNum', style: TextStyle(color: isSelected ? AppColors.white : AppColors.lightGrey, fontSize: 14, fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
                          if (hasEvent) Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(shape: BoxShape.circle,
                              color: isSelected ? AppColors.white : AppColors.macedonianRed)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDayEvents(String lang) {
    final dayEvents = MockData.events.where((e) =>
      _selectedDay != null && e.startDate.year == _selectedDay!.year && e.startDate.month == _selectedDay!.month && e.startDate.day == _selectedDay!.day).toList();

    if (dayEvents.isEmpty) return Center(child: Text(lang == 'mk' ? 'Нема настани' : 'No events on this day', style: const TextStyle(color: AppColors.grey)));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: dayEvents.length,
      itemBuilder: (context, i) {
        final event = dayEvents[i];
        return ListTile(
          onTap: () => context.push('/events/${event.eventId}'),
          leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.event, color: AppColors.macedonianRed)),
          title: Text(event.getTitle(lang), style: const TextStyle(color: AppColors.white)),
          subtitle: Text(event.venue, style: const TextStyle(color: AppColors.grey, fontSize: 12)),
          trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
        );
      },
    );
  }
}
