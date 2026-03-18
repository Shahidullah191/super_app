import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── Token ──────────────────────────────────────────────────────────────────
  static Future<void> saveToken(String token) =>
      _prefs.setString(AppConstants.tokenKey, token);

  static String? getToken() => _prefs.getString(AppConstants.tokenKey);

  static Future<void> clearToken() => _prefs.remove(AppConstants.tokenKey);

  // ── User ───────────────────────────────────────────────────────────────────
  static Future<void> saveUser(String userJson) =>
      _prefs.setString(AppConstants.userKey, userJson);

  static String? getUser() => _prefs.getString(AppConstants.userKey);

  static Future<void> clearUser() => _prefs.remove(AppConstants.userKey);

  // ── Clear All ──────────────────────────────────────────────────────────────
  static Future<void> clearAll() => _prefs.clear();

  // ── Generic ────────────────────────────────────────────────────────────────
  static bool get isLoggedIn =>
      _prefs.containsKey(AppConstants.tokenKey) &&
      _prefs.getString(AppConstants.tokenKey) != null &&
      _prefs.getString(AppConstants.tokenKey)!.isNotEmpty;

  // ── Onboarding ─────────────────────────────────────────────────────────────
  static bool get hasSeenOnboarding =>
      _prefs.getBool(AppConstants.onboardingKey) ?? false;

  static Future<void> setSeenOnboarding() =>
      _prefs.setBool(AppConstants.onboardingKey, true);
}
