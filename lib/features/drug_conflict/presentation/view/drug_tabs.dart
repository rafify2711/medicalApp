import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/drug_conflict/presentation/view_model/disease_drug_interaction_cubit.dart';
import '../../../../core/utils/app_style.dart';
import 'check_drug_interaction_screen.dart';  // استيراد شاشة تفاعل الأدوية
import 'disease_drug_interaction_screen.dart';
import 'drug_subsitiutions_screen.dart';  // استيراد شاشة البدائل

class DrugTabsScreen extends StatefulWidget {
  const DrugTabsScreen({super.key});
  static const routeName = 'drug_tabs';

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
      appBar: AppBar(flexibleSpace: Container(
        decoration:  BoxDecoration(
        gradient: AppStyle.gradient,
        ),),
        title: const Text('Drug Interaction'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Drug Interaction'),
            Tab(text: 'Drug-Disease Interaction'),
            Tab(text: 'Substitutions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CheckDrugInteractionScreen(),  // شاشة تفاعل الأدوية
          DiseaseDrugInteractionScreen(),  // شاشة تفاعل الأدوية مع الأمراض
          DrugSubstitutionScreen(),  // شاشة البدائل
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
