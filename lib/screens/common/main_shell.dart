import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../providers/app_state.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final lang = appState.language;

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.warmCard,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(context, 0, Icons.home_rounded, lang == 'mk' ? 'Дома' : 'Home', '/home'),
                _navItem(context, 1, Icons.explore_rounded, lang == 'mk' ? 'Откриј' : 'Discover', '/discover'),
                _navItem(context, 2, Icons.event_rounded, lang == 'mk' ? 'Настани' : 'Events', '/events'),
                _navItem(context, 3, Icons.play_circle_rounded, lang == 'mk' ? 'Медиуми' : 'Media', '/media'),
                _navItem(context, 4, Icons.menu_rounded, lang == 'mk' ? 'Повеќе' : 'More', '/more'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData icon, String label, String route) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isSelected = currentLocation.startsWith(route);
    final appState = Provider.of<AppState>(context, listen: false);

    return GestureDetector(
      onTap: () {
        appState.setTabIndex(index);
        context.go(route);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary.withOpacity(0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primary : AppColors.lightGrey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
