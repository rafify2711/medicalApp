import 'package:flutter/material.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';

import '../../../auth/presentation/view/widgets/button.dart';

class DoctorScheduleScreen extends StatefulWidget {
  static const routeName = 'add_doctor_schedule';

  @override
  _DoctorScheduleScreenState createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<String> schedule = [];
  int? _editingIndex; // null means we're adding a new one


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(), // today onwards
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

    final formatted = '${_formatDate(combinedDateTime)} at ${_formatTime(combinedDateTime)}';

    setState(() {
      if (_editingIndex != null) {
        schedule[_editingIndex!] = formatted; // update
        _editingIndex = null; // reset
      } else {
        schedule.add(formatted); // add new
      }
    });
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
    return Scaffold(
      appBar: MyAppPar(title: 'Schedule'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Selected Date: ${_formatDate(selectedDate)}',
              style: TextStyle(fontSize: 18,color: AppColors.primary),
            ),
            Text(
              'Selected Time: ${selectedTime.format(context)}',
              style: TextStyle(fontSize: 18,color: AppColors.primary),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Button(
                    onClick: () => _selectDate(context),
                    text: 'Pick Date',
                  ),
                  SizedBox(width: 16),
                  Button(
                    onClick: () => _selectTime(context),
                    text: 'Pick Time',
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(height: 20),
            Button(
              onClick: () => _addAppointment(),
              text: 'Add to schedule',
            ),
            SizedBox(height: 20),
            Text('Schedule:', style: TextStyle(fontSize: 18,color: AppColors.primary)),
            Expanded(
              child: ListView.builder(
                itemCount: schedule.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(schedule[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
