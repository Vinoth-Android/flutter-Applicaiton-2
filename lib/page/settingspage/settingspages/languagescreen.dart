import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language {
  final String nativeName;
  final String code;

  Language(this.nativeName, this.code);
}

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedPosition = -1;
  String selectedLanguage = "ta";

  final List<Language> languages = [
    Language("తెలుగు", "te"),
    Language("தமிழ்", "ta"),
    Language("हिंदी", "hi"),
    Language("ગુજરાતી", "gu"),
    Language("मराठी", "mr"),
    Language("ಕನ್ನಡ", "kn"),
    Language("മലയാളം", "ml"),
    Language("বাংলা", "bn"),
    Language("ਪੰਜਾਬੀ", "pa"),
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('selectedLanguage');
    if (lang != null) {
      int index = languages.indexWhere((language) => language.code == lang);
      if (index != -1) {
        setState(() {
          selectedPosition = index;
          selectedLanguage = lang;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'), // Hardcoded title
        actions: [
          TextButton(
            onPressed: () {
              if (selectedLanguage.isNotEmpty) {
                _changeLocale(selectedLanguage);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          "Selected language: ${languages[selectedPosition].nativeName}")),
                );
              }
            },
            child: Text(
              'Save', // Hardcoded 'Save' text
              style: const TextStyle(
                color: Color.fromARGB(255, 12, 129, 231),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: index,
                  groupValue: selectedPosition,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languages[index].nativeName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        languages[index].code, // Display the language code
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedPosition = index;
                      selectedLanguage = languages[index].code;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeLocale(String lang) async {
    Locale locale = Locale(lang);
    Get.updateLocale(locale); // Update the locale using GetX

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', lang);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Language changed to: $lang")),
    );
  }
}
