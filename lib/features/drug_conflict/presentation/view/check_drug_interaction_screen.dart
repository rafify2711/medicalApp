import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/drug_constants.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../view_model/check_drug_interaction_cubit.dart';

class CheckDrugInteractionScreen extends StatefulWidget {
  const CheckDrugInteractionScreen({super.key});
  static const routeName = 'check_drug_interaction_screen';

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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selectedDrug1,
                  decoration: const InputDecoration(labelText: 'Drug 1'),
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
                      return 'Please select a drug';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDrug2,
                  decoration: const InputDecoration(labelText: 'Drug 2',),
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
                      return 'Please select a drug';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Button(
                  onClick: () {
                    if (selectedDrug1 != null && selectedDrug2 != null) {
                      context.read<CheckDrugInteractionCubit>().checkDrugInteraction(
                        selectedDrug1!,
                        selectedDrug2!,
                      );
                    } else {
                      // Show an error if no drugs are selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select both drugs')),
                      );
                    }
                  },text:'Check Interaction' ,
                ),
                const SizedBox(height: 20),
                BlocBuilder<CheckDrugInteractionCubit, CheckDrugInteractionState>(
                  builder: (context, state) {
                    if (state is CheckDrugInteractionLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is CheckDrugInteractionSuccess) {
                      return Text(state.response.result,style: AppStyle.bodyCyanTextStyle.copyWith(fontSize: 20));
                    } else if (state is CheckDrugInteractionError) {
                      return Text(state.message, style: const TextStyle(color: Colors.red));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
