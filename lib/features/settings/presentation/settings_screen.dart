import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/localization/app_localizations.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/core/utils/widgets/language_selector.dart';
import 'package:graduation_medical_app/core/di/di.dart';
import 'package:graduation_medical_app/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:graduation_medical_app/core/theme/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/route_names.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Future<void> _handleLogout(BuildContext context) async {
    final authLocalDataSource = getIt<AuthLocalDataSource>();
    await authLocalDataSource.logout();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.welcome,
        (route) => false,
      );
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Colors.grey, size: 28),
              SizedBox(width: 8),
              Text(
                AppLocalizations.of(context).logout,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).logoutConfirmation,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).logoutWarning,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocalizations.of(context).cancel,
                style: TextStyle(
                  color: AppColors.primary1,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _handleLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                AppLocalizations.of(context).logout,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      },
    );
  }

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
              AppLocalizations.of(context).theme,
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  return SwitchListTile(
                    value: themeMode == ThemeMode.dark,
                    activeColor: AppColors.primary1,
                    title: Text(
                      themeMode == ThemeMode.dark 
                          ? AppLocalizations.of(context).darkMode 
                          : AppLocalizations.of(context).lightMode,
                      style: const TextStyle(
                        color: AppColors.primary1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (value) {
                      context.read<ThemeCubit>().setTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  );
                },
              ),
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
            _buildSection(
              context,
              AppLocalizations.of(context).account,
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.grey),
                title: Text(
                  AppLocalizations.of(context).logout,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () => _showLogoutConfirmation(context),
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