import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/mock_data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;
    return Scaffold(
      backgroundColor: AppColors.warmBg,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: (v) => setState(() => _query = v),
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: lang == 'mk' ? 'Пребарај...' : 'Search...',
            border: InputBorder.none, hintStyle: const TextStyle(color: AppColors.lightGrey),
          ),
        ),
      ),
      body: _query.isEmpty
        ? Center(child: Text(lang == 'mk' ? 'Пребарајте бизниси, настани, вести...' : 'Search businesses, events, news...',
            style: const TextStyle(color: AppColors.lightGrey)))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...MockData.businesses.where((b) => b.nameEn.toLowerCase().contains(_query.toLowerCase()) || b.nameMk.toLowerCase().contains(_query.toLowerCase())).map((b) =>
                ListTile(
                  leading: const Icon(Icons.store, color: AppColors.gold),
                  title: Text(b.getName(lang), style: const TextStyle(color: AppColors.white)),
                  subtitle: Text(b.category, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                  onTap: () => context.push('/discover/businesses/${b.businessId}'),
                )),
              ...MockData.events.where((e) => e.titleEn.toLowerCase().contains(_query.toLowerCase()) || e.titleMk.toLowerCase().contains(_query.toLowerCase())).map((e) =>
                ListTile(
                  leading: const Icon(Icons.event, color: AppColors.macedonianRed),
                  title: Text(e.getTitle(lang), style: const TextStyle(color: AppColors.white)),
                  subtitle: Text(e.venue, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                  onTap: () => context.push('/events/${e.eventId}'),
                )),
              ...MockData.news.where((n) => n.titleEn.toLowerCase().contains(_query.toLowerCase()) || n.titleMk.toLowerCase().contains(_query.toLowerCase())).map((n) =>
                ListTile(
                  leading: const Icon(Icons.newspaper, color: AppColors.info),
                  title: Text(n.getTitle(lang), style: const TextStyle(color: AppColors.white)),
                  subtitle: Text(n.category, style: const TextStyle(color: AppColors.lightGrey, fontSize: 11)),
                  onTap: () => context.push('/media/news/${n.newsId}'),
                )),
            ],
          ),
    );
  }
}
