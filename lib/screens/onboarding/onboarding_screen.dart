import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome to Appski',
      'titleMk': 'Добредојдовте во Appski',
      'subtitle': 'Your Macedonian Community Hub in Australia',
      'subtitleMk': 'Вашиот македонски центар на заедницата во Австралија',
      'icon': '🏠',
    },
    {
      'title': 'Stay Connected',
      'titleMk': 'Останете Поврзани',
      'subtitle': 'News, events, media streaming, and business directory all in one place',
      'subtitleMk': 'Вести, настани, медиуми и директориум на бизниси на едно место',
      'icon': '📱',
    },
    {
      'title': 'Preserve Our Heritage',
      'titleMk': 'Зачувајте го Наследството',
      'subtitle': 'Orthodox calendar, traditional recipes, tourism guides, and cultural content',
      'subtitleMk': 'Православен календар, традиционални рецепти, туристички водичи',
      'icon': '🏛️',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lang = appState.language;

    return Scaffold(
      backgroundColor: AppColors.warmBg,
      body: SafeArea(
        child: Column(
          children: [
            // Language toggle
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _languageButton('EN', lang == 'en', () => appState.setLanguage('en')),
                  const SizedBox(width: 8),
                  _languageButton('МК', lang == 'mk', () => appState.setLanguage('mk')),
                ],
              ),
            ),
            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(page['icon']!, style: const TextStyle(fontSize: 80)),
                        const SizedBox(height: 40),
                        Text(
                          lang == 'mk' ? page['titleMk']! : page['title']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          lang == 'mk' ? page['subtitleMk']! : page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == i ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == i ? AppColors.macedonianRed : AppColors.darkCard,
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
            const SizedBox(height: 40),
            // Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      appState.completeOnboarding();
                      context.go('/home');
                    }
                  },
                  child: Text(
                    _currentPage < 2
                      ? (lang == 'mk' ? 'Следно' : 'Next')
                      : (lang == 'mk' ? 'Започни' : 'Get Started'),
                  ),
                ),
              ),
            ),
            if (_currentPage < 2)
              TextButton(
                onPressed: () {
                  appState.completeOnboarding();
                  context.go('/home');
                },
                child: Text(
                  lang == 'mk' ? 'Прескокни' : 'Skip',
                  style: TextStyle(color: AppColors.lightGrey),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.macedonianRed : AppColors.darkCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.macedonianRed : AppColors.darkCard,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
