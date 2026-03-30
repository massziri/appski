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
      'subtitleMk': 'Вашиот македонски центар во Австралија',
      'icon': '🏠',
    },
    {
      'title': 'Stay Connected',
      'titleMk': 'Останете Поврзани',
      'subtitle': 'News, events, live radio & TV, business directory',
      'subtitleMk': 'Вести, настани, радио и ТВ во живо, бизнис директориум',
      'icon': '📱',
    },
    {
      'title': 'Preserve Our Heritage',
      'titleMk': 'Зачувајте го Наследството',
      'subtitle': 'Orthodox calendar, recipes, tourism guides',
      'subtitleMk': 'Православен календар, рецепти, туризам',
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
                        Text(page['icon']!, style: const TextStyle(fontSize: 72)),
                        const SizedBox(height: 32),
                        Text(
                          lang == 'mk' ? page['titleMk']! : page['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.darkText, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          lang == 'mk' ? page['subtitleMk']! : page['subtitle']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.bodyText, fontSize: 15),
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
                  color: _currentPage == i ? AppColors.primary : AppColors.warmSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
                child: Text(lang == 'mk' ? 'Прескокни' : 'Skip',
                  style: const TextStyle(color: AppColors.lightGrey)),
              ),
            const SizedBox(height: 16),
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
          color: selected ? AppColors.primary : AppColors.warmCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(
          color: selected ? AppColors.white : AppColors.darkText,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
      ),
    );
  }
}
