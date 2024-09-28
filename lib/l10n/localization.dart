import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class Localization {
  static Map<String, String> _localizedStrings = {}; // Initialize as an empty map

  static Future<void> load(Locale locale) async {
    // Load the JSON file from the 'l10n' folder based on the locale
    String jsonString = await rootBundle.loadString('l10n/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString).cast<String, String>();
  }

  static String translate(String key) {
    return _localizedStrings[key] ?? key; // Return key if translation is not found
  }
}
