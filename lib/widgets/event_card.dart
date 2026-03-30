import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../models/models.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final String lang;
  final VoidCallback onTap;
  final bool showCountdown;

  const EventCard({super.key, required this.event, required this.lang, required this.onTap, this.showCountdown = false});

  @override
  Widget build(BuildContext context) {
    final daysUntil = event.startDate.difference(DateTime.now()).inDays;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(event.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.darkText.withOpacity(0.8)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showCountdown && daysUntil > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.macedonianRed,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$daysUntil days away',
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                event.getTitle(lang),
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppColors.gold),
                  const SizedBox(width: 6),
                  Text(
                    DateFormat('MMM dd, yyyy • h:mm a').format(event.startDate),
                    style: const TextStyle(color: AppColors.bodyText, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: AppColors.gold),
                  const SizedBox(width: 6),
                  Text(
                    event.venue,
                    style: const TextStyle(color: AppColors.bodyText, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
