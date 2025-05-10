import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/core/utils/widgets/language_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).settings,
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSection(
            context,
            AppLocalizations.of(context).language,
            const LanguageSelector(),
          ),
          _buildSection(
            context,
            AppLocalizations.of(context).notifications,
            SwitchListTile(
              value: true,
              onChanged: (value) {
                // Handle notifications toggle
              },
            ),
          ),
          _buildSection(
            context,
            AppLocalizations.of(context).theme,
            SwitchListTile(
              value: false,
              onChanged: (value) {
                // Handle theme toggle
              },
            ),
          ),
          _buildSection(
            context,
            AppLocalizations.of(context).about,
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to about screen
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primary1,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: child,
        ),
        const Divider(height: 1),
      ],
    );
  }
} 