import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _fadeController;
  Animation<double>? _fadeAnimation;

  /// true  = first-ever launch → show the splash artwork
  /// false = returning user   → show nothing, navigate immediately
  /// null  = still checking SharedPreferences
  bool? _shouldShowSplash;

  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenSplash = prefs.getBool('has_seen_splash') ?? false;

    if (hasSeenSplash) {
      // ── Returning user: skip splash entirely ──
      if (mounted) context.go('/home');
      return;
    }

    // ── First-time user: show splash once, then mark as seen ──
    if (!mounted) return;

    setState(() => _shouldShowSplash = true);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController!, curve: Curves.easeIn),
    );
    _fadeController!.forward();

    await prefs.setBool('has_seen_splash', true);
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) context.go('/promo');
  }

  @override
  void dispose() {
    _fadeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While checking prefs OR returning user → blank gold screen (no artwork)
    if (_shouldShowSplash != true) {
      return const Scaffold(
        backgroundColor: Color(0xFFF2C65F),
        body: SizedBox.shrink(),
      );
    }

    // First-time user → full animated splash
    return Scaffold(
      backgroundColor: const Color(0xFFF2C65F),
      body: FadeTransition(
        opacity: _fadeAnimation!,
        child: SizedBox.expand(
          child: Image.asset(
            'assets/images/branding/appski_splash_new.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFF5E6C8),
              child: const Center(
                child: Text(
                  'APPSKI',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC41E3A),
                    letterSpacing: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
