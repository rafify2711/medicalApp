
import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/extentions/extentions.dart';
import 'package:graduation_medical_app/core/utils/widgets/feature_widget/features.dart';
import 'package:graduation_medical_app/features/auth/presentation/view/widgets/my_app_par.dart';
import 'package:graduation_medical_app/features/reservation/presentation/view/add_doctor_scadule.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../chat_bot/presentation/view/chatbot_screen.dart';
import '../../medical_dignosis/presentation/view/disease_prediction_list_screen.dart';
import '../../user_appointment/presentation/view/user_appointment_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  List months = [
    '0',
    'jan',
    'feb',
    'mar',
    'april',
    'may',
    'jun',
    'july',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];
  DateTime selectedCalenderDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: MyAppPar(title: "doctor"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              buildCalender(),
              const SizedBox(height: 24),
              const Text(
                'Features',
                style: AppStyle.titlesTextStyle,
              ),
              const SizedBox(height: 16),
              
              GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [ FeatureCard(icon:  Icons.medical_services, label: 'Diagnosis', routeName: RouteNames.diseasePredictionList,),
                  FeatureCard(icon: Icons.people, label: 'Doctors', routeName: ''),
                  FeatureCard(icon: Icons.insert_chart, label: 'Report', routeName: ''),
                  FeatureCard(icon: Icons.calendar_today, label: 'Schedule', routeName: RouteNames.doctorSchedule),
                  FeatureCard(icon: Icons.chat, label: 'Chat Bot', routeName: RouteNames.chatbot),
                  FeatureCard(icon: Icons.chrome_reader_mode_outlined, label: 'Perception', routeName: ''),],
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget buildCalender() {
    return Container(
      decoration: BoxDecoration(gradient: AppStyle.gradient,borderRadius: BorderRadius.circular(12)),
      
      height: 350,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(Duration(days: 30)),
            focusDate: selectedCalenderDate,
            headerBuilder:
                (context, date) =>
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          'upcoming schedule',
                          style: AppStyle.bodyWhiteTextStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Text(
                          months[selectedCalenderDate.month].toString(),
                          style: AppStyle.bodyWhiteTextStyle.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 7,

                      color: AppColors.white,
                    ),
                    SizedBox(height: 10),
                  ],
                ),

            lastDate: DateTime.now().add(Duration(days: 30)),
            onDateChange: (selectedDate) {
              setState(() => selectedCalenderDate = selectedDate);
            },
            itemBuilder:
                (context, date, isSelected, onTap) =>
                GestureDetector(
                  onTap: () => setState(() => selectedCalenderDate = date),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.white),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                          40, // Set your desired height for the first text
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              color:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20, // Adjust the height for the second text
                          child: Text(
                            date.dayName,
                            style: TextStyle(
                              color:
                              isSelected
                                  ? AppColors.primary
                                  : AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
          SizedBox(height: 20),
          Container(
            height: 160,
            width: MediaQuery
                .of(context)
                .size
                .width * .9,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.white),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Appointments',
                    style: AppStyle.titlesTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12,bottom: 12),
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return _buildAppointmentItem(index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildAppointmentItem(int index) {
    return Container(height :80,
      width: double.infinity,
      // Make the item take the full container width
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient Name ${index + 1}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                '10:00 AM - 11:00 AM',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),

            ],
          ),  const SizedBox(height: 4),  Divider(height: 1,color: Colors.white,)
        ],
      ),
    );
  }
}