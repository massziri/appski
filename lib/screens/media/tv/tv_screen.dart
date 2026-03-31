import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_theme.dart';
import '../../../providers/app_state.dart';
import '../../../services/mock_data.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});
  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedChannel = 0;

  // News channels data matching the screenshot
  static const List<_NewsChannel> _newsChannels = [
    _NewsChannel(name: 'Сител Дневник', hasGuide: true),
    _NewsChannel(name: 'Телма Вести', hasGuide: true),
    _NewsChannel(name: '24 Вести', hasGuide: true),
    _NewsChannel(name: 'Алфа Вести', hasGuide: true),
    _NewsChannel(name: 'МТМ Вести', hasGuide: false),
    _NewsChannel(name: 'Alsat Вести', hasGuide: true),
    _NewsChannel(name: 'ОРБИС Вести', hasGuide: false),
    _NewsChannel(name: 'Сонце Вести', hasGuide: false),
    _NewsChannel(name: 'Intel Вести', hasGuide: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppState>(context).language;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text('TV Makedonija', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD4A843),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          isScrollable: false,
          labelStyle: const TextStyle(fontSize: 11),
          tabs: const [
            Tab(icon: Icon(Icons.tv, size: 20), text: 'ТВ'),
            Tab(icon: Icon(Icons.article, size: 20), text: 'Вести'),
            Tab(icon: Icon(Icons.play_circle, size: 20), text: 'YouTube'),
            Tab(icon: Icon(Icons.videocam, size: 20), text: 'Камери'),
            Tab(icon: Icon(Icons.settings, size: 20), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ТВ Tab - TV channels
          _buildTvChannelsList(lang),
          // Вести Tab - News channels
          _buildNewsChannelsList(),
          // YouTube Tab
          _buildComingSoon('YouTube', Icons.play_circle),
          // Камери Tab
          _buildComingSoon('Камери', Icons.videocam),
          // Settings Tab
          _buildComingSoon('Settings', Icons.settings),
        ],
      ),
    );
  }

  Widget _buildTvChannelsList(String lang) {
    return ListView.builder(
      itemCount: MockData.tvChannels.length,
      itemBuilder: (context, index) {
        final ch = MockData.tvChannels[index];
        final isSelected = index == _selectedChannel;
        return GestureDetector(
          onTap: () => setState(() => _selectedChannel = index),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? Border.all(color: const Color(0xFFD4A843), width: 1) : null,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    ch.logoUrl,
                    width: 44, height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 44, height: 44,
                      color: Colors.grey[800],
                      child: const Icon(Icons.tv, color: Colors.white54, size: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    ch.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // TV Guide badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFD4A843), Color(0xFFB8860B)]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'TV\nGUIDE',
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewsChannelsList() {
    return ListView.builder(
      itemCount: _newsChannels.length,
      itemBuilder: (context, index) {
        final ch = _newsChannels[index];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.article, color: Colors.white54, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  ch.name,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              if (ch.hasGuide)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFD4A843), Color(0xFFB8860B)]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'TV\nGUIDE',
                    style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildComingSoon(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white38, size: 64),
          const SizedBox(height: 16),
          Text('$title Coming Soon', style: const TextStyle(color: Colors.white54, fontSize: 18)),
        ],
      ),
    );
  }
}

class _NewsChannel {
  final String name;
  final bool hasGuide;
  const _NewsChannel({required this.name, required this.hasGuide});
}
