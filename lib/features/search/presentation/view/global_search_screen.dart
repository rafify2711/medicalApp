import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/config/route_names.dart';
import '../../../hospitals_and_pharmacies/models/hospital_model.dart';
import '../../../hospitals_and_pharmacies/models/pharmacy_model.dart';
import 'package:graduation_medical_app/core/models/doctor_model/doctor_model.dart';
import '../../../user_appointment/data/models/doctor_model/doctor_model.dart';
import '../../data/search_service.dart';
import '../view_model/search_cubit.dart';
import 'dart:async';
import '../../../../core/di/di.dart';
import '../../../../core/localization/app_localizations.dart';

class GlobalSearchScreen extends StatefulWidget {
  @override
  _GlobalSearchScreenState createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  Timer? _debounce;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<SearchCubit>();
        cubit.initialize();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                AppLocalizations.of(context).search,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).searchHint,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear, color: Colors.grey[400]),
                                  onPressed: () {
                                    _searchController.clear();
                                    context.read<SearchCubit>().clearSpecialtyFilter();
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Color(0xFF30948F), width: 1),
                          ),
                        ),
                        onChanged: (query) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(const Duration(milliseconds: 500), () {
                            setState(() => _isSearching = query.isNotEmpty);
                            context.read<SearchCubit>().search(query);
                          });
                        },
                      ),
                    ),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Color(0xFF30948F),
                      unselectedLabelColor: Colors.grey[600],
                      indicatorColor: Color(0xFF30948F),
                      tabs: [
                        Tab(text: AppLocalizations.of(context).specialties),
                        Tab(text: AppLocalizations.of(context).doctors),
                        Tab(text: AppLocalizations.of(context).hospitals),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: BlocConsumer<SearchCubit, SearchState>(
              listener: (context, state) {
                if (state is SearchError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF30948F)),
                    ),
                  );
                }

                if (state is SearchResults) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildSpecialtiesTab(state.specialties, state.selectedSpecialty),
                      _buildDoctorsTab(state.doctors),
                      _buildHospitalsTab(state.hospitals),
                    ],
                  );
                }

                return Center(
                  child: Text(AppLocalizations.of(context).startSearching),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Widget _buildSpecialtiesTab(List<String> specialties, String selectedSpecialty) {
    if (_isSearching && specialties.isEmpty) {
      return _buildEmptyState(AppLocalizations.of(context).noSpecialtiesFound, Icons.local_hospital_outlined);
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: specialties.length,
      itemBuilder: (context, index) {
        final specialty = specialties[index];
        final isSelected = specialty == selectedSpecialty;

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF30948F).withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Color(0xFF30948F) : Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: isSelected ? Color(0xFF30948F) : Colors.grey[100],
              radius: 25,
              child: Icon(
                Icons.medical_services_outlined,
                color: isSelected ? Colors.white : Color(0xFF30948F),
                size: 24,
              ),
            ),
            title: Text(
              specialty,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: isSelected ? Color(0xFF30948F) : Colors.black87,
              ),
            ),
            trailing: Icon(
              isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
              color: isSelected ? Color(0xFF30948F) : Colors.grey[400],
            ),
            onTap: () {
              if (isSelected) {
                context.read<SearchCubit>().clearSpecialtyFilter();
              } else {
                context.read<SearchCubit>().selectSpecialty(specialty);
                _tabController.animateTo(1); // Switch to doctors tab
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildDoctorsTab(List<DoctorsModel> doctors) {
    if (_isSearching && doctors.isEmpty) {
      return _buildEmptyState(AppLocalizations.of(context).noDoctorsFound, Icons.person_outline);
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return _buildDoctorCard(doctor);
      },
    );
  }

  Widget _buildHospitalsTab(List<Hospital> hospitals) {
    if (_isSearching && hospitals.isEmpty) {
      return _buildEmptyState(AppLocalizations.of(context).noHospitalsFound, Icons.local_hospital_outlined);
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
        return _buildHospitalCard(hospital);
      },
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(DoctorsModel doctor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25,
          child: Text(
            doctor.username?[0].toUpperCase() ?? 'D',
            style: TextStyle(
              color: Color(0xFF30948F),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        title: Text(
          doctor.username ?? 'Doctor',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          doctor.specialty ?? 'Specialist',
          style: TextStyle(
            color: Color(0xFF30948F),
            fontSize: 14,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.doctorDetails,
            arguments: doctor,
          );
        },
      ),
    );
  }

  Widget _buildHospitalCard(Hospital hospital) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 25,
          child: Text(
            hospital.name[0].toUpperCase(),
            style: TextStyle(
              color: Color(0xFF30948F),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        title: Text(
          hospital.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              hospital.type,
              style: TextStyle(
                color: Color(0xFF30948F),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey[400]),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    hospital.location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteNames.hospital,
            arguments: hospital,
          );
        },
      ),
    );
  }
} 