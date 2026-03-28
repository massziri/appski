import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/mock_data.dart';
import '../../widgets/event_card.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final upcomingEvents = MockData.events.where((e) => e.startDate.isAfter(DateTime.now())).toList()
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(
        title: Text(lang == 'mk' ? 'Настани' : 'Events'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () => context.push('/events/calendar')),
          IconButton(icon: const Icon(Icons.history), onPressed: () => context.push('/events/past')),
        ],
      ),
      body: upcomingEvents.isEmpty
        ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.event_busy, size: 64, color: AppColors.lightGrey),
            const SizedBox(height: 16),
            Text(lang == 'mk' ? 'Нема претстојни настани' : 'No upcoming events', style: const TextStyle(color: AppColors.lightGrey, fontSize: 16)),
          ]))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: upcomingEvents.length,
            itemBuilder: (context, i) => EventCard(
              event: upcomingEvents[i],
              lang: lang,
              onTap: () => context.push('/events/${upcomingEvents[i].eventId}'),
              showCountdown: true,
            ),
          ),
    );
  }
}
