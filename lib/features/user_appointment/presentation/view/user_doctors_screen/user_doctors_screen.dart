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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDoctorHeader(),
                      const SizedBox(height: 24),
                      _buildDoctorInfo(),
                      const SizedBox(height: 24),
                      _buildCalendar(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Button(
                onClick: () {
                  final formattedDate = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                  );
                  Navigator.pushNamed(
                    context,
                    RouteNames.makeReservation,
                    arguments: {
                      'doctorId': widget.doctor.id,
                      'selectedDate': formattedDate,
                      'doctor': widget.doctor,
                    },
                  );
                },
                text: AppLocalizations.of(context).makeReservation,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width:100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              image: DecorationImage(
                image: NetworkImage(
                  (widget.doctor.profilePhoto != null && (widget.doctor.profilePhoto!.startsWith('http://') || widget.doctor.profilePhoto!.startsWith('https://')))
                      ? widget.doctor.profilePhoto!
                      : 'https://t3.ftcdn.net/jpg/05/79/55/26/240_F_579552668_sZD51Sjmi89GhGqyF27pZcrqyi7cEYBH.jpg',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.doctor.username ?? '',
            style: AppStyle.titlesTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary1),
          ),
          const SizedBox(height: 4),
          Text(
            widget.doctor.specialty ?? '',
            style: AppStyle.bodyBlackTextStyle.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoChip(
                Icons.medical_services,
                '${widget.doctor.experience ?? '0'} ${AppLocalizations.of(context).experienceYears}',
              ),

            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(AppLocalizations.of(context).bio),
        const SizedBox(height: 8),
        Text(
          widget.doctor.bio ?? AppLocalizations.of(context).noBioAvailable,
          style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle(AppLocalizations.of(context).profile),
        const SizedBox(height: 8),
        Text(
          widget.doctor.bio ?? AppLocalizations.of(context).noBioAvailable,
          style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle(AppLocalizations.of(context).careerPath),
        const SizedBox(height: 8),
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
        const SizedBox(height: 24),
        _buildSectionTitle(AppLocalizations.of(context).highlights),
        const SizedBox(height: 8),
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
      ],
    );
  }

  Widget _buildCalendar() {
    return CustomCalendar(
      initialDate: DateTime.now(),
      onDateSelected: (DateTime date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }

  // Helper method for info chips (experience, schedule)
  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100),
      child: Chip(
        label: Flexible(
          child: Text(
            text,
            style: AppStyle.bodyBlackTextStyle.copyWith(color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        backgroundColor: Colors.white54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        avatar: Icon(
          icon,
          color: Colors.grey,
          size: 16,
        ),
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
    );
  }
}
