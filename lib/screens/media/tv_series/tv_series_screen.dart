import 'package:flutter/material.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  static const List<_TvSeriesItem> _series = [
    _TvSeriesItem(
      title: 'MAKEDONSKI HAUS',
      imageUrl: 'https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?w=200',
    ),
    _TvSeriesItem(
      title: 'TVRDOKORNI',
      imageUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=200',
    ),
    _TvSeriesItem(
      title: 'MACEDONIAN MOVIES',
      imageUrl: 'https://images.unsplash.com/photo-1485846234645-a62644f84728?w=200',
    ),
    _TvSeriesItem(
      title: 'BUSAVA AZBUKA',
      imageUrl: 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?w=200',
    ),
    _TvSeriesItem(
      title: 'KURIROT NA GOCE',
      imageUrl: 'https://images.unsplash.com/photo-1580408384706-b1cb8bab1127?w=200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8B4513),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C3310),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              width: 28, height: 28,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: const Text('☀', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 8),
            const Text('Appski Tv Series', style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _series.length,
        itemBuilder: (context, index) {
          final item = _series[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(8),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80, height: 80,
                    color: Colors.grey[800],
                    child: const Icon(Icons.movie, color: Colors.white54),
                  ),
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.white54, size: 28),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${item.title}...')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _TvSeriesItem {
  final String title;
  final String imageUrl;
  const _TvSeriesItem({required this.title, required this.imageUrl});
}
