import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/button.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';

class ViewScheduleScreen extends StatelessWidget {
  final List<ScheduleModel>? schedule;

  const ViewScheduleScreen({Key? key, this.schedule}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: 'My Schedule'),
      body: schedule == null || schedule!.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 64,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No schedule available',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 24),
                  Button(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorScheduleScreen(),
                        ),
                      );
                    },
                    text: 'Add Schedule',
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: schedule!.length,
                    itemBuilder: (context, index) {
                      final scheduleItem = schedule![index];
                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    _formatDate(scheduleItem.date!),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: scheduleItem.timeSlots!
                                    .map((timeSlot) => Chip(
                                          label: Text(
                                            timeSlot,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: AppColors.primary,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Button(
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorScheduleScreen(),
                        ),
                      );
                    },
                    text: 'Add More Slots',
                  ),
                ),
              ],
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 