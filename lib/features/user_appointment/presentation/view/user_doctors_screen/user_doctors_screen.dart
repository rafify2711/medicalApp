import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/user_doctors_screen/make_reservation_screen.dart';
import 'package:table_calendar/table_calendar.dart';  // Import table_calendar package
import '../../../../../core/config/route_names.dart';
import '../../../../../core/models/doctor_model/doctor_model.dart';
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
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: '${widget.doctor.username}'),
      body: SingleChildScrollView(  // Wrap the whole body inside a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(  // Center widget to align content in the middle
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,  // Center content horizontally
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.doctor.profilePhoto ?? ""),
                  radius: 60,
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
                TableCalendar(
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
                  calendarStyle: CalendarStyle(),
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay; // update `_focusedDay` here as well
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 20),
                // Add a button to make a reservation
                Button(
                  onClick: () {
                    print("------------------------------${widget.doctor.id}");
                    print("------------------------------${_selectedDay}");
                    // Navigate to the reservation screen and pass the selected date
                    Navigator.pushNamed(
                      context,
                      RouteNames.makeReservation, // The route name of the reservation screen
                      arguments: {
                        'doctorId': widget.doctor.id,
                        'selectedDay': _selectedDay,
                      },

                      // Passing the selected date
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
