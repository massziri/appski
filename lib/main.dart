import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'config/router.dart';
import 'providers/app_state.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const AppskiApp(),
    ),
  );
}

class AppskiApp extends StatelessWidget {
  const AppskiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Appski',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.warmTheme,
      routerConfig: appRouter,
    );
  }
}
