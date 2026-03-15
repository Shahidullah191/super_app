class AppValidators {
  AppValidators._();

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final cleaned = value.replaceAll(RegExp(r'\s+'), '');
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(cleaned)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != original) return 'Passwords do not match';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) return 'OTP is required';
    if (value.length < 4) return 'Enter a valid OTP';
    return null;
  }

  static String? required(String? value, {String field = 'Field'}) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }
}
