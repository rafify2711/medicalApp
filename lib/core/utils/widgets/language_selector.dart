import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  Future<void> _changeLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    
    // Update the app's locale immediately
    if (context.mounted) {
      final state = MyApp.appStateKey.currentState;
      if (state != null) {
        state.changeLanguage(Locale(languageCode));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('English'),
          onTap: () => _changeLanguage(context, 'en'),
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('العربية'),
          onTap: () => _changeLanguage(context, 'ar'),
        ),
      ],
    );
  }
} 