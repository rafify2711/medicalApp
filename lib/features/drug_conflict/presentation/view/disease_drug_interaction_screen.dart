import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/drug_constants.dart';
import '../view_model/disease_drug_interaction_cubit.dart';

class DiseaseDrugInteractionScreen extends StatefulWidget {
  const DiseaseDrugInteractionScreen({super.key});
  static const routeName = 'disease_drug_interaction_screen.dart';

  @override
  State<DiseaseDrugInteractionScreen> createState() => _DiseaseDrugInteractionScreenState();
}

class _DiseaseDrugInteractionScreenState extends State<DiseaseDrugInteractionScreen> {
  final TextEditingController drugController = TextEditingController();
  final TextEditingController diseaseController = TextEditingController();
  String? selectedDrug;
  String? selectedDisease;

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
                  value: selectedDrug,
                  decoration: const InputDecoration(labelText: 'Select Drug'),
                  items: drugs.map((drug) {
                    return DropdownMenuItem<String>(
                      value: drug,
                      child: Text(drug),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDrug = value;
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
                  value: selectedDisease,
                  decoration: const InputDecoration(labelText: 'Select Disease'),
                  items: diseases.map((disease) {
                    return DropdownMenuItem<String>(
                      value: disease,
                      child: Text(disease),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDisease = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a disease';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedDrug != null && selectedDisease != null) {
                      context.read<DiseaseDrugInteractionCubit>().checkDiseaseDrugInteraction(
                          selectedDrug!, selectedDisease!
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select both drug and disease')),
                      );
                    }
                  },
                  child: const Text('Check Interaction'),
                ),
                const SizedBox(height: 20),
                BlocBuilder<DiseaseDrugInteractionCubit, DiseaseDrugInteractionState>(
                  builder: (context, state) {
                    if (state is DiseaseDrugInteractionLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is DiseaseDrugInteractionSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interaction Result:'),
                          Text(state.response.result),
                        ],
                      );
                    } else if (state is DiseaseDrugInteractionError) {
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
