import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../view_model/make_reservation_cubit.dart';
import '../../view_model/make_reservation_state.dart';

class MakeReservationScreen extends StatefulWidget {
  final String? doctorId;
  final DateTime? selectedDate;

  const MakeReservationScreen({

     this.selectedDate,  this.doctorId,
  });

  @override
  _MakeReservationScreenState createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  String? _selectedTimeSlot;

  List<String> availableSlots = [
    "9:00 AM", "10:00 AM", "11:00 AM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"
  ];

  bool isAvailable(String slot) {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    if (slot.contains("PM") && currentHour > 12) {
      return false;
    } else if (slot.contains("AM") && currentHour >= 9) {
      return false;
    }
    return true;
  }

  void _makeReservation(BuildContext context) async {
    final cubit = context.read<CreateReservationCubit>();

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not found")),
      );
      return;
    }

    final reservationData = ReservationDataModel(
      doctorId: widget.doctorId??"",
      userId: userId,
      date: widget.selectedDate?? DateTime.now(),
      timeSlot: _selectedTimeSlot,
    );

    cubit.createReservation(reservationData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a Reservation"),
      ),
      body: BlocConsumer<CreateReservationCubit, CreateReservationState>(
        listener: (context, state) {
          if (state is CreateReservationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Reservation successful")),
            );
            Navigator.pop(context, _selectedTimeSlot);
          } else if (state is CreateReservationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Doctor: ${widget.doctorId}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),

                SizedBox(height: 16),
                Text(
                  "Select Date: ${widget.selectedDate?.toLocal().toString().split(' ')[0]}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text("Available Time Slots",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableSlots.length,
                    itemBuilder: (context, index) {
                      String slot = availableSlots[index];
                      bool available = isAvailable(slot);
                      return ListTile(
                        title: Text(slot),
                        leading: Radio<String>(
                          value: slot,
                          groupValue: _selectedTimeSlot,
                          onChanged: available
                              ? (String? value) {
                            setState(() {
                              _selectedTimeSlot = value;
                            });
                          }
                              : null,
                        ),
                        tileColor: available ? Colors.grey[300] : null,
                      );
                    },
                  ),
                ),
                Center(
                  child: state is CreateReservationLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _selectedTimeSlot == null
                        ? null
                        : () => _makeReservation(context),
                    child: Text("Make Reservation"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
