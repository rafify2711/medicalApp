import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view/widgets/Custom_calinder.dart';
import 'package:table_calendar/table_calendar.dart';  // Import table_calendar package
import '../../../../../core/config/route_names.dart';
import '../../../../../core/models/doctor_model/doctor_model.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/localization/app_localizations.dart';
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
  late DateTime selectedDate = DateTime.now(); // Initialize selectedDate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppPar(title: AppLocalizations.of(context).doctorProfile),
      body: SingleChildScrollView(  // Wrap the whole body inside a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                          image: NetworkImage(
                            (widget.doctor.profilePhoto != null && (widget.doctor.profilePhoto!.startsWith('http://') || widget.doctor.profilePhoto!.startsWith('https://')))
                                ? widget.doctor.profilePhoto!
                                : 'https://i.imgur.com/3Y1J2TFG.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.doctor.username ?? '',
                      style: AppStyle.titlesTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.doctor.specialty ?? '',
                      style: AppStyle.bodyBlackTextStyle.copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildInfoChip(
                          Icons.medical_services,
                          '${widget.doctor.experience ?? '0'} ${AppLocalizations.of(context).experienceYears}',
                        ),
                        SizedBox(width: 10),
                        _buildInfoChip(
                          Icons.access_time,
                          'Mon-Sat / 9:00AM - 5:00PM', // Placeholder, you might want to fetch this from schedule
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              _buildSectionTitle(AppLocalizations.of(context).focus),
              SizedBox(height: 8),
              Text(
                widget.doctor.bio ?? AppLocalizations.of(context).noBioAvailable,
                style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
              ),
              SizedBox(height: 24),
              _buildSectionTitle(AppLocalizations.of(context).profile),
              SizedBox(height: 8),
              Text(
                widget.doctor.bio ?? AppLocalizations.of(context).noBioAvailable,
                style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
              ),
              SizedBox(height: 24),
              _buildSectionTitle(AppLocalizations.of(context).careerPath),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.doctor.careerPath?.map<Widget>((path) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '- ${path}',
                    style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                )).toList() ?? [Text(AppLocalizations.of(context).noCareerPath)],
              ),
              SizedBox(height: 24),
              _buildSectionTitle(AppLocalizations.of(context).highlights),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.doctor.highlights?.map<Widget>((highlight) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    '- ${highlight}',
                    style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
                  ),
                )).toList() ?? [Text(AppLocalizations.of(context).noHighlights)],
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
                  // Format the date to YYYY-MM-DD
                  final formattedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                  );
                  // Navigate to the reservation screen and pass the selected date and doctor
                  Navigator.pushNamed(
                    context,
                    RouteNames.makeReservation,
                    arguments: {
                      'doctorId': widget.doctor.id,
                      'selectedDate': formattedDate,
                      'doctor': widget.doctor, // Pass the doctor object
                    },
                  );
                },
                text: AppLocalizations.of(context).makeReservation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for info chips (experience, schedule)
  Widget _buildInfoChip(IconData icon, String text) {
    return Chip(
      label: Text(
        text,
        style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
      ),
      backgroundColor: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      avatar: Icon(
        icon,
        color: Colors.grey,
        size: 16,
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary),
    );
  }
}
