import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controls app language (locale) switching.
class LanguageController extends GetxController {
  static const _langKey = 'app_language';

  // 'en' or 'bn'
  final currentLang = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLang();
  }

  Future<void> _loadSavedLang() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_langKey) ?? 'en';
    currentLang.value = saved;
    _applyLocale(saved);
  }

  void switchToEnglish() => _switch('en');
  void switchToBengali() => _switch('bn');

  void toggleLanguage() {
    _switch(currentLang.value == 'en' ? 'bn' : 'en');
  }

  Future<void> _switch(String lang) async {
    currentLang.value = lang;
    _applyLocale(lang);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, lang);
  }

  void _applyLocale(String lang) {
    final locale = lang == 'bn'
        ? const Locale('bn', 'BD')
        : const Locale('en', 'US');
    Get.updateLocale(locale);
  }

  bool get isEnglish => currentLang.value == 'en';
  bool get isBengali => currentLang.value == 'bn';
}
