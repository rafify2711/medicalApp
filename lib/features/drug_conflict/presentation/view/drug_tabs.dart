import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view_model/disease_drug_interaction_cubit.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/localization/app_localizations.dart';
import 'check_drug_interaction_screen.dart';  // استيراد شاشة تفاعل الأدوية
import 'disease_drug_interaction_screen.dart';
import 'drug_subsitiutions_screen.dart';  // استيراد شاشة البدائل

class DrugTabsScreen extends StatefulWidget {
  const DrugTabsScreen({super.key});

  @override
  State<DrugTabsScreen> createState() => _DrugTabsScreenState();
}

class _DrugTabsScreenState extends State<DrugTabsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: AppStyle.gradient,
          ),
        ),
        title: Text(
          AppLocalizations.of(context).drugInteraction,
          style: const TextStyle(
            fontSize: 24,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          dividerColor: AppColors.white,
          labelColor: AppColors.white,
          indicatorColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.7),
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.medication),
              text: AppLocalizations.of(context).drugInteraction,
            ),
            Tab(
              icon: const Icon(Icons.medical_services),
              text: AppLocalizations.of(context).drugDisease,
            ),
            Tab(
              icon: const Icon(Icons.swap_horiz),
              text: AppLocalizations.of(context).substitutions,
            ),
          ],
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
        child: TabBarView(
          controller: _tabController,
          children: const [
            CheckDrugInteractionScreen(),
            DiseaseDrugInteractionScreen(),
            DrugSubstitutionScreen(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
