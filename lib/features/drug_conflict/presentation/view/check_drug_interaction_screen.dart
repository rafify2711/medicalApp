import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/drug_constants.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../view_model/check_drug_interaction_cubit.dart';

class CheckDrugInteractionScreen extends StatefulWidget {
  const CheckDrugInteractionScreen({super.key});

  @override
  State<CheckDrugInteractionScreen> createState() => _CheckDrugInteractionScreenState();
}

class _CheckDrugInteractionScreenState extends State<CheckDrugInteractionScreen> {
  final TextEditingController drug1Controller = TextEditingController();
  final TextEditingController drug2Controller = TextEditingController();

  String? selectedDrug1;
  String? selectedDrug2;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).checkDrugInteractions,
                style: AppStyle.bodyCyanTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context).selectTwoDrugs,
                style: AppStyle.bodyCyanTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedDrug1,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).firstDrug,
                        labelStyle: TextStyle(color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      items: drugs.map((drug) {
                        return DropdownMenuItem<String>(
                          value: drug,
                          child: Text(drug),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDrug1 = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).pleaseSelectDrug;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedDrug2,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).secondDrug,
                        labelStyle: TextStyle(color: AppColors.primary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primary),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      items: drugs.map((drug) {
                        return DropdownMenuItem<String>(
                          value: drug,
                          child: Text(drug),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDrug2 = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context).pleaseSelectDrug;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Button(
                onClick: () {
                  if (selectedDrug1 != null && selectedDrug2 != null) {
                    context.read<CheckDrugInteractionCubit>().checkDrugInteraction(
                      selectedDrug1!,
                      selectedDrug2!,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context).pleaseSelectBothDrugs),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                text: AppLocalizations.of(context).checkInteraction,
              ),
              const SizedBox(height: 24),
              BlocBuilder<CheckDrugInteractionCubit, CheckDrugInteractionState>(
                builder: (context, state) {
                  if (state is CheckDrugInteractionLoading) {
                    return Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context).checkingInteraction,
                            style: AppStyle.bodyCyanTextStyle.copyWith(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CheckDrugInteractionSuccess) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).interactionResult,
                            style: AppStyle.bodyCyanTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.response.result,
                            style: AppStyle.bodyCyanTextStyle.copyWith(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CheckDrugInteractionError) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red[400]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
