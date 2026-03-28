import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/mock_data.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    final appState = Provider.of<AppState>(context);
    final event = MockData.events.firstWhere((e) => e.eventId == eventId, orElse: () => MockData.events.first);
    final daysUntil = event.startDate.difference(DateTime.now()).inDays;
    final isFav = appState.favoriteEvents.contains(eventId);

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(expandedHeight: 300, pinned: true,
            actions: [
              IconButton(icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border, color: AppColors.gold),
                onPressed: () => appState.toggleFavoriteEvent(eventId)),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(event.imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: AppColors.warmSurface)),
                Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)]))),
                if (daysUntil > 0) Positioned(top: 100, left: 0, right: 0, child: Center(
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(color: AppColors.macedonianRed.withOpacity(0.9), borderRadius: BorderRadius.circular(16)),
                    child: Column(children: [
                      Text('$daysUntil', style: const TextStyle(color: AppColors.darkText, fontSize: 36, fontWeight: FontWeight.bold)),
                      Text(lang == 'mk' ? 'дена до настанот' : 'days to go', style: const TextStyle(color: AppColors.darkText, fontSize: 12)),
                    ]),
                  ),
                )),
              ],
            ))),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.getTitle(lang), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 16),
                  _detailTile(Icons.calendar_today, lang == 'mk' ? 'Датум' : 'Date',
                    DateFormat('EEEE, MMMM d, yyyy').format(event.startDate)),
                  _detailTile(Icons.access_time, lang == 'mk' ? 'Време' : 'Time',
                    '${DateFormat('h:mm a').format(event.startDate)} - ${DateFormat('h:mm a').format(event.endDate)}'),
                  _detailTile(Icons.location_on, lang == 'mk' ? 'Место' : 'Venue', event.venue),
                  _detailTile(Icons.map, lang == 'mk' ? 'Адреса' : 'Address', event.venueAddress),
                  _detailTile(Icons.person, lang == 'mk' ? 'Организатор' : 'Organiser', event.organiserName),
                  const SizedBox(height: 20),
                  Text(lang == 'mk' ? 'За настанот' : 'About', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Text(event.getDescription(lang), style: const TextStyle(color: AppColors.bodyText, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 24),
                  // Map placeholder
                  Container(height: 180, decoration: BoxDecoration(color: AppColors.warmCard, borderRadius: BorderRadius.circular(16)),
                    child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.map, size: 48, color: AppColors.lightGrey), SizedBox(height: 8),
                      Text('Venue Map', style: TextStyle(color: AppColors.lightGrey)),
                    ]))),
                  const SizedBox(height: 24),
                  // RSVP Buttons
                  Row(children: [
                    Expanded(child: ElevatedButton.icon(
                      onPressed: () {}, icon: const Icon(Icons.check_circle),
                      label: Text(lang == 'mk' ? 'Одам' : 'Going'),
                    )),
                    const SizedBox(width: 8),
                    Expanded(child: OutlinedButton.icon(
                      onPressed: () {}, icon: const Icon(Icons.star_border),
                      label: Text(lang == 'mk' ? 'Заинтересиран' : 'Interested'),
                    )),
                  ]),
                  const SizedBox(height: 12),
                  if (event.ticketUrl.isNotEmpty)
                    SizedBox(width: double.infinity, child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold),
                      onPressed: () async { try { await launchUrl(Uri.parse(event.ticketUrl)); } catch (_) {} },
                      icon: const Icon(Icons.confirmation_number, color: AppColors.warmBg),
                      label: Text(lang == 'mk' ? 'Купи Билет' : 'Get Tickets', style: const TextStyle(color: AppColors.warmBg)),
                    )),
                  const SizedBox(height: 16),
                  // Share buttons
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    _socialButton(Icons.facebook, 'Facebook', AppColors.info),
                    const SizedBox(width: 16),
                    _socialButton(Icons.camera_alt, 'Instagram', AppColors.macedonianRed),
                    const SizedBox(width: 16),
                    _socialButton(Icons.share, lang == 'mk' ? 'Сподели' : 'Share', AppColors.gold),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailTile(IconData icon, String label, String value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 20, color: AppColors.gold),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: AppColors.darkText, fontSize: 14)),
        ])),
      ]));
  }

  Widget _socialButton(IconData icon, String label, Color color) {
    return Column(children: [
      Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
        child: Icon(icon, color: color, size: 24)),
      const SizedBox(height: 6),
      Text(label, style: TextStyle(color: color, fontSize: 10)),
    ]);
  }
}
