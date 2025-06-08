import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/core/config/route_names.dart';
import 'package:graduation_medical_app/core/utils/app_colors.dart';
import 'package:graduation_medical_app/core/utils/app_style.dart';
import 'package:graduation_medical_app/features/doctor_profile/presentation/view_model/doctor_profile_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/localization/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileScreen extends StatelessWidget {
  final String userId;

  const DoctorProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorProfileCubit>()..fetchDoctorProfile(userId),
      child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is DoctorProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DoctorProfileLoaded) {
            final profile = state.profile;
            return Scaffold(
              backgroundColor: AppColors.primary1.withOpacity(0.05),
              body: Column(
                children: [
                  // Gradient Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 60, bottom: 24),
                    decoration: BoxDecoration(
                      gradient: AppStyle.gradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Back button and title
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).doctorProfile,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () async{
                                await Navigator.pushNamed(
                                  context,
                                  RouteNames.editDoctorProfile,
                                  arguments: profile,
                                );
                                context.read<DoctorProfileCubit>().fetchDoctorProfile(userId);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Avatar
                        if (profile.profilePhoto != null && profile.profilePhoto!.startsWith('http'))
                          CircleAvatar(
                            radius: 44,
                            backgroundImage: NetworkImage(profile.profilePhoto!),
                            backgroundColor: Colors.white,
                          )
                        else
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.white,
                            child: Text(
                              profile.username?.isNotEmpty == true ? profile.username![0].toUpperCase() : 'D',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary1,
                              ),
                            ),
                          ),
                        SizedBox(height: 12),
                        Text(
                          profile.username ?? profile.name ?? AppLocalizations.of(context).doctor,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          profile.specialty ?? AppLocalizations.of(context).specialty,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          profile.email ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          profile.phone ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        if (profile.experience != null)
                          Text(
                            '${profile.experience} ${AppLocalizations.of(context).experienceYears}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Profile Information
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoCard(
                              title: AppLocalizations.of(context).personalInfo,
                              children: [
                                _buildInfoRow(Icons.email, AppLocalizations.of(context).email, profile.email ?? AppLocalizations.of(context).notProvided),
                                _buildInfoRow(Icons.phone, AppLocalizations.of(context).phone, profile.contact!.phone ?? AppLocalizations.of(context).notProvided),
                                _buildInfoRow(Icons.person, AppLocalizations.of(context).gender, profile.gender ?? AppLocalizations.of(context).notProvided),
                              ],
                            ),
                            SizedBox(height: 16),
                            _buildInfoCard(
                              title: AppLocalizations.of(context).professionalInfo,
                              children: [
                                _buildInfoRow(Icons.medical_services, AppLocalizations.of(context).specialty, profile.specialty ?? AppLocalizations.of(context).notProvided),
                                _buildInfoRow(Icons.school, AppLocalizations.of(context).education, AppLocalizations.of(context).notProvided),
                                _buildInfoRow(Icons.work, AppLocalizations.of(context).experience, profile.experience?.toString() ?? AppLocalizations.of(context).notProvided),
                                _buildInfoRow(Icons.info, AppLocalizations.of(context).bio, profile.bio ?? AppLocalizations.of(context).notProvided),
                              ],
                            ),
                            SizedBox(height: 16),
                            if (profile.careerPath != null && profile.careerPath!.isNotEmpty)
                              _buildInfoCard(
                                title: AppLocalizations.of(context).careerPath,
                                children: profile.careerPath!.map<Widget>((item) => _buildInfoRow(Icons.timeline, '', item.toString())).toList(),
                              ),
                            if (profile.highlights != null && profile.highlights!.isNotEmpty)
                              _buildInfoCard(
                                title: AppLocalizations.of(context).highlights,
                                children: profile.highlights!.map<Widget>((item) => _buildInfoRow(Icons.star, '', item.toString())).toList(),
                              ),
                            SizedBox(height: 16),
                            _buildInfoCard(
                              title: 'روابط التواصل',
                              children: [
                                if (profile.contact != null && profile.contact!.facebook != null && profile.contact!.facebook!.isNotEmpty)
                                  _buildContactLink(context, Icons.facebook, 'Facebook', profile.contact!.facebook!),
                                if (profile.contact != null && profile.contact!.linkedin != null && profile.contact!.linkedin!.isNotEmpty)
                                  _buildContactLink(context, Icons.link, 'LinkedIn', profile.contact!.linkedin!),
                                if (profile.contact != null && profile.contact!.twitter != null && profile.contact!.twitter!.isNotEmpty)
                                  _buildContactLink(context, Icons.alternate_email, 'Twitter', profile.contact!.twitter!),
                                if (profile.contact != null && profile.contact!.website != null && profile.contact!.website!.isNotEmpty)
                                  _buildContactLink(context, Icons.language, 'Website', profile.contact!.website!),
                                if (profile.contact != null && profile.contact!.whatsapp != null && profile.contact!.whatsapp!.isNotEmpty)
                                  _buildContactLink(context, Icons.chat, 'WhatsApp', profile.contact!.whatsapp!),
                                if (profile.contact != null && profile.contact!.phone != null && profile.contact!.phone!.isNotEmpty)
                                  _buildContactLink(context, Icons.phone, 'Phone', profile.contact!.phone!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DoctorProfileError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(AppLocalizations.of(context).noData));
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary1,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary1.withOpacity(0.1),
            ),
            child: Icon(icon, color: AppColors.primary1, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactLink(BuildContext context, IconData icon, String label, String url) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          if (label == 'Phone') {
            final uri = Uri.parse('tel:$url');
            await launchUrl(uri);
          } else if (label == 'WhatsApp') {
            final uri = Uri.parse('https://wa.me/$url');
            await launchUrl(uri);
          } else {
            final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
            await launchUrl(uri);
          }
        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary1.withOpacity(0.1),
              ),
              child: Icon(icon, color: AppColors.primary1, size: 22),
            ),
            SizedBox(width: 12),
            Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                url,
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 