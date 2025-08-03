import 'package:shared_preferences/shared_preferences.dart';

class AppInitService {
  static Future<bool> hasSeenWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasSeenWelcome') ?? false;
  }

  static Future<void> setHasSeenWelcomePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcome', true);
  }
}
