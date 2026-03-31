import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Page 1 items
  static const List<_GridItem> _page1Items = [
    _GridItem(icon: Icons.business, label: 'Businesses', route: '/discover/businesses'),
    _GridItem(icon: Icons.people, label: 'Community &\nOrganisations', route: '/discover/organisations'),
    _GridItem(icon: Icons.newspaper, label: 'Latest News', route: '/media/news'),
    _GridItem(icon: Icons.tv, label: 'Macedonian\nTV', route: '/media/tv'),
    _GridItem(icon: Icons.radio, label: 'Macedonian\nRadios', route: '/media/radio'),
    _GridItem(icon: Icons.play_circle_filled, label: 'Appski TV\nSeries', route: '/media/tv-series'),
    _GridItem(icon: Icons.event, label: 'Events', route: '/events', badgeCount: 2),
    _GridItem(icon: Icons.restaurant, label: 'Cooking', route: '/discover/recipes'),
    _GridItem(icon: Icons.explore, label: 'Tourism\nMacedonia', route: '/discover/tourism'),
  ];

  // Page 2 items
  static const List<_GridItem> _page2Items = [
    _GridItem(icon: Icons.church, label: 'Orthodox\nCalendar', route: '/more/calendar'),
    _GridItem(icon: Icons.quiz, label: 'Quiz', route: '/more/quiz'),
    _GridItem(icon: Icons.sentiment_very_satisfied, label: 'Jokes', route: '/more/jokes'),
    _GridItem(icon: Icons.description, label: 'Documents', route: '/more/documents'),
    _GridItem(icon: Icons.currency_exchange, label: 'Currency\nConverter', route: '/more/currency'),
    _GridItem(icon: Icons.wb_sunny, label: 'Weather', route: '/more/weather'),
    _GridItem(icon: Icons.music_note, label: 'Lyrics', route: '/more/lyrics'),
    _GridItem(icon: Icons.card_giftcard, label: 'Gift shop', route: '/more/giftshop'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B7B6B),
              Color(0xFFA08070),
              Color(0xFFB08878),
              Color(0xFF9E6B5E),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                      onPressed: () => context.push('/more'),
                    ),
                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Welcome to Appski',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Connecting the Macedonian People',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white, size: 28),
                      onPressed: () => context.push('/search'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Grid Pages
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) => setState(() => _currentPage = page),
                  children: [
                    _buildGrid(_page1Items),
                    _buildGrid(_page2Items),
                  ],
                ),
              ),

              // Page indicator dots
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(2, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                      ),
                    );
                  }),
                ),
              ),

              // Ad banner at bottom
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                color: const Color(0xFFFFD700),
                child: const Text(
                  'Rockdale Mattress Factory - Mattresses Experts',
                  style: TextStyle(
                    color: Color(0xFF8B0000),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<_GridItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => context.push(item.route),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, color: Colors.white, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Badge
                if (item.badgeCount > 0)
                  Positioned(
                    top: -6,
                    right: -6,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${item.badgeCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GridItem {
  final IconData icon;
  final String label;
  final String route;
  final int badgeCount;

  const _GridItem({
    required this.icon,
    required this.label,
    required this.route,
    this.badgeCount = 0,
  });
}
