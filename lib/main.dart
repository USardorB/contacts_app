import 'package:contacts_app/core/router/app_router.dart';
import 'package:contacts_app/core/theme/app_theme.dart';
import 'package:contacts_app/core/theme/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseService.init();
  final themeService = ThemeService();
  await themeService.loadThemeMode();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final hasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (context) => themeService,
      child: MyApp(hasSeenWelcome: hasSeenWelcome),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool hasSeenWelcome;
  const MyApp({super.key, required this.hasSeenWelcome});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'Contacts App',
        routerConfig: AppRouter(hasSeenWelcome).router,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeService.themeMode,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
