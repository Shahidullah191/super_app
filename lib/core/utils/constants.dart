/// Application constants.
class AppConstants {
  AppConstants._();

  // ── Storage Keys ──────────────────────────────────────────────────────────────
  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';
  static const String themeKey = 'app_theme';

  // ── API ───────────────────────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ── Pagination ────────────────────────────────────────────────────────────────
  static const int pageSize = 20;

  // ── OTP ───────────────────────────────────────────────────────────────────────
  static const int otpLength = 6;
  static const int otpResendSeconds = 60;

  // ── Map ───────────────────────────────────────────────────────────────────────
  static const double defaultLatitude = 23.8103;
  static const double defaultLongitude = 90.4125;
  static const double defaultZoom = 14.0;
}
