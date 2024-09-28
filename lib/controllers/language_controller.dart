import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  // Method to set the language
  void setLanguage(String languageCode) async {
    // Save the selected language in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
    // Update the locale for GetX
    Get.updateLocale(Locale(languageCode));
  }
}
