import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_medical_app/features/user_appointment/presentation/view_model/available_slots_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/models/appointment_model/reservation_data_model.dart';
import '../../view_model/available_slots_state.dart';
import '../../view_model/make_reservation_cubit.dart';
import '../../view_model/make_reservation_state.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/localization/app_localizations.dart';

class MakeReservationScreen extends StatefulWidget {
  final String? doctorId;
  final DateTime? selectedDate;

  const MakeReservationScreen({
    Key? key,
    required this.doctorId,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _MakeReservationScreenState createState() => _MakeReservationScreenState();
}

class _MakeReservationScreenState extends State<MakeReservationScreen> {
  String? _selectedTimeSlot;
  String _patientType = 'Yourself';
  String _gender = 'Male';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _problemController = TextEditingController();
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    if (widget.doctorId == null || widget.selectedDate == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).missingInfo),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      });
    } else {
      _fetchAvailableSlots();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  void _fetchAvailableSlots() {
    if (widget.doctorId != null && widget.selectedDate != null) {
      final formattedDate = "${widget.selectedDate!.year}-${widget.selectedDate!.month.toString().padLeft(2, '0')}-${widget.selectedDate!.day.toString().padLeft(2, '0')}";
      context.read<AvailableSlotsCubit>().loadAvailableSlots(
        DateTime.parse(formattedDate),
        widget.doctorId!,
      );
    }
  }

  Future<void> _handleReservation() async {
    if (_isNavigating) return;

    if (_selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).selectTimeSlot),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_nameController.text.isEmpty || _ageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).missingInfo),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).userNotFound),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final formattedDate = "${widget.selectedDate!.year}-${widget.selectedDate!.month.toString().padLeft(2, '0')}-${widget.selectedDate!.day.toString().padLeft(2, '0')}";

    final reservationData = ReservationDataModel(
      doctorId: widget.doctorId!,
      userId: userId,
      date: DateTime.parse(formattedDate),
      timeSlot: _selectedTimeSlot!,
    );

    setState(() {
      _isNavigating = true;
    });

    try {
      await context.read<CreateReservationCubit>().createReservation(reservationData);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).reservationSuccess),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true); // Return true to indicate successful reservation
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isNavigating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).makeReservation),
        backgroundColor: AppColors.primary1,
      ),
      body: BlocConsumer<CreateReservationCubit, CreateReservationState>(
        listener: (context, state) {
          if (state is CreateReservationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context).reservationSuccess),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is CreateReservationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CreateReservationLoading || _isNavigating;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20), // Kept this as it was a separate request
                // Selected Date
                Text(
                  AppLocalizations.of(context).selectedDate,
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.selectedDate != null
                        ? "${widget.selectedDate!.toLocal().toString().split(' ')[0]}"
                        : AppLocalizations.of(context).noDateSelected,
                    style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary1),
                  ),
                ),
                SizedBox(height: 20),
                // Available Time
                Text(
                  AppLocalizations.of(context).availableTime,
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 10),
                BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
                  builder: (context, state) {
                    if (state is AvailableSlotsLoadingState) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                            color: AppColors.primary1,
                          ),
                        ),
                      );
                    } else if (state is AvailableSlotsErrorState) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else if (state is AvailableSlotsLoadedState) {
                      if (state.availableSlots.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              AppLocalizations.of(context).noAvailableSlots,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: state.availableSlots.map((slot) {
                          final isSelected = _selectedTimeSlot == slot;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTimeSlot = slot;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: isSelected ? AppStyle.gradient : null,
                                color: isSelected ? null : AppColors.primary1.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                slot,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : AppColors.primary1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          AppLocalizations.of(context).noAvailableSlots,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24),
                // Patient Details
                Text(
                  AppLocalizations.of(context).patientDetails,
                  style: AppStyle.titlesTextStyle.copyWith(fontSize: 16, color: AppColors.primary1),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _buildToggleButton(AppLocalizations.of(context).yourself, _patientType == 'Yourself', () {
                      setState(() => _patientType = 'Yourself');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton(AppLocalizations.of(context).anotherPerson, _patientType == 'Another Person', () {
                      setState(() => _patientType = 'Another Person');
                    }),
                  ],
                ),
                SizedBox(height: 16),
                // Full Name
                _buildTextField(_nameController, AppLocalizations.of(context).fullName),
                SizedBox(height: 12),
                // Age
                _buildTextField(_ageController, AppLocalizations.of(context).age, keyboardType: TextInputType.number),
                SizedBox(height: 12),
                // Gender
                Text(AppLocalizations.of(context).gender, style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary1)),
                SizedBox(height: 8),
                Row(
                  children: [
                    _buildToggleButton(AppLocalizations.of(context).male, _gender == 'Male', () {
                      setState(() => _gender = 'Male');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton(AppLocalizations.of(context).female, _gender == 'Female', () {
                      setState(() => _gender = 'Female');
                    }),
                    SizedBox(width: 10),
                    _buildToggleButton(AppLocalizations.of(context).other, _gender == 'Other', () {
                      setState(() => _gender = 'Other');
                    }),
                  ],
                ),
                SizedBox(height: 18),
                // Problem Description
                Text(AppLocalizations.of(context).describeProblem, style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary1)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary1.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _problemController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).enterProblem,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleReservation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary1,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppLocalizations.of(context).confirmReservation,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.primary1)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary1.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isSelected ? AppStyle.gradient : null,
          color: isSelected ? null : AppColors.primary1.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.primary1,
          ),
        ),
      ),
    );
  }
}
