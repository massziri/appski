import 'package:flutter/material.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  int _currentPage = 0;

  static const List<List<String>> _pages = [
    [
      'Home Construction',
      'Holy Water',
      'High School Prank',
      'Having Children - Warnings!',
      'Hamster Trouble',
      'Growing up!',
      'Greatest Hitter',
    ],
    [
      'Golf Lessons',
      'Getting Old',
      'Funny Signs',
      'Forrest Gump in Heaven',
      'Football Injury',
      'First Date',
      'Fire Truck',
    ],
  ];

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
              // App Bar
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Container(
                      width: 28, height: 28,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Text('☀', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(width: 8),
                    const Text('Jokes', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // Page Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _currentPage = index),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Page ${index + 1}',
                        style: TextStyle(
                          color: _currentPage == index ? Colors.white : Colors.white54,
                          fontSize: 16,
                          fontWeight: _currentPage == index ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 16),

              // Joke list
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _pages[_currentPage].length,
                  separatorBuilder: (_, __) => Divider(color: Colors.white.withOpacity(0.2)),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _pages[_currentPage][index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Opening "${_pages[_currentPage][index]}"...')),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
