import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';
import '../../services/mock_data.dart';
import '../../widgets/section_header.dart';
import '../../widgets/news_card.dart';
import '../../widgets/event_card.dart';
import '../../widgets/business_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lang = appState.language;
    final todayCalendar = MockData.getTodayCalendar();

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 60,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.warmBg,
            title: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [AppColors.gold, AppColors.macedonianRed]),
                  ),
                  child: const Center(child: Text('☀', style: TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 10),
                Text('APPSKI', style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: 3)),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.white),
                onPressed: () => context.push('/search'),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: AppColors.white),
                onPressed: () => context.push('/notifications'),
              ),
            ],
          ),

          // Hero Banner Carousel
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: MockData.banners.length,
                itemBuilder: (context, index) {
                  final banner = MockData.banners[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(banner.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        lang == 'mk' ? banner.titleMk : banner.titleEn,
                        style: const TextStyle(color: AppColors.darkText, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Quick Access Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lang == 'mk' ? 'Брз Пристап' : 'Quick Access',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _quickAccessItem(context, Icons.store, lang == 'mk' ? 'Бизниси' : 'Business', '/discover/businesses'),
                      _quickAccessItem(context, Icons.restaurant_menu, lang == 'mk' ? 'Рецепти' : 'Recipes', '/discover/recipes'),
                      _quickAccessItem(context, Icons.radio, 'Радио', '/media/radio'),
                      _quickAccessItem(context, Icons.tv, 'ТВ', '/media/tv'),
                      _quickAccessItem(context, Icons.flight, lang == 'mk' ? 'Туризам' : 'Tourism', '/discover/tourism'),
                      _quickAccessItem(context, Icons.calendar_month, lang == 'mk' ? 'Календар' : 'Calendar', '/more/calendar'),
                      _quickAccessItem(context, Icons.event, lang == 'mk' ? 'Настани' : 'Events', '/events'),
                      _quickAccessItem(context, Icons.newspaper, lang == 'mk' ? 'Вести' : 'News', '/media/news'),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Today's Orthodox Calendar Entry
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.darkCard, AppColors.warmSurface],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gold.withOpacity(0.3)),
              ),
              child: InkWell(
                onTap: () => context.push('/more/calendar'),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('✝️', style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang == 'mk' ? 'Денешен Светец' : 'Today\'s Saint',
                            style: TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            todayCalendar.getSaints(lang).first,
                            style: const TextStyle(color: AppColors.darkText, fontSize: 14, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.gold),
                  ],
                ),
              ),
            ),
          ),

          // Weather Snapshot
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warmCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () => context.push('/more/weather'),
                child: Row(
                  children: [
                    const Text('⛅', style: TextStyle(fontSize: 36)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Skopje', style: TextStyle(color: AppColors.bodyText, fontSize: 12)),
                          Text('18°C', style: const TextStyle(color: AppColors.darkText, fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Text(lang == 'mk' ? 'Делумно Облачно' : 'Partly Cloudy',
                        style: TextStyle(color: AppColors.bodyText, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),

          // Latest News
          SliverToBoxAdapter(
            child: SectionHeader(
              title: lang == 'mk' ? 'Последни Вести' : 'Latest News',
              onSeeAll: () => context.push('/media/news'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= 3) return null;
                final article = MockData.news[index];
                return NewsCard(
                  article: article,
                  lang: lang,
                  onTap: () => context.push('/media/news/${article.newsId}'),
                );
              },
              childCount: 3,
            ),
          ),

          // Featured Event
          SliverToBoxAdapter(
            child: SectionHeader(
              title: lang == 'mk' ? 'Претстоен Настан' : 'Upcoming Event',
              onSeeAll: () => context.go('/events'),
            ),
          ),
          SliverToBoxAdapter(
            child: EventCard(
              event: MockData.events.first,
              lang: lang,
              onTap: () => context.push('/events/${MockData.events.first.eventId}'),
              showCountdown: true,
            ),
          ),

          // Featured Businesses
          SliverToBoxAdapter(
            child: SectionHeader(
              title: lang == 'mk' ? 'Истакнати Бизниси' : 'Featured Businesses',
              onSeeAll: () => context.push('/discover/businesses'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: MockData.businesses.length > 6 ? 6 : MockData.businesses.length,
                itemBuilder: (context, index) {
                  final biz = MockData.businesses[index];
                  return BusinessCard(
                    business: biz,
                    lang: lang,
                    onTap: () => context.push('/discover/businesses/${biz.businessId}'),
                    isHorizontal: true,
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  Widget _quickAccessItem(BuildContext context, IconData icon, String label, String route) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.warmCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.gold, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(color: AppColors.darkText, fontSize: 10, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
