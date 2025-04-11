import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/drug_constants.dart';
import '../../../../core/utils/app_style.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../view_model/drug_substitutions_cubit.dart';

class DrugSubstitutionScreen extends StatefulWidget {
  const DrugSubstitutionScreen({super.key});

  @override
  State<DrugSubstitutionScreen> createState() => _DrugSubstitutionScreenState();
}

class _DrugSubstitutionScreenState extends State<DrugSubstitutionScreen> {
  String? selectedDrug;  // متغير لتخزين الدواء المحدد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // استخدام DropdownButtonFormField بدلاً من DropdownButton
                DropdownButtonFormField<String>(
                  value: selectedDrug,
                  hint: const Text('Select Drug'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDrug = newValue;
                    });
                  },
                  isExpanded: true,  // لجعل القائمة تأخذ العرض الكامل
                  decoration: const InputDecoration(

                  ),
                  items: drugs.map<DropdownMenuItem<String>>((String drug) {
                    return DropdownMenuItem<String>(
                      value: drug,
                      child: Text(drug),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Button(
                  onClick: () {
                    context.read<DrugSubstitutionsCubit>().getDrugSubstitutions(
                      selectedDrug!, // إرسال الدواء المحدد
                    );
                  },
                  text: 'Get Substitutions',
                ),
                const SizedBox(height: 20),
                BlocBuilder<DrugSubstitutionsCubit, DrugSubstitutionsState>(
                  builder: (context, state) {
                    if (state is DrugSubstitutionsLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is DrugSubstitutionsSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Substitutions for ${selectedDrug!}:'),
                          ...state.response.result.split(',').map((substitution) {
                            return ListTile(
                              title: Text(substitution.trim()), // عرض كل اسم مفصول بفاصلة
                            );
                          }).toList(),
                        ],
                      );
                    } else if (state is DrugSubstitutionsError) {
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
