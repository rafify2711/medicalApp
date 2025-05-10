import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  Future<void> _changeLanguage(BuildContext context, String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    
    // Restart the app to apply the new language
    // You might want to implement a proper app restart mechanism
    // This is a simple example
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
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