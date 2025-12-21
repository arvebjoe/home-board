import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_provider.dart';

/// Manages the app's current locale
class LocaleNotifier extends StateNotifier<Locale> {
  final Ref ref;
  
  LocaleNotifier(this.ref) : super(const Locale('en', '')) {
    _loadLocale();
  }

  static const String _localeKey = 'app_locale';

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString(_localeKey);
    if (localeCode != null) {
      state = Locale(localeCode);
    }
  }

  Future<void> setLocale(Locale locale, {bool saveToBackend = true}) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    
    // Save to backend if user is logged in
    if (saveToBackend) {
      try {
        final dio = ref.read(dioProvider);
        await dio.patch('/me/language', data: {
          'preferredLanguage': locale.languageCode,
        });
      } catch (e) {
        // Ignore errors when saving to backend (user might not be logged in)
      }
    }
  }
  
  Future<void> loadFromUser(String languageCode) async {
    state = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }
}

/// Provider for locale management
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});
