import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/widgets/Custom_calinder.dart';
import 'package:table_calendar/table_calendar.dart';  // Import table_calendar package
import '../../../../../core/config/route_names.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../auth/presentation/view/widgets/button.dart';
import '../../../../auth/presentation/view/widgets/my_app_par.dart';
import '../../../data/models/doctor_model/doctor_model.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorsModel doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  _DoctorDetailsScreenState createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: '${widget.doctor.username}'),
      body: SingleChildScrollView(  // Wrap the whole body inside a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(  // Center widgets to align content in the middle
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,  // Center content horizontally
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 60,
                  child: Text(
                    widget.doctor.username?.isNotEmpty == true
                        ? widget.doctor.username![0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.doctor.username!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(widget.doctor.specialty!, style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Text(
                  "Doctor bio or additional info goes here...",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Add the TableCalendar here
                CustomCalendar(
                  initialDate: DateTime.now(),
                  onDateSelected: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Add a button to make a reservation
                Button(
                  onClick: () {
                    print("------------------------------${widget.doctor.id}");
                    print("------------------------------${selectedDate}");
                    // Format the date to YYYY-MM-DD
                    final formattedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    );
                    // Navigate to the reservation screen and pass the selected date
                    Navigator.pushNamed(
                      context,
                      RouteNames.makeReservation,
                      arguments: {
                        'doctorId': widget.doctor.id,
                        'selectedDate': formattedDate,
                      },
                    );
                  },
                  text: "Make a Reservation",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
