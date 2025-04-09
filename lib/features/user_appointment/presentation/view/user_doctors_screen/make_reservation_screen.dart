import 'package:flutter/material.dart';

class MakeReservationScreen extends StatefulWidget {
  static const String routeName = 'make_reservation_screen.dart';
  final String doctorName;
  final String doctorSpecialty;
  final DateTime selectedDate;

  const MakeReservationScreen({
    required this.doctorName,
    required this.doctorSpecialty,
    required this.selectedDate,
  });

  @override
  _MakeReservationScreenState createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  String? _selectedTimeSlot; // Track the selected time slot

  // Static available time slots for demonstration
  List<String> availableSlots = [
    "9:00 AM", "10:00 AM", "11:00 AM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"
  ];

  // Sample logic to disable certain slots (for example, disable past slots)
  bool isAvailable(String slot) {
    // Implement your logic here for available slots. For example, you can disable past times.
    // This is just an example and assumes that slots after 1 PM are unavailable.
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    if (slot.contains("PM") && currentHour > 12) {
      return false;
    } else if (slot.contains("AM") && currentHour >= 9) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make a Reservation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Name and Specialty
            Text(
              "Doctor: ${widget.doctorName}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Specialty: ${widget.doctorSpecialty}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Select Date: ${widget.selectedDate.toLocal().toString().split(' ')[0]}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Available Time Slots",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Displaying available time slots with Radio buttons for selection
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
                          : null, // Disable selection if slot is unavailable
                    ),
                    tileColor: !available
                        ? Colors.grey[300] // Gray out unavailable slots
                        : null,
                  );
                },
              ),
            ),

            // Make Reservation Button
            Center(
              child: ElevatedButton(
                onPressed: _selectedTimeSlot == null
                    ? null // Disable the button if no time slot is selected
                    : () {
                  // Proceed to confirm reservation with the selected slot
                  // You can pass the selected date and time slot to your reservation confirmation screen
                  Navigator.pop(context, _selectedTimeSlot); // Pass the selected time slot
                },
                child: Text("Make Reservation"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
