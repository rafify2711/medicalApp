import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/core/utils/widgets/language_selector.dart';

import '../../../core/config/route_names.dart';

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView(
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
                activeColor: AppColors.primary1,
                onChanged: (value) {
                  // Handle notifications toggle
                },
              ),
            ),
            _buildSection(
              context,
              AppLocalizations.of(context).changePassword,
              ListTile(
                leading: const Icon(Icons.lock_outline, color: AppColors.primary1),
                title: Text(
                  AppLocalizations.of(context).changePassword,
                  style: const TextStyle(
                    color: AppColors.primary1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary1),
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.changePassword);
                },
              ),
            ),
          ],
        ),
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
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: child,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
} 