import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/reservation/data/models/add_update_schedule_response.dart';
import '../../../auth/presentation/view/widgets/button.dart';
import '../view_model/add_update_schedule_cubit.dart';
import '../view_model/add_update_schedule_state.dart';

class DoctorScheduleScreen extends StatefulWidget {
  static const routeName = 'add_doctor_schedule';

  @override
  _DoctorScheduleScreenState createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  AddUpdateScheduleData addUpdateScheduleData = AddUpdateScheduleData(schedule: []);
  int? _editingIndex;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _addAppointment() {
    final combinedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final formattedTime = _formatTime(combinedDateTime);

    bool dateExists = false;
    for (var scheduleItem in addUpdateScheduleData.schedule) {
      if (_isSameDay(scheduleItem.date!, combinedDateTime)) {
        dateExists = true;
        scheduleItem.timeSlots?.add(formattedTime);
        break;
      }
    }

    if (!dateExists) {
      addUpdateScheduleData.schedule.add(
        ScheduleData(
          date: combinedDateTime,
          timeSlots: [formattedTime],
        ),
      );
    }

    setState(() {});
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime date) {
    final time = TimeOfDay.fromDateTime(date);
    return time.format(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScheduleCubit, ScheduleState>(
      listener: (context, state) {
        if (state is ScheduleLoading) {
          // Show loading indicator
        } else if (state is ScheduleSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Schedule saved successfully')),
          );
        } else if (state is ScheduleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: MyAppPar(title: 'Schedule'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Selected Date: ${_formatDate(selectedDate)}',
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              ),
              Text(
                'Selected Time: ${selectedTime.format(context)}',
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onClick: () => _selectDate(context),
                      text: 'Pick Date',
                    ),
                    const SizedBox(width: 16),
                    Button(
                      onClick: () => _selectTime(context),
                      text: 'Pick Time',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Button(
                onClick: _addAppointment,
                text: 'Add to schedule',
              ),
              const SizedBox(height: 20),
              Text('Schedule:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              Expanded(
                child: ListView.builder(
                  itemCount: addUpdateScheduleData.schedule.length,
                  itemBuilder: (context, index) {
                    final scheduleItem = addUpdateScheduleData.schedule[index];
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(_formatDate(scheduleItem.date!)),
                      subtitle: Text(scheduleItem.timeSlots?.join(', ') ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            addUpdateScheduleData.schedule.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Button(
                onClick: () async {
                  final token = '';
                  final userId = '';

                  // تحويل البيانات إلى نموذج AddUpdateScheduleData
                  final scheduleToSend = AddUpdateScheduleData(
                    schedule: addUpdateScheduleData.schedule.map((item) =>
                        ScheduleData(
                          date: item.date!,
                          timeSlots: item.timeSlots ?? [],
                        )
                    ).toList(),
                  );

                  // طباعة البيانات للتأكد من شكلها (لأغراض التصحيح)
                  print('Sending data: ${scheduleToSend.toJson()}');

                  try {
                    await context.read<ScheduleCubit>().addUpdateSchedule(
                      userId,
                      token,
                      scheduleToSend,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save: ${e.toString()}')),
                    );
                  }
                },
                text: 'Save Schedule',
              ),
            ],
          ),
        ),
      ),
    );
  }
}