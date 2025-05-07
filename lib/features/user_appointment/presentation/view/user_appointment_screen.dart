import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/widgets/doctor_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../view_model/user_appointment_cubit.dart';
import '../view_model/user_appointment_state.dart';

class UserAppointmentScreen extends StatefulWidget {


  @override
  _UserAppointmentScreenState createState() => _UserAppointmentScreenState();
}

class _UserAppointmentScreenState extends State<UserAppointmentScreen> {
  int selectedIndex = 1; // start with Upcoming
  String? userId;
  String? token;

  @override
  void initState() {
    super.initState();
    _loadUserIdAndFetchAppointments();
  }

  Future<void> _loadUserIdAndFetchAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    token = prefs.getString("token");
    print('token:$token');

    if (userId != null) {
      context.read<UserAppointmentCubit>().fetchAppointments(userId!,token!);
    } else {
      print("User ID not found in SharedPreferences!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: 'Appointments'),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildTabs(),
          Expanded(
            child: BlocBuilder<UserAppointmentCubit, UserAppointmentState>(
              builder: (context, state) {
                if (state is AppointmentLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AppointmentLoaded) {
                  final completed = state.appointments.reservations
                      .where((a) => a.status.toLowerCase() == "completed")
                      .toList();
                  final upcoming = state.appointments.reservations
                      .where((a) => a.status.toLowerCase() == "confirmed")
                      .toList();
                  final cancelled = state.appointments.reservations
                      .where((a) => a.status.toLowerCase() == "cancelled")
                      .toList();

                  final lists = [completed, upcoming, cancelled];

                  if (lists[selectedIndex].isEmpty) {
                    return Center(child: Text("No appointments"));
                  }

                  return ListView.builder(
                    itemCount: lists[selectedIndex].length,
                    itemBuilder: (context, index) {
                      final appointment = lists[selectedIndex][index];
                      return AppointmentCard(appointment: appointment);
                    },
                  );
                } else if (state is AppointmentError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text("No data"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabs() {
    List<String> tabs = ["Complete", "Upcoming", "Cancelled"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(tabs.length, (index) {
        return ChoiceChip(

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          label: Text(tabs[index]),
          selected: selectedIndex == index,
          selectedColor: AppColors.primary1,
          onSelected: (bool selected) {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      }),
    );
  }
}
